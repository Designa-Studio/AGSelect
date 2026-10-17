using System;

namespace BlazorAGS.Models
{
    public class VehiculoDto
    {
        public int Id { get; set; }
        public int UsuarioId { get; set; }
        public string Tipo { get; set; } = "Car";
        public string Marca { get; set; } = "";
        public string Modelo { get; set; } = "";
        public string? Anio { get; set; }
        public string? Color { get; set; }
        public string? Placa { get; set; }
        public DateTime FechaRegistro { get; set; } = DateTime.Now;

        public string NombreCompleto => $"{Marca} {Modelo}".Trim();
    }
}
