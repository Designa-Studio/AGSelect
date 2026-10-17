using System;

namespace BlazorAGS.Models
{
    public class Rol
    {
        public int Id { get; set; }
        public string Nombre { get; set; } = string.Empty;
        public string? Descripcion { get; set; }
    }

    public class Usuario
    {
        public int Id { get; set; }
        public string Nombre { get; set; } = string.Empty;
        public string Correo { get; set; } = string.Empty;
        public string? Telefono { get; set; }
        public string PasswordHash { get; set; } = string.Empty;
        public int RolId { get; set; }
        public string RolNombre { get; set; } = "Cliente";
        public bool Activo { get; set; } = true;
        public int LavadosCompletados { get; set; } = 0;
        public DateTime FechaRegistro { get; set; } = DateTime.Now;
    }

    public class LoginModel
    {
        public string Correo { get; set; } = string.Empty;
        public string Password { get; set; } = string.Empty;
    }

    public class RegistroModel
    {
        public string Nombre { get; set; } = string.Empty;
        public string Correo { get; set; } = string.Empty;
        public string Telefono { get; set; } = string.Empty;
        public string Password { get; set; } = string.Empty;
        public string ConfirmPassword { get; set; } = string.Empty;
    }

    public class AuthResponse
    {
        public bool Exito { get; set; }
        public string Mensaje { get; set; } = string.Empty;
        public string? Token { get; set; }
        public Usuario? Usuario { get; set; }
    }
}
