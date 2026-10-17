using System;

namespace BlazorAGS.Models
{
    public class CategoriaVehiculoDto
    {
        public int Id { get; set; }
        public string Nombre { get; set; } = "";
        public string Codigo { get; set; } = "";
        public bool Activo { get; set; } = true;
    }

    public class BloqueoCalendarioDto
    {
        public int Id { get; set; }
        public DateTime? FechaBloqueada { get; set; }
        public int? DiaSemana { get; set; } // 0=Domingo, 1=Lunes, ..., 6=Sábado
        public string? Motivo { get; set; }
        public bool EsRecurrente { get; set; }
        public DateTime FechaRegistro { get; set; } = DateTime.Now;
    }

    public class OpcionEntregaDto
    {
        public int Id { get; set; }
        public string Nombre { get; set; } = "";
        public decimal CostoAdicional { get; set; }
        public string? Descripcion { get; set; }
        public bool Activo { get; set; } = true;
    }
}
