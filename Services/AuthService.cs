using System;
using System.IdentityModel.Tokens.Jwt;
using System.Security.Claims;
using System.Text;
using Microsoft.Data.SqlClient;
using Microsoft.Extensions.Configuration;
using Microsoft.IdentityModel.Tokens;
using BCrypt.Net;
using BlazorAGS.Models;

namespace BlazorAGS.Services
{
    public class AuthService
    {
        private readonly string _connectionString;
        private readonly string _jwtSecret = "AGS_Super_Secret_JWT_Key_2026_Secure_Token_Key_#99!";

        public AuthService(IConfiguration configuration)
        {
            _connectionString = configuration.GetConnectionString("DefaultConnection") 
                ?? "Server=184.168.122.69;Database=AGSDB;User Id=AplicationServer;Password=DesignaServer123456*;TrustServerCertificate=true;Connection Timeout=15;";
        }

        public async Task<AuthResponse> RegistrarAsync(RegistroModel model)
        {
            if (string.IsNullOrWhiteSpace(model.Nombre) || string.IsNullOrWhiteSpace(model.Correo) || string.IsNullOrWhiteSpace(model.Password))
            {
                return new AuthResponse { Exito = false, Mensaje = "Todos los campos obligatorios deben ser completados." };
            }

            if (model.Password != model.ConfirmPassword)
            {
                return new AuthResponse { Exito = false, Mensaje = "Las contraseñas no coinciden." };
            }

            try
            {
                using var conn = new SqlConnection(_connectionString);
                await conn.OpenAsync();

                // Verificar si correo existe
                string checkQuery = "SELECT COUNT(*) FROM Usuarios WHERE LOWER(Correo) = LOWER(@Correo)";
                using var checkCmd = new SqlCommand(checkQuery, conn);
                checkCmd.Parameters.AddWithValue("@Correo", model.Correo.Trim());
                int count = Convert.ToInt32(await checkCmd.ExecuteScalarAsync());

                if (count > 0)
                {
                    return new AuthResponse { Exito = false, Mensaje = "El correo electrónico ya se encuentra registrado." };
                }

                // Obtener RolId de 'Cliente'
                string rolQuery = "SELECT Id FROM Roles WHERE Nombre = 'Cliente'";
                using var rolCmd = new SqlCommand(rolQuery, conn);
                object? rolObj = await rolCmd.ExecuteScalarAsync();
                int rolId = rolObj != null ? Convert.ToInt32(rolObj) : 2;

                // Encriptar Password con BCrypt
                string passwordHash = BCrypt.Net.BCrypt.HashPassword(model.Password);

                // Insertar usuario
                string insertQuery = @"
                    INSERT INTO Usuarios (Nombre, Correo, Telefono, PasswordHash, RolId, Activo, FechaRegistro)
                    OUTPUT INSERTED.Id
                    VALUES (@Nombre, @Correo, @Telefono, @PasswordHash, @RolId, 1, GETDATE())";

                using var insertCmd = new SqlCommand(insertQuery, conn);
                insertCmd.Parameters.AddWithValue("@Nombre", model.Nombre.Trim());
                insertCmd.Parameters.AddWithValue("@Correo", model.Correo.Trim().ToLower());
                insertCmd.Parameters.AddWithValue("@Telefono", (object?)model.Telefono ?? DBNull.Value);
                insertCmd.Parameters.AddWithValue("@PasswordHash", passwordHash);
                insertCmd.Parameters.AddWithValue("@RolId", rolId);

                int nuevoId = Convert.ToInt32(await insertCmd.ExecuteScalarAsync());

                var usuario = new Usuario
                {
                    Id = nuevoId,
                    Nombre = model.Nombre.Trim(),
                    Correo = model.Correo.Trim().ToLower(),
                    Telefono = model.Telefono,
                    RolId = rolId,
                    RolNombre = "Cliente",
                    Activo = true,
                    FechaRegistro = DateTime.Now
                };

                string token = GenerarJwtToken(usuario);

                return new AuthResponse
                {
                    Exito = true,
                    Mensaje = "¡Registro exitoso! Bienvenido a AGS Select.",
                    Token = token,
                    Usuario = usuario
                };
            }
            catch (Exception ex)
            {
                return new AuthResponse { Exito = false, Mensaje = $"Error al registrar usuario: {ex.Message}" };
            }
        }

        public async Task<AuthResponse> LoginAsync(LoginModel model)
        {
            if (string.IsNullOrWhiteSpace(model.Correo) || string.IsNullOrWhiteSpace(model.Password))
            {
                return new AuthResponse { Exito = false, Mensaje = "Ingresa tu correo y contraseña." };
            }

            try
            {
                using var conn = new SqlConnection(_connectionString);
                await conn.OpenAsync();

                string query = @"
                    SELECT u.Id, u.Nombre, u.Correo, u.Telefono, u.PasswordHash, u.RolId, u.Activo, u.FechaRegistro, r.Nombre AS RolNombre
                    FROM Usuarios u
                    INNER JOIN Roles r ON u.RolId = r.Id
                    WHERE LOWER(u.Correo) = LOWER(@Correo)";

                using var cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@Correo", model.Correo.Trim());

                using var reader = await cmd.ExecuteReaderAsync();

                if (!await reader.ReadAsync())
                {
                    return new AuthResponse { Exito = false, Mensaje = "Correo o contraseña incorrectos." };
                }

                bool activo = reader.GetBoolean(reader.GetOrdinal("Activo"));
                if (!activo)
                {
                    return new AuthResponse { Exito = false, Mensaje = "Tu cuenta se encuentra deshabilitada." };
                }

                string hashGuardado = reader.GetString(reader.GetOrdinal("PasswordHash"));
                bool passwordCorrecto = BCrypt.Net.BCrypt.Verify(model.Password, hashGuardado);

                if (!passwordCorrecto)
                {
                    return new AuthResponse { Exito = false, Mensaje = "Correo o contraseña incorrectos." };
                }

                var usuario = new Usuario
                {
                    Id = reader.GetInt32(reader.GetOrdinal("Id")),
                    Nombre = reader.GetString(reader.GetOrdinal("Nombre")),
                    Correo = reader.GetString(reader.GetOrdinal("Correo")),
                    Telefono = reader.IsDBNull(reader.GetOrdinal("Telefono")) ? null : reader.GetString(reader.GetOrdinal("Telefono")),
                    RolId = reader.GetInt32(reader.GetOrdinal("RolId")),
                    RolNombre = reader.GetString(reader.GetOrdinal("RolNombre")),
                    Activo = true,
                    FechaRegistro = reader.GetDateTime(reader.GetOrdinal("FechaRegistro"))
                };

                string token = GenerarJwtToken(usuario);

                return new AuthResponse
                {
                    Exito = true,
                    Mensaje = "Inicio de sesión exitoso.",
                    Token = token,
                    Usuario = usuario
                };
            }
            catch (Exception ex)
            {
                return new AuthResponse { Exito = false, Mensaje = $"Error al iniciar sesión: {ex.Message}" };
            }
        }

        public string GenerarJwtToken(Usuario usuario)
        {
            var tokenHandler = new JwtSecurityTokenHandler();
            var key = Encoding.UTF8.GetBytes(_jwtSecret);

            var tokenDescriptor = new SecurityTokenDescriptor
            {
                Subject = new ClaimsIdentity(new[]
                {
                    new Claim(ClaimTypes.NameIdentifier, usuario.Id.ToString()),
                    new Claim(ClaimTypes.Name, usuario.Nombre),
                    new Claim(ClaimTypes.Email, usuario.Correo),
                    new Claim(ClaimTypes.Role, usuario.RolNombre)
                }),
                Expires = DateTime.UtcNow.AddDays(7),
                SigningCredentials = new SigningCredentials(new SymmetricSecurityKey(key), SecurityAlgorithms.HmacSha256Signature)
            };

            var token = tokenHandler.CreateToken(tokenDescriptor);
            return tokenHandler.WriteToken(token);
        }

        public ClaimsPrincipal ValidarJwtToken(string token)
        {
            var tokenHandler = new JwtSecurityTokenHandler();
            var key = Encoding.UTF8.GetBytes(_jwtSecret);

            try
            {
                var principal = tokenHandler.ValidateToken(token, new TokenValidationParameters
                {
                    ValidateIssuerSigningKey = true,
                    IssuerSigningKey = new SymmetricSecurityKey(key),
                    ValidateIssuer = false,
                    ValidateAudience = false,
                    ClockSkew = TimeSpan.Zero
                }, out SecurityToken validatedToken);

                return principal;
            }
            catch
            {
                return new ClaimsPrincipal(new ClaimsIdentity());
            }
        }
        public async Task<Usuario?> ObtenerUsuarioPorIdAsync(int id)
        {
            try
            {
                using var conn = new SqlConnection(_connectionString);
                await conn.OpenAsync();

                string query = @"
                    SELECT u.Id, u.Nombre, u.Correo, u.Telefono, u.PasswordHash, u.RolId, u.Activo, ISNULL(u.LavadosCompletados, 0) AS LavadosCompletados, u.FechaRegistro, r.Nombre AS RolNombre
                    FROM Usuarios u
                    INNER JOIN Roles r ON u.RolId = r.Id
                    WHERE u.Id = @Id";

                using var cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@Id", id);

                using var reader = await cmd.ExecuteReaderAsync();
                if (await reader.ReadAsync())
                {
                    return new Usuario
                    {
                        Id = reader.GetInt32(reader.GetOrdinal("Id")),
                        Nombre = reader.GetString(reader.GetOrdinal("Nombre")),
                        Correo = reader.GetString(reader.GetOrdinal("Correo")),
                        Telefono = reader.IsDBNull(reader.GetOrdinal("Telefono")) ? null : reader.GetString(reader.GetOrdinal("Telefono")),
                        RolId = reader.GetInt32(reader.GetOrdinal("RolId")),
                        RolNombre = reader.GetString(reader.GetOrdinal("RolNombre")),
                        Activo = reader.GetBoolean(reader.GetOrdinal("Activo")),
                        LavadosCompletados = reader.GetInt32(reader.GetOrdinal("LavadosCompletados")),
                        FechaRegistro = reader.GetDateTime(reader.GetOrdinal("FechaRegistro"))
                    };
                }
            }
            catch (Exception ex)
            {
                Console.WriteLine($"Error al obtener usuario: {ex.Message}");
            }

            return null;
        }

        public async Task<AuthResponse> ActualizarPerfilAsync(int usuarioId, string nombre, string telefono)
        {
            try
            {
                using var conn = new SqlConnection(_connectionString);
                await conn.OpenAsync();

                string query = "UPDATE Usuarios SET Nombre = @Nombre, Telefono = @Telefono WHERE Id = @Id";
                using var cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@Nombre", nombre.Trim());
                cmd.Parameters.AddWithValue("@Telefono", (object?)telefono ?? DBNull.Value);
                cmd.Parameters.AddWithValue("@Id", usuarioId);

                await cmd.ExecuteNonQueryAsync();

                return new AuthResponse { Exito = true, Mensaje = "Perfil actualizado con éxito." };
            }
            catch (Exception ex)
            {
                return new AuthResponse { Exito = false, Mensaje = $"Error al actualizar perfil: {ex.Message}" };
            }
        }
    }
}
