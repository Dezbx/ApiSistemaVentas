using Ventas.Domain.Entities.Security;
using Ventas.Domain.Interfaces.Repositories.Common;

namespace Ventas.Domain.Interfaces.Repositories.Security
{
    public interface IRolRepository : IAuditableRepository<Rol>
    {
        Task <bool> ExisteDescripcionAsync(string descripcion, int? excluirRolId = null);
        Task <Rol?> ObtenerPorDescripcionAsync(string descripcion);
        Task <bool> EliminarFisicoAsync(int id, int usuarioId);    
    }
}
