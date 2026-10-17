using System;
using Microsoft.Data.SqlClient;

class Program
{
    static void Main()
    {
        string connStr = "Server=184.168.122.69;Database=AGSDB;User Id=AplicationServer;Password=DesignaServer123456*;TrustServerCertificate=true;Connection Timeout=15;";
        try
        {
            using var conn = new SqlConnection(connStr);
            conn.Open();
            Console.WriteLine("=== CONEXIÓN EXITOSA A AGSDB ===");

            string query = @"
                SELECT 
                    s.name AS SchemaName,
                    t.name AS TableName,
                    p.rows AS RowCounts
                FROM 
                    sys.tables t
                INNER JOIN 
                    sys.schemas s ON t.schema_id = s.schema_id
                INNER JOIN 
                    sys.indexes i ON t.object_id = i.object_id
                INNER JOIN 
                    sys.partitions p ON i.object_id = p.object_id AND i.index_id = p.index_id
                WHERE 
                    t.is_ms_shipped = 0 AND i.index_id < 2
                ORDER BY 
                    s.name, t.name;";

            using var cmd = new SqlCommand(query, conn);
            using var reader = cmd.ExecuteReader();
            int count = 0;
            Console.WriteLine($"\n{"Esquema",-15} | {"Nombre de Tabla",-35} | {"Filas",-10}");
            Console.WriteLine(new string('-', 68));
            while (reader.Read())
            {
                count++;
                string schema = reader.GetString(0);
                string table = reader.GetString(1);
                long rows = reader.GetInt64(2);
                Console.WriteLine($"{schema,-15} | {table,-35} | {rows,-10}");
            }

            if (count == 0)
            {
                Console.WriteLine("No se encontraron tablas en la base de datos.");
            }
            else
            {
                Console.WriteLine(new string('-', 68));
                Console.WriteLine($"Total de tablas encontradas: {count}");
            }
        }
        catch (Exception ex)
        {
            Console.WriteLine($"Error al conectar a la base de datos: {ex.Message}");
        }
    }
}
