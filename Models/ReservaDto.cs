using System;
using System.Collections.Generic;

namespace BlazorAGS.Models
{
    public class ReservaDto
    {
        public int Id { get; set; }
        public int? UsuarioId { get; set; }
        public string ClienteNombre { get; set; } = "";
        public string? ClienteCorreo { get; set; }
        public string ClienteTelefono { get; set; } = "";
        public DateTime FechaReserva { get; set; }
        public string OpcionEntrega { get; set; } = "Taller";
        public decimal MontoTotal { get; set; }
        public string Estado { get; set; } = "Pendiente";
        public bool EsLavadoGratis { get; set; } = false;
        public DateTime FechaCreacion { get; set; } = DateTime.Now;

        public List<ReservaDetalleDto> Detalles { get; set; } = new();
    }

    public class ReservaDetalleDto
    {
        public int Id { get; set; }
        public int ReservaId { get; set; }
        public int? VehiculoId { get; set; }
        public string? TipoVehiculo { get; set; }
        public string Marca { get; set; } = "";
        public string Modelo { get; set; } = "";
        public string? Anio { get; set; }
        public string? Color { get; set; }
        public string PaqueteServicio { get; set; } = "";
        public decimal Precio { get; set; }
    }
}
