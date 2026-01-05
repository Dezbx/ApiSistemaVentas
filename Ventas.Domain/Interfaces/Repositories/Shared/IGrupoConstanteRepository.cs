using Ventas.Domain.Entities.Shared;
using Ventas.Domain.Interfaces.Repositories.Common;

namespace Ventas.Domain.Interfaces.Repositories.Shared
{
    public interface IGrupoConstanteRepository : IGenericRepository<GrupoConstante>
    {
        Task<GrupoConstante?> ObtenerPorDescripcionAsync(string descripcion);
        Task<bool> ExisteDescripcionAsync(string descripcion, int? excluirId = null);
    }
}
