using BlazorAGS.Models;
using QuestPDF.Fluent;
using QuestPDF.Helpers;
using QuestPDF.Infrastructure;

namespace BlazorAGS.Services
{
    public class ReportePdfService
    {
        public ReportePdfService()
        {
            // QuestPDF Community License (gratis para proyectos open source / personales)
            QuestPDF.Settings.License = LicenseType.Community;
        }

        public byte[] GenerarReporteGeneral(ReporteData data)
        {
            var pdf = Document.Create(container =>
            {
                container.Page(page =>
                {
                    page.Margin(36);
                    page.Size(PageSizes.A4);
                    page.DefaultTextStyle(x => x.FontFamily("Arial").FontSize(10).FontColor(Colors.Grey.Darken3));

                    // ─── HEADER ────────────────────────────────────────────────────────
                    page.Header().Element(header =>
                    {
                        header.Row(row =>
                        {
                            row.RelativeItem().Column(col =>
                            {
                                col.Item().Text("AGS SELECT").Bold().FontSize(22).FontColor(Colors.Red.Darken2);
                                col.Item().Text("Detailing & Car Wash Premium").FontSize(9).FontColor(Colors.Grey.Medium);
                                col.Item().PaddingTop(4).Text($"Reporte Generado: {data.FechaGeneracion:dd/MM/yyyy HH:mm}").FontSize(8).FontColor(Colors.Grey.Medium);
                            });
                            row.ConstantItem(120).AlignRight().Column(col =>
                            {
                                col.Item().Text(data.TituloReporte).Bold().FontSize(13).FontColor(Colors.Grey.Darken3);
                                col.Item().Text($"Período: {data.PeriodoDescripcion}").FontSize(8).FontColor(Colors.Grey.Medium);
                            });
                        });
                    });

                    // ─── CONTENT ───────────────────────────────────────────────────────
                    page.Content().PaddingTop(16).Column(col =>
                    {
                        // Línea separadora
                        col.Item().PaddingBottom(16).LineHorizontal(2).LineColor(Colors.Red.Darken2);

                        // SECCIÓN 1 – KPIs PRINCIPALES
                        col.Item().PaddingBottom(12).Text("RESUMEN EJECUTIVO").Bold().FontSize(12).FontColor(Colors.Red.Darken2);

                        col.Item().PaddingBottom(16).Row(kpiRow =>
                        {
                            KpiCard(kpiRow, "INGRESOS TOTALES", $"RD$ {data.IngresosTotales:N2}", Colors.Green.Darken2);
                            KpiCard(kpiRow, "CITAS TOTALES", data.TotalReservas.ToString(), Colors.Blue.Darken2);
                            KpiCard(kpiRow, "CITAS COMPLETADAS", data.TotalCompletadas.ToString(), Colors.Teal.Darken2);
                            KpiCard(kpiRow, "TASA COMPLETADO", $"{data.TasaCompletado:F1}%", Colors.Purple.Darken2);
                        });

                        // SECCIÓN 2 – DESGLOSE POR ESTADO
                        col.Item().PaddingBottom(12).Text("DESGLOSE POR ESTADO").Bold().FontSize(11).FontColor(Colors.Red.Darken2);

                        col.Item().PaddingBottom(16).Table(table =>
                        {
                            table.ColumnsDefinition(cols =>
                            {
                                cols.RelativeColumn(3);
                                cols.RelativeColumn(2);
                                cols.RelativeColumn(2);
                                cols.RelativeColumn(3);
                            });

                            // Encabezados
                            TableHeader(table, new[] { "Estado", "Cantidad", "% del Total", "Ingresos" });

                            // Filas de datos
                            TableRow(table, "PENDIENTE", data.CantPendientes.ToString(),
                                $"{Pct(data.CantPendientes, data.TotalReservas)}%", "-", Colors.Yellow.Darken2, Colors.Yellow.Lighten5);

                            TableRow(table, "APROBADO", data.CantAprobadas.ToString(),
                                $"{Pct(data.CantAprobadas, data.TotalReservas)}%",
                                $"RD$ {data.IngresosAprobados:N2}", Colors.Green.Darken2, Colors.Green.Lighten5);

                            TableRow(table, "COMPLETADO", data.CantCompletadas.ToString(),
                                $"{Pct(data.CantCompletadas, data.TotalReservas)}%",
                                $"RD$ {data.IngresosCompletados:N2}", Colors.Blue.Darken2, Colors.Blue.Lighten5);

                            TableRow(table, "CANCELADO", data.CantCanceladas.ToString(),
                                $"{Pct(data.CantCanceladas, data.TotalReservas)}%", "-", Colors.Red.Darken2, Colors.Red.Lighten5);
                        });

                        // SECCIÓN 3 – SERVICIOS MÁS SOLICITADOS
                        col.Item().PaddingBottom(12).Text("SERVICIOS MÁS SOLICITADOS").Bold().FontSize(11).FontColor(Colors.Red.Darken2);

                        col.Item().PaddingBottom(16).Table(table =>
                        {
                            table.ColumnsDefinition(cols =>
                            {
                                cols.ConstantColumn(30);
                                cols.RelativeColumn(5);
                                cols.RelativeColumn(2);
                                cols.RelativeColumn(2);
                            });

                            TableHeader(table, new[] { "#", "Servicio", "Citas", "% Popular" });

                            int rank = 1;
                            foreach (var s in data.ServiciosPopulares)
                            {
                                var pct = Pct(s.Cantidad, data.TotalDetalles);
                                bool isEven = rank % 2 == 0;
                                var bg = isEven ? Colors.Grey.Lighten4 : Colors.White;

                                table.Cell().Background(bg).PaddingVertical(5).PaddingHorizontal(6)
                                    .Text($"{rank}").FontColor(Colors.Grey.Darken2).FontSize(9);
                                table.Cell().Background(bg).PaddingVertical(5).PaddingHorizontal(6)
                                    .Text(s.NombreServicio).FontColor(Colors.Grey.Darken3).FontSize(9).Bold();
                                table.Cell().Background(bg).PaddingVertical(5).PaddingHorizontal(6)
                                    .Text(s.Cantidad.ToString()).FontColor(Colors.Grey.Darken3).FontSize(9);
                                table.Cell().Background(bg).PaddingVertical(5).PaddingHorizontal(6)
                                    .Text($"{pct}%").FontColor(Colors.Red.Darken2).FontSize(9).Bold();
                                rank++;
                            }
                        });

                        // SECCIÓN 4 – LISTADO DE RESERVAS
                        if (data.Reservas.Any())
                        {
                            col.Item().PaddingBottom(12).Text("LISTADO DE RESERVAS").Bold().FontSize(11).FontColor(Colors.Red.Darken2);

                            col.Item().Table(table =>
                            {
                                table.ColumnsDefinition(cols =>
                                {
                                    cols.ConstantColumn(32);  // ID
                                    cols.RelativeColumn(3);   // Cliente
                                    cols.RelativeColumn(2);   // Fecha
                                    cols.RelativeColumn(2);   // Estado
                                    cols.RelativeColumn(2);   // Monto
                                });

                                TableHeader(table, new[] { "#ID", "Cliente", "Fecha", "Estado", "Monto" });

                                bool even = false;
                                foreach (var r in data.Reservas.OrderByDescending(x => x.FechaReserva))
                                {
                                    var bg = even ? Colors.Grey.Lighten4 : Colors.White;
                                    even = !even;

                                    table.Cell().Background(bg).PaddingVertical(4).PaddingHorizontal(5)
                                        .Text($"#{r.Id}").FontColor(Colors.Red.Darken2).FontSize(8).Bold();
                                    table.Cell().Background(bg).PaddingVertical(4).PaddingHorizontal(5)
                                        .Text(r.ClienteNombre).FontColor(Colors.Grey.Darken3).FontSize(8);
                                    table.Cell().Background(bg).PaddingVertical(4).PaddingHorizontal(5)
                                        .Text(r.FechaReserva.ToString("dd/MM/yy HH:mm")).FontColor(Colors.Grey.Darken3).FontSize(8);
                                    table.Cell().Background(bg).PaddingVertical(4).PaddingHorizontal(5)
                                        .Text(r.Estado.ToUpper()).FontColor(EstadoColor(r.Estado)).FontSize(8).Bold();
                                    table.Cell().Background(bg).PaddingVertical(4).PaddingHorizontal(5)
                                        .Text($"RD$ {r.MontoTotal:N2}").FontColor(Colors.Grey.Darken3).FontSize(8);
                                }
                            });
                        }
                    });

                    // ─── FOOTER ────────────────────────────────────────────────────────
                    page.Footer().AlignCenter().Text(t =>
                    {
                        t.DefaultTextStyle(x => x.FontSize(8).FontColor(Colors.Grey.Medium));
                        t.Span("AGS SELECT | Reporte confidencial generado automáticamente | Pág. ");
                        t.CurrentPageNumber();
                        t.Span(" de ");
                        t.TotalPages();
                    });
                });
            });

            return pdf.GeneratePdf();
        }

        // ──────────────── HELPERS ────────────────────────────────────────────────────

        private void KpiCard(RowDescriptor row, string label, string value, string color)
        {
            row.RelativeItem().Border(1).BorderColor(Colors.Grey.Lighten3).Padding(10).Column(c =>
            {
                c.Item().Text(label).FontSize(7).FontColor(Colors.Grey.Medium).Bold();
                c.Item().PaddingTop(4).Text(value).FontSize(14).Bold().FontColor(color);
            });
        }

        private void TableHeader(TableDescriptor table, string[] headers)
        {
            foreach (var h in headers)
            {
                table.Cell().Background(Colors.Red.Darken2).PaddingVertical(6).PaddingHorizontal(6)
                    .Text(h).FontColor(Colors.White).FontSize(9).Bold();
            }
        }

        private void TableRow(TableDescriptor table, string estado, string cantidad, string pct, string ingresos,
            string textColor, string bgColor)
        {
            table.Cell().Background(bgColor).PaddingVertical(6).PaddingHorizontal(6)
                .Text(estado).FontColor(textColor).Bold().FontSize(9);
            table.Cell().Background(bgColor).PaddingVertical(6).PaddingHorizontal(6)
                .Text(cantidad).FontColor(Colors.Grey.Darken3).FontSize(9);
            table.Cell().Background(bgColor).PaddingVertical(6).PaddingHorizontal(6)
                .Text(pct).FontColor(Colors.Grey.Darken3).FontSize(9);
            table.Cell().Background(bgColor).PaddingVertical(6).PaddingHorizontal(6)
                .Text(ingresos).FontColor(Colors.Grey.Darken3).FontSize(9);
        }

        private int Pct(int part, int total) => total == 0 ? 0 : (int)Math.Round((part * 100.0) / total);

        private string EstadoColor(string estado) => estado.ToLower() switch
        {
            "pendiente" => Colors.Yellow.Darken3,
            "aprobado" or "aprobada" => Colors.Green.Darken2,
            "completado" or "completada" => Colors.Blue.Darken2,
            "cancelado" or "cancelada" => Colors.Red.Darken2,
            _ => Colors.Grey.Darken2
        };
    }

    public class ReporteData
    {
        public string TituloReporte { get; set; } = "Reporte General";
        public string PeriodoDescripcion { get; set; } = "";
        public DateTime FechaGeneracion { get; set; } = DateTime.Now;

        public decimal IngresosTotales { get; set; }
        public decimal IngresosAprobados { get; set; }
        public decimal IngresosCompletados { get; set; }
        public int TotalReservas { get; set; }
        public int TotalCompletadas { get; set; }
        public int TotalDetalles { get; set; }
        public double TasaCompletado => TotalReservas == 0 ? 0 : (TotalCompletadas * 100.0) / TotalReservas;

        public int CantPendientes { get; set; }
        public int CantAprobadas { get; set; }
        public int CantCompletadas { get; set; }
        public int CantCanceladas { get; set; }

        public List<ServicioPopularItem> ServiciosPopulares { get; set; } = new();
        public List<ReservaDto> Reservas { get; set; } = new();
    }

    public class ServicioPopularItem
    {
        public string NombreServicio { get; set; } = "";
        public int Cantidad { get; set; }
    }
}
