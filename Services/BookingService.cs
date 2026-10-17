using BlazorAGS.Models;
using Microsoft.Data.SqlClient;

namespace BlazorAGS.Services
{
    public class BookingService
    {
        private readonly string _connectionString;
        private readonly ILogger<BookingService> _logger;

        public BookingService(IConfiguration configuration, ILogger<BookingService> logger)
        {
            _connectionString = configuration.GetConnectionString("DefaultConnection") 
                ?? "Server=184.168.122.69;Database=AGSDB;User Id=AplicationServer;Password=DesignaServer123456*;TrustServerCertificate=true;Connection Timeout=15;";
            _logger = logger;
        }

        public async Task<List<ServiceGroup>> GetActiveServiceGroupsAsync()
        {
            var groups = new List<ServiceGroup>();

            try
            {
                using var conn = new SqlConnection(_connectionString);
                await conn.OpenAsync();

                string groupQuery = @"
                    SELECT Id, Name, Description, PriceCar, PriceJeepeta, PriceSuv, PriceCamioneta, 
                           PriceCamion, PriceMinivan, PriceCamionDosEjes, PriceTrailer, Image, Status, CreatedAt
                    FROM [dbo].[ServiceGroups]
                    WHERE Status = 'active'
                    ORDER BY Id;";

                using (var cmd = new SqlCommand(groupQuery, conn))
                using (var reader = await cmd.ExecuteReaderAsync())
                {
                    while (await reader.ReadAsync())
                    {
                        groups.Add(new ServiceGroup
                        {
                            Id = reader.GetInt64(0),
                            Name = reader.GetString(1),
                            Description = reader.IsDBNull(2) ? "" : reader.GetString(2),
                            PriceCar = reader.GetDecimal(3),
                            PriceJeepeta = reader.GetDecimal(4),
                            PriceSuv = reader.GetDecimal(5),
                            PriceCamioneta = reader.GetDecimal(6),
                            PriceCamion = reader.GetDecimal(7),
                            PriceMinivan = reader.GetDecimal(8),
                            PriceCamionDosEjes = reader.GetDecimal(9),
                            PriceTrailer = reader.GetDecimal(10),
                            Image = reader.IsDBNull(11) ? null : reader.GetString(11),
                            Status = reader.GetString(12),
                            CreatedAt = reader.GetDateTime(13)
                        });
                    }
                }

                // Query additional services
                string addQuery = @"
                    SELECT Id, GroupId, Name, Description, PriceCar, PriceJeepeta, PriceSuv, PriceCamioneta, 
                           PriceCamion, PriceMinivan, PriceCamionDosEjes, PriceTrailer, Image, Status, CreatedAt
                    FROM [dbo].[AdditionalServices]
                    WHERE Status = 'active'
                    ORDER BY Id;";

                using (var cmdAdd = new SqlCommand(addQuery, conn))
                using (var addReader = await cmdAdd.ExecuteReaderAsync())
                {
                    while (await addReader.ReadAsync())
                    {
                        var group = groups.FirstOrDefault(g => g.Id == addReader.GetInt64(1));
                        if (group != null)
                        {
                            group.AdditionalServices.Add(new AdditionalService
                            {
                                Id = addReader.GetInt64(0),
                                GroupId = addReader.GetInt64(1),
                                Name = addReader.GetString(2),
                                Description = addReader.IsDBNull(3) ? "" : addReader.GetString(3),
                                PriceCar = addReader.GetDecimal(4),
                                PriceJeepeta = addReader.GetDecimal(5),
                                PriceSuv = addReader.GetDecimal(6),
                                PriceCamioneta = addReader.GetDecimal(7),
                                PriceCamion = addReader.GetDecimal(8),
                                PriceMinivan = addReader.GetDecimal(9),
                                PriceCamionDosEjes = addReader.GetDecimal(10),
                                PriceTrailer = addReader.GetDecimal(11),
                                Image = addReader.IsDBNull(12) ? null : addReader.GetString(12),
                                Status = addReader.GetString(13),
                                CreatedAt = addReader.GetDateTime(14)
                            });
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Error al cargar grupos de servicios desde la base de datos.");
            }

            // Fallback default list if DB is empty or connection failed
            if (!groups.Any())
            {
                groups = GetFallbackGroups();
            }

            return groups;
        }

        public async Task<int> CrearReservaAsync(ReservaDto reserva)
        {
            try
            {
                using var conn = new SqlConnection(_connectionString);
                await conn.OpenAsync();
                using var transaction = conn.BeginTransaction();

                try
                {
                    string insertReserva = @"
                        INSERT INTO Reservas (UsuarioId, ClienteNombre, ClienteCorreo, ClienteTelefono, FechaReserva, OpcionEntrega, MontoTotal, Estado, EsLavadoGratis, FechaCreacion)
                        OUTPUT INSERTED.Id
                        VALUES (@UsuarioId, @ClienteNombre, @ClienteCorreo, @ClienteTelefono, @FechaReserva, @OpcionEntrega, @MontoTotal, @Estado, @EsLavadoGratis, GETDATE());";

                    using var cmdReserva = new SqlCommand(insertReserva, conn, transaction);
                    cmdReserva.Parameters.AddWithValue("@UsuarioId", (object?)reserva.UsuarioId ?? DBNull.Value);
                    cmdReserva.Parameters.AddWithValue("@ClienteNombre", reserva.ClienteNombre);
                    cmdReserva.Parameters.AddWithValue("@ClienteCorreo", (object?)reserva.ClienteCorreo ?? DBNull.Value);
                    cmdReserva.Parameters.AddWithValue("@ClienteTelefono", reserva.ClienteTelefono);
                    cmdReserva.Parameters.AddWithValue("@FechaReserva", reserva.FechaReserva);
                    cmdReserva.Parameters.AddWithValue("@OpcionEntrega", reserva.OpcionEntrega);
                    cmdReserva.Parameters.AddWithValue("@MontoTotal", reserva.MontoTotal);
                    cmdReserva.Parameters.AddWithValue("@Estado", string.IsNullOrEmpty(reserva.Estado) ? "Pendiente" : reserva.Estado);
                    cmdReserva.Parameters.AddWithValue("@EsLavadoGratis", reserva.EsLavadoGratis);

                    int reservaId = Convert.ToInt32(await cmdReserva.ExecuteScalarAsync());

                    foreach (var det in reserva.Detalles)
                    {
                        string insertDetalle = @"
                            INSERT INTO ReservaDetalles (ReservaId, TipoVehiculo, Marca, Modelo, Anio, Color, PaqueteServicio, Precio)
                            VALUES (@ReservaId, @TipoVehiculo, @Marca, @Modelo, @Anio, @Color, @PaqueteServicio, @Precio);";

                        using var cmdDet = new SqlCommand(insertDetalle, conn, transaction);
                        cmdDet.Parameters.AddWithValue("@ReservaId", reservaId);
                        cmdDet.Parameters.AddWithValue("@TipoVehiculo", (object?)det.TipoVehiculo ?? DBNull.Value);
                        cmdDet.Parameters.AddWithValue("@Marca", det.Marca);
                        cmdDet.Parameters.AddWithValue("@Modelo", det.Modelo);
                        cmdDet.Parameters.AddWithValue("@Anio", (object?)det.Anio ?? DBNull.Value);
                        cmdDet.Parameters.AddWithValue("@Color", (object?)det.Color ?? DBNull.Value);
                        cmdDet.Parameters.AddWithValue("@PaqueteServicio", det.PaqueteServicio);
                        cmdDet.Parameters.AddWithValue("@Precio", det.Precio);

                        await cmdDet.ExecuteNonQueryAsync();
                    }

                    await transaction.CommitAsync();
                    return reservaId;
                }
                catch
                {
                    await transaction.RollbackAsync();
                    throw;
                }
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Error al crear reserva en la base de datos.");
                return 0;
            }
        }

        public async Task<List<ReservaDto>> ObtenerReservasPorUsuarioAsync(int? usuarioId = null)
        {
            var list = new List<ReservaDto>();
            try
            {
                using var conn = new SqlConnection(_connectionString);
                await conn.OpenAsync();

                string query = @"
                    SELECT r.Id, r.UsuarioId, r.ClienteNombre, r.ClienteCorreo, r.ClienteTelefono, 
                           r.FechaReserva, r.OpcionEntrega, r.MontoTotal, r.Estado, ISNULL(r.EsLavadoGratis, 0) AS EsLavadoGratis, r.FechaCreacion,
                           d.Id AS DetId, d.TipoVehiculo, d.Marca, d.Modelo, d.Anio, d.Color, d.PaqueteServicio, d.Precio
                    FROM Reservas r
                    LEFT JOIN ReservaDetalles d ON r.Id = d.ReservaId ";

                if (usuarioId.HasValue)
                {
                    query += " WHERE r.UsuarioId = @UsuarioId ";
                }

                query += " ORDER BY r.FechaCreacion DESC, r.Id DESC;";

                using var cmd = new SqlCommand(query, conn);
                if (usuarioId.HasValue)
                {
                    cmd.Parameters.AddWithValue("@UsuarioId", usuarioId.Value);
                }

                using var reader = await cmd.ExecuteReaderAsync();
                var dict = new Dictionary<int, ReservaDto>();

                while (await reader.ReadAsync())
                {
                    int resId = reader.GetInt32(0);
                    if (!dict.TryGetValue(resId, out var res))
                    {
                        res = new ReservaDto
                        {
                            Id = resId,
                            UsuarioId = reader.IsDBNull(1) ? null : reader.GetInt32(1),
                            ClienteNombre = reader.GetString(2),
                            ClienteCorreo = reader.IsDBNull(3) ? null : reader.GetString(3),
                            ClienteTelefono = reader.GetString(4),
                            FechaReserva = reader.GetDateTime(5),
                            OpcionEntrega = reader.GetString(6),
                            MontoTotal = reader.GetDecimal(7),
                            Estado = reader.GetString(8),
                            EsLavadoGratis = reader.GetBoolean(9),
                            FechaCreacion = reader.GetDateTime(10),
                            Detalles = new List<ReservaDetalleDto>()
                        };
                        dict[resId] = res;
                        list.Add(res);
                    }

                    if (!reader.IsDBNull(11)) // DetId
                    {
                        res.Detalles.Add(new ReservaDetalleDto
                        {
                            Id = reader.GetInt32(11),
                            ReservaId = resId,
                            TipoVehiculo = reader.IsDBNull(12) ? null : reader.GetString(12),
                            Marca = reader.GetString(13),
                            Modelo = reader.GetString(14),
                            Anio = reader.IsDBNull(15) ? null : reader.GetString(15),
                            Color = reader.IsDBNull(16) ? null : reader.GetString(16),
                            PaqueteServicio = reader.GetString(17),
                            Precio = reader.GetDecimal(18)
                        });
                    }
                }
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Error al obtener reservas desde la base de datos.");
            }

            return list;
        }

        public async Task<List<DateTime>> ObtenerFechasHorasReservadasAsync()
        {
            var result = new List<DateTime>();
            try
            {
                using var conn = new SqlConnection(_connectionString);
                await conn.OpenAsync();

                string query = "SELECT FechaReserva FROM Reservas WHERE Estado != 'Cancelada' AND Estado != 'Cancelado';";
                using var cmd = new SqlCommand(query, conn);
                using var reader = await cmd.ExecuteReaderAsync();

                while (await reader.ReadAsync())
                {
                    result.Add(reader.GetDateTime(0));
                }
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Error al consultar horas y fechas reservadas.");
            }
            return result;
        }

        public async Task<List<VehiculoDto>> ObtenerVehiculosPorUsuarioAsync(int usuarioId)
        {
            var list = new List<VehiculoDto>();
            try
            {
                using var conn = new SqlConnection(_connectionString);
                await conn.OpenAsync();

                string query = @"
                    SELECT Id, UsuarioId, Tipo, Marca, Modelo, Anio, Color, Placa, FechaRegistro
                    FROM Vehiculos
                    WHERE UsuarioId = @UsuarioId
                    ORDER BY Id DESC;";

                using var cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@UsuarioId", usuarioId);

                using var reader = await cmd.ExecuteReaderAsync();
                while (await reader.ReadAsync())
                {
                    list.Add(new VehiculoDto
                    {
                        Id = reader.GetInt32(0),
                        UsuarioId = reader.GetInt32(1),
                        Tipo = reader.GetString(2),
                        Marca = reader.GetString(3),
                        Modelo = reader.GetString(4),
                        Anio = reader.IsDBNull(5) ? null : reader.GetString(5),
                        Color = reader.IsDBNull(6) ? null : reader.GetString(6),
                        Placa = reader.IsDBNull(7) ? null : reader.GetString(7),
                        FechaRegistro = reader.GetDateTime(8)
                    });
                }
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Error al obtener vehículos del usuario.");
            }
            return list;
        }

        public async Task<int> CrearVehiculoAsync(VehiculoDto vehiculo)
        {
            try
            {
                using var conn = new SqlConnection(_connectionString);
                await conn.OpenAsync();

                string query = @"
                    INSERT INTO Vehiculos (UsuarioId, Tipo, Marca, Modelo, Anio, Color, Placa, FechaRegistro)
                    OUTPUT INSERTED.Id
                    VALUES (@UsuarioId, @Tipo, @Marca, @Modelo, @Anio, @Color, @Placa, GETDATE());";

                using var cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@UsuarioId", vehiculo.UsuarioId);
                cmd.Parameters.AddWithValue("@Tipo", vehiculo.Tipo);
                cmd.Parameters.AddWithValue("@Marca", vehiculo.Marca);
                cmd.Parameters.AddWithValue("@Modelo", vehiculo.Modelo);
                cmd.Parameters.AddWithValue("@Anio", (object?)vehiculo.Anio ?? DBNull.Value);
                cmd.Parameters.AddWithValue("@Color", (object?)vehiculo.Color ?? DBNull.Value);
                cmd.Parameters.AddWithValue("@Placa", (object?)vehiculo.Placa ?? DBNull.Value);

                return Convert.ToInt32(await cmd.ExecuteScalarAsync());
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Error al crear vehículo en la base de datos.");
                return 0;
            }
        }

        public async Task<bool> ReagendarReservaAsync(int reservaId, DateTime nuevaFechaHora)
        {
            try
            {
                using var conn = new SqlConnection(_connectionString);
                await conn.OpenAsync();

                string query = "UPDATE Reservas SET FechaReserva = @FechaReserva, Estado = 'Pendiente' WHERE Id = @Id;";
                using var cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@FechaReserva", nuevaFechaHora);
                cmd.Parameters.AddWithValue("@Id", reservaId);

                return await cmd.ExecuteNonQueryAsync() > 0;
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Error al reagendar reserva.");
                return false;
            }
        }

        public async Task<bool> ActualizarEstadoReservaAsync(int reservaId, string nuevoEstado)
        {
            try
            {
                using var conn = new SqlConnection(_connectionString);
                await conn.OpenAsync();
                using var transaction = conn.BeginTransaction();

                try
                {
                    // 1. Obtener estado anterior, usuarioId y si fue LavadoGratis
                    string selectRes = "SELECT UsuarioId, Estado, ISNULL(EsLavadoGratis, 0) AS EsLavadoGratis FROM Reservas WHERE Id = @Id;";
                    int? usuarioId = null;
                    string estadoAnterior = "";
                    bool esLavadoGratis = false;

                    using (var cmdSelect = new SqlCommand(selectRes, conn, transaction))
                    {
                        cmdSelect.Parameters.AddWithValue("@Id", reservaId);
                        using var reader = await cmdSelect.ExecuteReaderAsync();
                        if (await reader.ReadAsync())
                        {
                            usuarioId = reader.IsDBNull(0) ? null : reader.GetInt32(0);
                            estadoAnterior = reader.GetString(1);
                            esLavadoGratis = reader.GetBoolean(2);
                        }
                    }

                    // 2. Actualizar estado de la reserva
                    string updateRes = "UPDATE Reservas SET Estado = @Estado WHERE Id = @Id;";
                    using (var cmdUpdate = new SqlCommand(updateRes, conn, transaction))
                    {
                        cmdUpdate.Parameters.AddWithValue("@Estado", nuevoEstado);
                        cmdUpdate.Parameters.AddWithValue("@Id", reservaId);
                        await cmdUpdate.ExecuteNonQueryAsync();
                    }

                    // 3. Si la reserva pertenece a un usuario registrado, gestionar su tarjeta de membresía
                    if (usuarioId.HasValue)
                    {
                        bool eraCompletada = estadoAnterior.Equals("Completado", StringComparison.OrdinalIgnoreCase) || estadoAnterior.Equals("Completada", StringComparison.OrdinalIgnoreCase);
                        bool ahoraCompletada = nuevoEstado.Equals("Completado", StringComparison.OrdinalIgnoreCase) || nuevoEstado.Equals("Completada", StringComparison.OrdinalIgnoreCase);

                        if (!eraCompletada && ahoraCompletada)
                        {
                            // Transición a completado
                            if (esLavadoGratis)
                            {
                                // Al completar la reserva que usó el lavado gratis, resetear la tarjeta a 0
                                string resetQuery = "UPDATE Usuarios SET LavadosCompletados = 0 WHERE Id = @UsuarioId;";
                                using var cmdReset = new SqlCommand(resetQuery, conn, transaction);
                                cmdReset.Parameters.AddWithValue("@UsuarioId", usuarioId.Value);
                                await cmdReset.ExecuteNonQueryAsync();
                            }
                            else
                            {
                                // Lavado normal completado: sumar 1 punto
                                string addPointQuery = "UPDATE Usuarios SET LavadosCompletados = ISNULL(LavadosCompletados, 0) + 1 WHERE Id = @UsuarioId;";
                                using var cmdAddPoint = new SqlCommand(addPointQuery, conn, transaction);
                                cmdAddPoint.Parameters.AddWithValue("@UsuarioId", usuarioId.Value);
                                await cmdAddPoint.ExecuteNonQueryAsync();
                            }
                        }
                        else if (eraCompletada && !ahoraCompletada)
                        {
                            // Si se desmarca de completada por error, restar el punto de lavado si no era gratis
                            if (!esLavadoGratis)
                            {
                                string subPointQuery = "UPDATE Usuarios SET LavadosCompletados = CASE WHEN ISNULL(LavadosCompletados, 0) > 0 THEN LavadosCompletados - 1 ELSE 0 END WHERE Id = @UsuarioId;";
                                using var cmdSubPoint = new SqlCommand(subPointQuery, conn, transaction);
                                cmdSubPoint.Parameters.AddWithValue("@UsuarioId", usuarioId.Value);
                                await cmdSubPoint.ExecuteNonQueryAsync();
                            }
                        }
                    }

                    await transaction.CommitAsync();
                    return true;
                }
                catch
                {
                    await transaction.RollbackAsync();
                    throw;
                }
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Error al actualizar estado de la reserva.");
                return false;
            }
        }

        public async Task<bool> EliminarReservaAsync(int reservaId)
        {
            try
            {
                using var conn = new SqlConnection(_connectionString);
                await conn.OpenAsync();

                string query = "DELETE FROM Reservas WHERE Id = @Id;";
                using var cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@Id", reservaId);

                return await cmd.ExecuteNonQueryAsync() > 0;
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Error al eliminar la reserva #{ReservaId}.", reservaId);
                return false;
            }
        }

        // ─── MÓDULO DE CONFIGURACIÓN DEL TALLER ─────────────────────────────────

        public async Task<List<CategoriaVehiculoDto>> ObtenerCategoriasVehiculoAsync()
        {
            var list = new List<CategoriaVehiculoDto>();
            try
            {
                using var conn = new SqlConnection(_connectionString);
                await conn.OpenAsync();
                string query = "SELECT Id, Nombre, Codigo, Activo FROM CategoriasVehiculo ORDER BY Id;";
                using var cmd = new SqlCommand(query, conn);
                using var reader = await cmd.ExecuteReaderAsync();
                while (await reader.ReadAsync())
                {
                    list.Add(new CategoriaVehiculoDto
                    {
                        Id = reader.GetInt32(0),
                        Nombre = reader.GetString(1),
                        Codigo = reader.GetString(2),
                        Activo = reader.GetBoolean(3)
                    });
                }
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Error al obtener categorías de vehículos.");
            }
            return list;
        }

        public async Task<bool> CrearCategoriaVehiculoAsync(CategoriaVehiculoDto cat)
        {
            try
            {
                using var conn = new SqlConnection(_connectionString);
                await conn.OpenAsync();
                string query = "INSERT INTO CategoriasVehiculo (Nombre, Codigo, Activo) VALUES (@Nombre, @Codigo, 1);";
                using var cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@Nombre", cat.Nombre);
                cmd.Parameters.AddWithValue("@Codigo", cat.Codigo);
                return await cmd.ExecuteNonQueryAsync() > 0;
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Error al crear categoría de vehículo.");
                return false;
            }
        }

        public async Task<bool> EliminarCategoriaVehiculoAsync(int id)
        {
            try
            {
                using var conn = new SqlConnection(_connectionString);
                await conn.OpenAsync();
                string query = "DELETE FROM CategoriasVehiculo WHERE Id = @Id;";
                using var cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@Id", id);
                return await cmd.ExecuteNonQueryAsync() > 0;
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Error al eliminar categoría de vehículo.");
                return false;
            }
        }

        public async Task<bool> EliminarServicioGrupoAsync(long id)
        {
            try
            {
                using var conn = new SqlConnection(_connectionString);
                await conn.OpenAsync();
                string query = "DELETE FROM [dbo].[ServiceGroups] WHERE Id = @Id;";
                using var cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@Id", id);
                return await cmd.ExecuteNonQueryAsync() > 0;
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Error al eliminar servicio.");
                return false;
            }
        }

        public async Task<bool> EliminarOpcionEntregaAsync(int id)
        {
            try
            {
                using var conn = new SqlConnection(_connectionString);
                await conn.OpenAsync();
                string query = "DELETE FROM OpcionesEntrega WHERE Id = @Id;";
                using var cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@Id", id);
                return await cmd.ExecuteNonQueryAsync() > 0;
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Error al eliminar opción de entrega.");
                return false;
            }
        }

        public async Task<bool> CrearServicioGrupoAsync(ServiceGroup grupo)
        {
            try
            {
                using var conn = new SqlConnection(_connectionString);
                await conn.OpenAsync();
                string query = @"
                    INSERT INTO [dbo].[ServiceGroups] 
                    (Name, Description, PriceCar, PriceJeepeta, PriceSuv, PriceCamioneta, PriceCamion, PriceMinivan, PriceCamionDosEjes, PriceTrailer, Status, CreatedAt)
                    VALUES 
                    (@Name, @Description, @PriceCar, @PriceJeepeta, @PriceSuv, @PriceCamioneta, @PriceCamion, @PriceMinivan, @PriceCamionDosEjes, @PriceTrailer, 'active', GETDATE());";

                using var cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@Name", grupo.Name);
                cmd.Parameters.AddWithValue("@Description", grupo.Description ?? "");
                cmd.Parameters.AddWithValue("@PriceCar", grupo.PriceCar);
                cmd.Parameters.AddWithValue("@PriceJeepeta", grupo.PriceJeepeta);
                cmd.Parameters.AddWithValue("@PriceSuv", grupo.PriceSuv);
                cmd.Parameters.AddWithValue("@PriceCamioneta", grupo.PriceCamioneta);
                cmd.Parameters.AddWithValue("@PriceCamion", grupo.PriceCamion);
                cmd.Parameters.AddWithValue("@PriceMinivan", grupo.PriceMinivan);
                cmd.Parameters.AddWithValue("@PriceCamionDosEjes", grupo.PriceCamionDosEjes);
                cmd.Parameters.AddWithValue("@PriceTrailer", grupo.PriceTrailer);

                return await cmd.ExecuteNonQueryAsync() > 0;
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Error al crear grupo de servicio.");
                return false;
            }
        }

        public async Task<bool> ActualizarServicioGrupoPreciosAsync(ServiceGroup grupo)
        {
            try
            {
                using var conn = new SqlConnection(_connectionString);
                await conn.OpenAsync();
                string query = @"
                    UPDATE [dbo].[ServiceGroups] SET 
                        Name = @Name,
                        Description = @Description,
                        PriceCar = @PriceCar,
                        PriceJeepeta = @PriceJeepeta,
                        PriceSuv = @PriceSuv,
                        PriceCamioneta = @PriceCamioneta,
                        PriceCamion = @PriceCamion,
                        PriceMinivan = @PriceMinivan,
                        PriceCamionDosEjes = @PriceCamionDosEjes,
                        PriceTrailer = @PriceTrailer
                    WHERE Id = @Id;";

                using var cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@Name", grupo.Name);
                cmd.Parameters.AddWithValue("@Description", grupo.Description ?? "");
                cmd.Parameters.AddWithValue("@PriceCar", grupo.PriceCar);
                cmd.Parameters.AddWithValue("@PriceJeepeta", grupo.PriceJeepeta);
                cmd.Parameters.AddWithValue("@PriceSuv", grupo.PriceSuv);
                cmd.Parameters.AddWithValue("@PriceCamioneta", grupo.PriceCamioneta);
                cmd.Parameters.AddWithValue("@PriceCamion", grupo.PriceCamion);
                cmd.Parameters.AddWithValue("@PriceMinivan", grupo.PriceMinivan);
                cmd.Parameters.AddWithValue("@PriceCamionDosEjes", grupo.PriceCamionDosEjes);
                cmd.Parameters.AddWithValue("@PriceTrailer", grupo.PriceTrailer);
                cmd.Parameters.AddWithValue("@Id", grupo.Id);

                return await cmd.ExecuteNonQueryAsync() > 0;
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Error al actualizar servicio.");
                return false;
            }
        }

        public async Task<List<BloqueoCalendarioDto>> ObtenerBloqueosCalendarioAsync()
        {
            var list = new List<BloqueoCalendarioDto>();
            try
            {
                using var conn = new SqlConnection(_connectionString);
                await conn.OpenAsync();
                string query = "SELECT Id, FechaBloqueada, DiaSemana, Motivo, EsRecurrente, FechaRegistro FROM BloqueosCalendario ORDER BY Id DESC;";
                using var cmd = new SqlCommand(query, conn);
                using var reader = await cmd.ExecuteReaderAsync();
                while (await reader.ReadAsync())
                {
                    list.Add(new BloqueoCalendarioDto
                    {
                        Id = reader.GetInt32(0),
                        FechaBloqueada = reader.IsDBNull(1) ? null : reader.GetDateTime(1),
                        DiaSemana = reader.IsDBNull(2) ? null : reader.GetInt32(2),
                        Motivo = reader.IsDBNull(3) ? null : reader.GetString(3),
                        EsRecurrente = reader.GetBoolean(4),
                        FechaRegistro = reader.GetDateTime(5)
                    });
                }
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Error al obtener bloqueos de calendario.");
            }
            return list;
        }

        public async Task<bool> CrearBloqueoCalendarioAsync(BloqueoCalendarioDto bloqueo)
        {
            try
            {
                using var conn = new SqlConnection(_connectionString);
                await conn.OpenAsync();
                string query = @"
                    INSERT INTO BloqueosCalendario (FechaBloqueada, DiaSemana, Motivo, EsRecurrente, FechaRegistro)
                    VALUES (@FechaBloqueada, @DiaSemana, @Motivo, @EsRecurrente, GETDATE());";
                using var cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@FechaBloqueada", (object?)bloqueo.FechaBloqueada ?? DBNull.Value);
                cmd.Parameters.AddWithValue("@DiaSemana", (object?)bloqueo.DiaSemana ?? DBNull.Value);
                cmd.Parameters.AddWithValue("@Motivo", (object?)bloqueo.Motivo ?? DBNull.Value);
                cmd.Parameters.AddWithValue("@EsRecurrente", bloqueo.EsRecurrente);
                return await cmd.ExecuteNonQueryAsync() > 0;
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Error al crear bloqueo de calendario.");
                return false;
            }
        }

        public async Task<bool> EliminarBloqueoCalendarioAsync(int id)
        {
            try
            {
                using var conn = new SqlConnection(_connectionString);
                await conn.OpenAsync();
                string query = "DELETE FROM BloqueosCalendario WHERE Id = @Id;";
                using var cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@Id", id);
                return await cmd.ExecuteNonQueryAsync() > 0;
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Error al eliminar bloqueo.");
                return false;
            }
        }

        public async Task<List<OpcionEntregaDto>> ObtenerOpcionesEntregaAsync()
        {
            var list = new List<OpcionEntregaDto>();
            try
            {
                using var conn = new SqlConnection(_connectionString);
                await conn.OpenAsync();
                string query = "SELECT Id, Nombre, CostoAdicional, Descripcion, Activo FROM OpcionesEntrega ORDER BY Id;";
                using var cmd = new SqlCommand(query, conn);
                using var reader = await cmd.ExecuteReaderAsync();
                while (await reader.ReadAsync())
                {
                    list.Add(new OpcionEntregaDto
                    {
                        Id = reader.GetInt32(0),
                        Nombre = reader.GetString(1),
                        CostoAdicional = reader.GetDecimal(2),
                        Descripcion = reader.IsDBNull(3) ? null : reader.GetString(3),
                        Activo = reader.GetBoolean(4)
                    });
                }
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Error al obtener opciones de entrega.");
            }
            return list;
        }

        public async Task<bool> GuardarOpcionEntregaAsync(OpcionEntregaDto opcion)
        {
            try
            {
                using var conn = new SqlConnection(_connectionString);
                await conn.OpenAsync();
                if (opcion.Id == 0)
                {
                    string query = "INSERT INTO OpcionesEntrega (Nombre, CostoAdicional, Descripcion, Activo) VALUES (@Nombre, @CostoAdicional, @Descripcion, @Activo);";
                    using var cmd = new SqlCommand(query, conn);
                    cmd.Parameters.AddWithValue("@Nombre", opcion.Nombre);
                    cmd.Parameters.AddWithValue("@CostoAdicional", opcion.CostoAdicional);
                    cmd.Parameters.AddWithValue("@Descripcion", (object?)opcion.Descripcion ?? DBNull.Value);
                    cmd.Parameters.AddWithValue("@Activo", opcion.Activo);
                    return await cmd.ExecuteNonQueryAsync() > 0;
                }
                else
                {
                    string query = "UPDATE OpcionesEntrega SET Nombre = @Nombre, CostoAdicional = @CostoAdicional, Descripcion = @Descripcion, Activo = @Activo WHERE Id = @Id;";
                    using var cmd = new SqlCommand(query, conn);
                    cmd.Parameters.AddWithValue("@Nombre", opcion.Nombre);
                    cmd.Parameters.AddWithValue("@CostoAdicional", opcion.CostoAdicional);
                    cmd.Parameters.AddWithValue("@Descripcion", (object?)opcion.Descripcion ?? DBNull.Value);
                    cmd.Parameters.AddWithValue("@Activo", opcion.Activo);
                    cmd.Parameters.AddWithValue("@Id", opcion.Id);
                    return await cmd.ExecuteNonQueryAsync() > 0;
                }
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Error al guardar opción de entrega.");
                return false;
            }
        }

        public async Task<bool> EliminarVehiculoAsync(int id, int usuarioId)
        {
            try
            {
                using var conn = new SqlConnection(_connectionString);
                await conn.OpenAsync();

                string query = "DELETE FROM Vehiculos WHERE Id = @Id AND UsuarioId = @UsuarioId;";
                using var cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@Id", id);
                cmd.Parameters.AddWithValue("@UsuarioId", usuarioId);

                return await cmd.ExecuteNonQueryAsync() > 0;
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Error al eliminar vehículo.");
                return false;
            }
        }

        private List<ServiceGroup> GetFallbackGroups()
        {
            return new List<ServiceGroup>
            {
                new ServiceGroup { Id = 1, Name = "1. Lavado Premium", Description = "Lavado con foam, limpieza interior básica, aspirado, cristales, llantas", PriceCar = 1200, PriceJeepeta = 1500, PriceSuv = 1800, PriceCamioneta = 1800, PriceMinivan = 1200, PriceCamion = 2000 },
                new ServiceGroup { Id = 2, Name = "2. Limpieza Profunda Interior", Description = "Vapor, limpieza profunda de asientos y alfombras, eliminación de olores", PriceCar = 4000, PriceJeepeta = 6000, PriceSuv = 7000, PriceCamioneta = 6000, PriceMinivan = 4000, PriceCamion = 7000 },
                new ServiceGroup { Id = 3, Name = "3. Brillado + Cera", Description = "Descontaminación química y mecánica, protección con cera", PriceCar = 6500, PriceJeepeta = 8500, PriceSuv = 11000, PriceCamioneta = 11000, PriceMinivan = 6500 },
                new ServiceGroup { Id = 4, Name = "4. Corrección + Cerámica M888", Description = "Descontaminación completa, pulido correctivo, aplicación de cerámica (3–4 años)", PriceCar = 18000, PriceJeepeta = 22000, PriceSuv = 28000, PriceCamioneta = 25000 },
                new ServiceGroup { Id = 5, Name = "5. Plan Premium Mensual", Description = "4 lavados Premium al mes (1 semanal), prioridad en agenda", PriceCar = 10000, PriceJeepeta = 12000, PriceSuv = 16000, PriceCamioneta = 14000 },
                new ServiceGroup { Id = 6, Name = "1.5 Lavado Premium & Cera", Description = "Lavado con foam, limpieza interior básica, aspirado, cristales, cera a mano", PriceCar = 2000, PriceJeepeta = 2300, PriceSuv = 2600, PriceCamioneta = 2600 },
                new ServiceGroup { Id = 7, Name = "Meguiar’s Ultimate Wash & Wax®", Description = "Producto de 48 oz para lavado y mantenimiento cerámico", PriceCar = 1700, PriceJeepeta = 1700, PriceSuv = 1700, PriceCamioneta = 1700, PriceMinivan = 1700, PriceCamion = 1700 }
            };
        }
    }
}
