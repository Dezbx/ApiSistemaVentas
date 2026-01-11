using Dapper;
using System.Data;
using Ventas.Domain.Entities.Shared; // Ajusta a tu namespace real
using Ventas.Infraestructure.Persistence.Context;
using Ventas.Domain.Interfaces.Repositories.Shared;

namespace Ventas.Infraestructure.Persistence.Repositories.Shared
{
    public class GrupoConstanteRepository : IGrupoConstanteRepository
    {
        private readonly ISqlConnectionFactory _connectionFactory;

        public GrupoConstanteRepository(ISqlConnectionFactory connectionFactory)
        {
            _connectionFactory = connectionFactory;
        }

        public async Task<bool> ActivarVariosAsync(IEnumerable<GrupoConstante> entidades)
        {
            throw new NotImplementedException();
        }

        public async Task<bool> ActualizarAsync(GrupoConstante entidad)
        {
            throw new NotImplementedException();
        }

        public async Task<bool> ActualizarVariosAsync(IEnumerable<GrupoConstante> entidades)
        {
            throw new NotImplementedException();
        }

        public async Task<int> AgregarAsync(GrupoConstante entidad)
        {
            throw new NotImplementedException();
        }

        public async Task<bool> AgregarVariosAsync(IEnumerable<GrupoConstante> entidades)
        {
            throw new NotImplementedException();
        }

        public async Task<int> ContarTotalAsync()
        {
            throw new NotImplementedException();
        }

        public async Task<bool> DesactivarVariosAsync(IEnumerable<GrupoConstante> entidades)
        {
            throw new NotImplementedException();
        }

        public async Task<bool> ExisteDescripcionAsync(string descripcion, int? excluirId = null)
        {
            throw new NotImplementedException();
        }

        public async Task<bool> ExistePorIdAsync(int id)
        {
            throw new NotImplementedException();
        }

        public async Task<GrupoConstante?> ObtenerPorDescripcionAsync(string descripcion)
        {
            throw new NotImplementedException();
        }

        public async Task<GrupoConstante?> ObtenerPorIdAsync(int id)
        {
            using var connection = _connectionFactory.CrearConexion();
            // Usamos QueryFirstOrDefaultAsync porque esperamos un solo resultado o nulo
            return await connection.QueryFirstOrDefaultAsync<GrupoConstante>(
                "compartido.GrupoConstante_spObtenerId", // Nombre del SP
                new { GrupoConstanteId = id },           // Parámetro esperado por el SP
                commandType: CommandType.StoredProcedure
                );
        }

        public Task<IEnumerable<GrupoConstante>> ObtenerTodosAsync()
        {
            throw new NotImplementedException();
        }
    }
}