using Microsoft.Data.SqlClient;
using Microsoft.Extensions.Configuration;
using System.Data;

namespace Ventas.Infraestructure.Persistence.Context;
public interface ISqlConnectionFactory
{
    IDbConnection CrearConexion();
}

public class SqlConnectionFactory : ISqlConnectionFactory
{
    private readonly string _connectionString;

    public SqlConnectionFactory(IConfiguration configuration)
    {
        _connectionString = configuration.GetConnectionString("DefaultConnection")
            ?? throw new ArgumentNullException("Cadena de conexión no encontrada.");
    }
    public IDbConnection CrearConexion() => new SqlConnection(_connectionString);
}
