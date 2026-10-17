using System;
using Microsoft.Data.SqlClient;

namespace BlazorAGS.Services
{
    public class DbInitializer
    {
        public static void Initialize(string connectionString)
        {
            try
            {
                using var conn = new SqlConnection(connectionString);
                conn.Open();
                string script = @"
                IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'Roles')
                BEGIN
                    CREATE TABLE Roles (
                        Id INT IDENTITY(1,1) PRIMARY KEY,
                        Nombre NVARCHAR(50) NOT NULL UNIQUE,
                        Descripcion NVARCHAR(255) NULL
                    );
                END

                IF NOT EXISTS (SELECT * FROM Roles WHERE Nombre = 'Admin')
                    INSERT INTO Roles (Nombre, Descripcion) VALUES ('Admin', 'Administrador del Sistema');
                
                IF NOT EXISTS (SELECT * FROM Roles WHERE Nombre = 'Cliente')
                    INSERT INTO Roles (Nombre, Descripcion) VALUES ('Cliente', 'Usuario Cliente para Reservas');

                -- Eliminar Rol Tecnico si existe
                DELETE FROM Roles WHERE Nombre = 'Tecnico';

                IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'Usuarios')
                BEGIN
                    CREATE TABLE Usuarios (
                        Id INT IDENTITY(1,1) PRIMARY KEY,
                        Nombre NVARCHAR(100) NOT NULL,
                        Correo NVARCHAR(150) NOT NULL UNIQUE,
                        Telefono NVARCHAR(20) NULL,
                        PasswordHash NVARCHAR(255) NOT NULL,
                        RolId INT NOT NULL,
                        Activo BIT NOT NULL DEFAULT 1,
                        FechaRegistro DATETIME NOT NULL DEFAULT GETDATE(),
                        FOREIGN KEY (RolId) REFERENCES Roles(Id)
                    );
                END

                -- Garantizar rol Admin para carlos.sanchez.despero@gmail.com
                UPDATE Usuarios 
                SET RolId = (SELECT Id FROM Roles WHERE Nombre = 'Admin') 
                WHERE Correo = 'carlos.sanchez.despero@gmail.com';

                IF NOT EXISTS (SELECT * FROM sys.columns WHERE object_id = OBJECT_ID('Usuarios') AND name = 'LavadosCompletados')
                BEGIN
                    ALTER TABLE Usuarios ADD LavadosCompletados INT NOT NULL DEFAULT 0;
                END

                IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'Reservas')
                BEGIN
                    CREATE TABLE Reservas (
                        Id INT IDENTITY(1,1) PRIMARY KEY,
                        UsuarioId INT NULL,
                        ClienteNombre NVARCHAR(150) NOT NULL,
                        ClienteCorreo NVARCHAR(150) NULL,
                        ClienteTelefono NVARCHAR(50) NOT NULL,
                        FechaReserva DATETIME NOT NULL,
                        OpcionEntrega NVARCHAR(50) NOT NULL DEFAULT 'Taller',
                        MontoTotal DECIMAL(18,2) NOT NULL DEFAULT 0,
                        Estado NVARCHAR(50) NOT NULL DEFAULT 'Pendiente',
                        EsLavadoGratis BIT NOT NULL DEFAULT 0,
                        FechaCreacion DATETIME NOT NULL DEFAULT GETDATE(),
                        FOREIGN KEY (UsuarioId) REFERENCES Usuarios(Id) ON DELETE SET NULL
                    );
                END

                IF NOT EXISTS (SELECT * FROM sys.columns WHERE object_id = OBJECT_ID('Reservas') AND name = 'EsLavadoGratis')
                BEGIN
                    ALTER TABLE Reservas ADD EsLavadoGratis BIT NOT NULL DEFAULT 0;
                END

                IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'ReservaDetalles')
                BEGIN
                    CREATE TABLE ReservaDetalles (
                        Id INT IDENTITY(1,1) PRIMARY KEY,
                        ReservaId INT NOT NULL,
                        TipoVehiculo NVARCHAR(50) NULL,
                        Marca NVARCHAR(50) NOT NULL,
                        Modelo NVARCHAR(50) NOT NULL,
                        Anio NVARCHAR(10) NULL,
                        Color NVARCHAR(30) NULL,
                        PaqueteServicio NVARCHAR(150) NOT NULL,
                        Precio DECIMAL(18,2) NOT NULL DEFAULT 0,
                        FOREIGN KEY (ReservaId) REFERENCES Reservas(Id) ON DELETE CASCADE
                    );
                END

                IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'ReservaEntrega')
                BEGIN
                    CREATE TABLE ReservaEntrega (
                        Id INT IDENTITY(1,1) PRIMARY KEY,
                        ReservaId INT NOT NULL,
                        TipoEntrega NVARCHAR(50) NOT NULL,
                        DireccionRecogida NVARCHAR(255) NULL,
                        Notas NVARCHAR(500) NULL,
                        FOREIGN KEY (ReservaId) REFERENCES Reservas(Id) ON DELETE CASCADE
                    );
                END

                IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'Vehiculos')
                BEGIN
                    CREATE TABLE Vehiculos (
                        Id INT IDENTITY(1,1) PRIMARY KEY,
                        UsuarioId INT NOT NULL,
                        Tipo NVARCHAR(50) NOT NULL,
                        Marca NVARCHAR(50) NOT NULL,
                        Modelo NVARCHAR(50) NOT NULL,
                        Anio NVARCHAR(10) NULL,
                        Color NVARCHAR(30) NULL,
                        Placa NVARCHAR(20) NULL,
                        FechaRegistro DATETIME NOT NULL DEFAULT GETDATE(),
                        FOREIGN KEY (UsuarioId) REFERENCES Usuarios(Id) ON DELETE CASCADE
                    );
                END

                IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'ReservaMeta')
                BEGIN
                    CREATE TABLE ReservaMeta (
                        Id INT IDENTITY(1,1) PRIMARY KEY,
                        ReservaId INT NOT NULL,
                        MetaKey NVARCHAR(100) NOT NULL,
                        MetaValue NVARCHAR(MAX) NULL,
                        FOREIGN KEY (ReservaId) REFERENCES Reservas(Id) ON DELETE CASCADE
                    );
                END

                IF NOT EXISTS (SELECT * FROM sys.columns WHERE object_id = OBJECT_ID('ReservaDetalles') AND name = 'VehiculoId')
                BEGIN
                    ALTER TABLE ReservaDetalles ADD VehiculoId INT NULL;
                    ALTER TABLE ReservaDetalles ADD CONSTRAINT FK_ReservaDetalles_Vehiculos FOREIGN KEY (VehiculoId) REFERENCES Vehiculos(Id) ON DELETE SET NULL;
                END

                -- 1. Categorías de Vehículos
                IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'CategoriasVehiculo')
                BEGIN
                    CREATE TABLE CategoriasVehiculo (
                        Id INT IDENTITY(1,1) PRIMARY KEY,
                        Nombre NVARCHAR(50) NOT NULL UNIQUE,
                        Codigo NVARCHAR(50) NOT NULL UNIQUE,
                        Activo BIT NOT NULL DEFAULT 1
                    );

                    INSERT INTO CategoriasVehiculo (Nombre, Codigo) VALUES 
                    ('Automóvil (Car)', 'Car'),
                    ('Jeepeta', 'Jeepeta'),
                    ('SUV', 'Suv'),
                    ('Camioneta', 'Camioneta'),
                    ('Minivan', 'Minivan'),
                    ('Camión', 'Camion'),
                    ('Camión Dos Ejes', 'CamionDosEjes'),
                    ('Tráiler', 'Trailer');
                END

                -- 2. Bloqueos de Calendario (Fechas específicas o Días recurrentes)
                IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'BloqueosCalendario')
                BEGIN
                    CREATE TABLE BloqueosCalendario (
                        Id INT IDENTITY(1,1) PRIMARY KEY,
                        FechaBloqueada DATETIME NULL,
                        DiaSemana INT NULL, -- 0=Domingo, 6=Sábado
                        Motivo NVARCHAR(200) NULL,
                        EsRecurrente BIT NOT NULL DEFAULT 0,
                        FechaRegistro DATETIME NOT NULL DEFAULT GETDATE()
                    );
                END

                -- 3. Opciones de Entrega con Costo Adicional
                IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'OpcionesEntrega')
                BEGIN
                    CREATE TABLE OpcionesEntrega (
                        Id INT IDENTITY(1,1) PRIMARY KEY,
                        Nombre NVARCHAR(100) NOT NULL,
                        CostoAdicional DECIMAL(18,2) NOT NULL DEFAULT 0,
                        Descripcion NVARCHAR(255) NULL,
                        Activo BIT NOT NULL DEFAULT 1
                    );

                    INSERT INTO OpcionesEntrega (Nombre, CostoAdicional, Descripcion) VALUES 
                    ('Entrega Directa en Taller', 0.00, 'El cliente lleva y retira el vehículo en el taller'),
                    ('Pick-up & Delivery V.I.P.', 500.00, 'Recogemos y entregamos el vehículo en la ubicación especificada');
                END";

                using (var cmd = new SqlCommand(script, conn))
                {
                    cmd.ExecuteNonQuery();
                }
            }
            catch (Exception ex)
            {
                Console.WriteLine($"[DbInitializer] Error: {ex.Message}");
            }
        }

        private static void ImportarHistoricoMySQL(SqlConnection conn)
        {
            try
            {
                string sqlFilePath = Path.Combine(AppDomain.CurrentDomain.BaseDirectory, "i10196611_hb8x1.sql");
                if (!File.Exists(sqlFilePath))
                {
                    sqlFilePath = @"d:\BlazorAGS\i10196611_hb8x1.sql";
                }

                if (!File.Exists(sqlFilePath)) return;

                string[] lines = File.ReadAllLines(sqlFilePath);

                var bookingsDict = new Dictionary<long, (int customerId, decimal totalPrice, string status, DateTime createdAt)>();
                var metaDict = new Dictionary<long, Dictionary<string, string>>();
                var detailsList = new List<(long bookingId, string vehicleInfo, string vehicleType, decimal subtotal)>();
                var deliverySet = new HashSet<long>();

                string currentSection = "";

                foreach (var rawLine in lines)
                {
                    string line = rawLine.Trim();
                    if (line.StartsWith("INSERT INTO `jboo_agselect_bookings`"))
                    {
                        currentSection = "bookings";
                        continue;
                    }
                    else if (line.StartsWith("INSERT INTO `jboo_agselect_booking_delivery`"))
                    {
                        currentSection = "delivery";
                        continue;
                    }
                    else if (line.StartsWith("INSERT INTO `jboo_agselect_booking_details`"))
                    {
                        currentSection = "details";
                        continue;
                    }
                    else if (line.StartsWith("INSERT INTO `jboo_agselect_booking_meta`"))
                    {
                        currentSection = "meta";
                        continue;
                    }
                    else if (line.StartsWith("CREATE TABLE") || line.StartsWith("ALTER TABLE") || line.StartsWith("--"))
                    {
                        currentSection = "";
                        continue;
                    }

                    if (string.IsNullOrWhiteSpace(line)) continue;

                    if (currentSection == "bookings")
                    {
                        var matches = System.Text.RegularExpressions.Regex.Matches(line, @"\((\d+),\s*(\d+),\s*(\d+),\s*([\d\.]+),\s*'([^']+)',\s*'([^']+)'\)");
                        foreach (System.Text.RegularExpressions.Match m in matches)
                        {
                            long bId = long.Parse(m.Groups[1].Value);
                            int cId = int.Parse(m.Groups[2].Value);
                            decimal price = decimal.Parse(m.Groups[4].Value, System.Globalization.CultureInfo.InvariantCulture);
                            string status = m.Groups[5].Value;
                            DateTime dt = DateTime.Parse(m.Groups[6].Value);
                            bookingsDict[bId] = (cId, price, status, dt);
                        }
                    }
                    else if (currentSection == "delivery")
                    {
                        var matches = System.Text.RegularExpressions.Regex.Matches(line, @"\((\d+),\s*(\d+),\s*(\d+)\)");
                        foreach (System.Text.RegularExpressions.Match m in matches)
                        {
                            long bId = long.Parse(m.Groups[2].Value);
                            deliverySet.Add(bId);
                        }
                    }
                    else if (currentSection == "meta")
                    {
                        var matches = System.Text.RegularExpressions.Regex.Matches(line, @"\((\d+),\s*(\d+),\s*'([^']+)',\s*'([^']*)'\)");
                        foreach (System.Text.RegularExpressions.Match m in matches)
                        {
                            long bId = long.Parse(m.Groups[2].Value);
                            string key = m.Groups[3].Value;
                            string val = m.Groups[4].Value;

                            if (!metaDict.ContainsKey(bId)) metaDict[bId] = new Dictionary<string, string>();
                            metaDict[bId][key] = val;
                        }
                    }
                    else if (currentSection == "details")
                    {
                        var matches = System.Text.RegularExpressions.Regex.Matches(line, @"\((\d+),\s*(\d+),\s*'([^']*)',\s*'([^']*)',\s*(\d+),\s*'([^']*)',\s*([\d\.]+)\)");
                        foreach (System.Text.RegularExpressions.Match m in matches)
                        {
                            long bId = long.Parse(m.Groups[2].Value);
                            string vInfo = m.Groups[3].Value;
                            string vType = m.Groups[4].Value;
                            decimal sub = decimal.Parse(m.Groups[7].Value, System.Globalization.CultureInfo.InvariantCulture);
                            detailsList.Add((bId, vInfo, vType, sub));
                        }
                    }
                }

                foreach (var kvp in bookingsDict.OrderBy(x => x.Key))
                {
                    long bookingId = kvp.Key;
                    var bInfo = kvp.Value;

                    string clientName = "Cliente Histórico";
                    string clientEmail = "";
                    string clientPhone = "";
                    DateTime fechaReserva = bInfo.createdAt;

                    if (metaDict.TryGetValue(bookingId, out var meta))
                    {
                        if (meta.TryGetValue("user_name", out var n) && !string.IsNullOrWhiteSpace(n)) clientName = n.Trim();
                        if (meta.TryGetValue("user_email", out var e) && !string.IsNullOrWhiteSpace(e)) clientEmail = e.Trim();
                        if (meta.TryGetValue("user_phone", out var p) && !string.IsNullOrWhiteSpace(p)) clientPhone = p.Trim();
                        if (meta.TryGetValue("booking_date", out var dStr) && DateTime.TryParse(dStr, out var dParsed)) fechaReserva = dParsed;
                    }

                    string opcionEntrega = deliverySet.Contains(bookingId) ? "Pick-up & Delivery V.I.P." : "Entrega Directa en Taller";
                    string estado = bInfo.status.ToLower() switch
                    {
                        "completed" => "Completado",
                        "cancelled" => "Cancelado",
                        _ => "Pendiente"
                    };

                    string checkQuery = "SELECT COUNT(*) FROM Reservas WHERE FechaReserva = @FechaReserva AND ClienteNombre = @ClienteNombre AND MontoTotal = @MontoTotal;";
                    using (var checkCmd = new SqlCommand(checkQuery, conn))
                    {
                        checkCmd.Parameters.AddWithValue("@FechaReserva", fechaReserva);
                        checkCmd.Parameters.AddWithValue("@ClienteNombre", clientName);
                        checkCmd.Parameters.AddWithValue("@MontoTotal", bInfo.totalPrice);
                        int count = (int)checkCmd.ExecuteScalar();
                        if (count > 0) continue;
                    }

                    string insertReservaSql = @"
                        INSERT INTO Reservas (UsuarioId, ClienteNombre, ClienteCorreo, ClienteTelefono, FechaReserva, OpcionEntrega, MontoTotal, Estado, FechaCreacion)
                        OUTPUT INSERTED.Id
                        VALUES (NULL, @ClienteNombre, @ClienteCorreo, @ClienteTelefono, @FechaReserva, @OpcionEntrega, @MontoTotal, @Estado, @FechaCreacion);";

                    int newReservaId = 0;
                    using (var insCmd = new SqlCommand(insertReservaSql, conn))
                    {
                        insCmd.Parameters.AddWithValue("@ClienteNombre", clientName);
                        insCmd.Parameters.AddWithValue("@ClienteCorreo", clientEmail);
                        insCmd.Parameters.AddWithValue("@ClienteTelefono", clientPhone);
                        insCmd.Parameters.AddWithValue("@FechaReserva", fechaReserva);
                        insCmd.Parameters.AddWithValue("@OpcionEntrega", opcionEntrega);
                        insCmd.Parameters.AddWithValue("@MontoTotal", bInfo.totalPrice);
                        insCmd.Parameters.AddWithValue("@Estado", estado);
                        insCmd.Parameters.AddWithValue("@FechaCreacion", bInfo.createdAt);
                        newReservaId = (int)insCmd.ExecuteScalar();
                    }

                    var curDetails = detailsList.Where(d => d.bookingId == bookingId).ToList();
                    if (curDetails.Any())
                    {
                        foreach (var det in curDetails)
                        {
                            string[] parts = det.vehicleInfo.Split(' ', StringSplitOptions.RemoveEmptyEntries);
                            string marca = parts.Length > 0 ? parts[0] : "Vehículo";
                            string modelo = parts.Length > 1 ? string.Join(" ", parts.Skip(1)) : "Estándar";

                            string insDetSql = @"
                                INSERT INTO ReservaDetalles (ReservaId, TipoVehiculo, Marca, Modelo, Anio, Color, PaqueteServicio, Precio)
                                VALUES (@ReservaId, @TipoVehiculo, @Marca, @Modelo, '', '', 'Tratamiento Detailing', @Precio);";

                            using var insDetCmd = new SqlCommand(insDetSql, conn);
                            insDetCmd.Parameters.AddWithValue("@ReservaId", newReservaId);
                            insDetCmd.Parameters.AddWithValue("@TipoVehiculo", det.vehicleType);
                            insDetCmd.Parameters.AddWithValue("@Marca", marca);
                            insDetCmd.Parameters.AddWithValue("@Modelo", modelo);
                            insDetCmd.Parameters.AddWithValue("@Precio", det.subtotal);
                            insDetCmd.ExecuteNonQuery();
                        }
                    }
                    else
                    {
                        string insDetSql = @"
                            INSERT INTO ReservaDetalles (ReservaId, TipoVehiculo, Marca, Modelo, Anio, Color, PaqueteServicio, Precio)
                            VALUES (@ReservaId, 'Car', 'Cliente', 'General', '', '', 'Servicio Detailing', @Precio);";

                        using var insDetCmd = new SqlCommand(insDetSql, conn);
                        insDetCmd.Parameters.AddWithValue("@ReservaId", newReservaId);
                        insDetCmd.Parameters.AddWithValue("@Precio", bInfo.totalPrice);
                        insDetCmd.ExecuteNonQuery();
                    }
                }
            }
            catch
            {
                // Silencioso si falla la lectura del archivo histórico
            }
        }
    }
}
