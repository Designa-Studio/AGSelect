using BlazorAGS.Components;
using BlazorAGS.Services;
using Microsoft.AspNetCore.Components.Authorization;

var builder = WebApplication.CreateBuilder(args);

// Add services to the container.
builder.Services.AddRazorComponents()
    .AddInteractiveServerComponents();

// Registrar servicios personalizados
builder.Services.AddScoped<AuthService>();
builder.Services.AddScoped<BookingService>();
builder.Services.AddScoped<ReportePdfService>();
builder.Services.AddScoped<CustomAuthenticationStateProvider>();
builder.Services.AddScoped<AuthenticationStateProvider>(sp => sp.GetRequiredService<CustomAuthenticationStateProvider>());
builder.Services.AddAuthorizationCore();

var app = builder.Build();

// Inicialización de Tablas de BD
var connStr = app.Configuration.GetConnectionString("DefaultConnection") 
    ?? "Server=184.168.122.69;Database=AGSDB;User Id=AplicationServer;Password=DesignaServer123456*;TrustServerCertificate=true;Connection Timeout=15;";
DbInitializer.Initialize(connStr);



// Configure the HTTP request pipeline.
if (!app.Environment.IsDevelopment())
{
    app.UseExceptionHandler("/Error", createScopeForErrors: true);
    app.UseHsts();
}
app.UseStatusCodePagesWithReExecute("/not-found", createScopeForStatusCodePages: true);
app.UseHttpsRedirection();

app.UseAntiforgery();

app.MapStaticAssets();
app.MapRazorComponents<App>()
    .AddInteractiveServerRenderMode();

// ─── Endpoint para descargar PDF de reporte (con filtro de fechas) ──────────
app.MapPost("/api/reportes/pdf", async (HttpContext ctx, BookingService bookingSvc, ReportePdfService pdfSvc) =>
{
    // Leer parámetros de filtro de fecha desde el query string
    var desdeStr = ctx.Request.Query["desde"].FirstOrDefault();
    var hastaStr = ctx.Request.Query["hasta"].FirstOrDefault();

    DateTime? fechaDesde = DateTime.TryParse(desdeStr, out var d) ? d : null;
    DateTime? fechaHasta = DateTime.TryParse(hastaStr, out var h) ? h : null;

    var todasReservas = await bookingSvc.ObtenerReservasPorUsuarioAsync(null);

    // Aplicar filtro de fechas
    var reservas = todasReservas.Where(r =>
    {
        if (fechaDesde.HasValue && r.FechaReserva.Date < fechaDesde.Value.Date) return false;
        if (fechaHasta.HasValue && r.FechaReserva.Date > fechaHasta.Value.Date) return false;
        return true;
    }).ToList();

    var detalles = reservas.SelectMany(r => r.Detalles).ToList();

    // Construir descripción del período para el PDF
    string periodo = (fechaDesde, fechaHasta) switch
    {
        (null, null) => "Todo el período registrado",
        ({ } fd, null) => $"Desde {fd:dd/MM/yyyy}",
        (null, { } fh) => $"Hasta {fh:dd/MM/yyyy}",
        ({ } fd, { } fh) when fd == fh => fd.ToString("dd/MM/yyyy"),
        ({ } fd, { } fh) => $"{fd:dd/MM/yyyy} – {fh:dd/MM/yyyy}"
    };

    var data = new ReporteData
    {
        TituloReporte       = "Reporte de Operaciones",
        PeriodoDescripcion  = periodo,
        FechaGeneracion     = DateTime.Now,
        IngresosTotales     = reservas.Where(r => !r.Estado.Contains("Cancelad", StringComparison.OrdinalIgnoreCase)).Sum(r => r.MontoTotal),
        IngresosAprobados   = reservas.Where(r => r.Estado.Contains("Aprobad",   StringComparison.OrdinalIgnoreCase)).Sum(r => r.MontoTotal),
        IngresosCompletados = reservas.Where(r => r.Estado.Contains("Completad", StringComparison.OrdinalIgnoreCase)).Sum(r => r.MontoTotal),
        TotalReservas       = reservas.Count,
        TotalCompletadas    = reservas.Count(r => r.Estado.Contains("Completad", StringComparison.OrdinalIgnoreCase)),
        TotalDetalles       = detalles.Count,
        CantPendientes      = reservas.Count(r => r.Estado.Equals("Pendiente",   StringComparison.OrdinalIgnoreCase)),
        CantAprobadas       = reservas.Count(r => r.Estado.Contains("Aprobad",   StringComparison.OrdinalIgnoreCase)),
        CantCompletadas     = reservas.Count(r => r.Estado.Contains("Completad", StringComparison.OrdinalIgnoreCase)),
        CantCanceladas      = reservas.Count(r => r.Estado.Contains("Cancelad",  StringComparison.OrdinalIgnoreCase)),
        ServiciosPopulares  = detalles
            .GroupBy(d => d.PaqueteServicio)
            .Select(g => new ServicioPopularItem { NombreServicio = g.Key, Cantidad = g.Count() })
            .OrderByDescending(x => x.Cantidad)
            .ToList(),
        Reservas = reservas
    };

    var bytes = pdfSvc.GenerarReporteGeneral(data);
    var filename = $"AGS_Reporte_{DateTime.Now:yyyyMMdd_HHmm}.pdf";
    ctx.Response.Headers.Append("Content-Disposition", $"attachment; filename={filename}");
    return Results.File(bytes, "application/pdf", filename);
});

app.Run();
