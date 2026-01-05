using Ventas.Domain.Entities.Security;
using Ventas.Domain.Interfaces.Repositories.Common;

namespace Ventas.Domain.Interfaces.Repositories.Security
{
    public interface IUsuarioRepository : IAuditableRepository<Usuario>
    {
        Task<bool> ExisteNombreUsuarioAsync(string nombreUsuario, int? excluirUsuarioId = null);
        Task<bool> ExisteCorreoAsync(string correo, int? excluirUsuarioId = null);
        Task<Usuario?> ObtenerPorNombreUsuarioAsync(string nombreUsuario);
        Task<int> ContarUsuariosPorRolIdAsync(int rolId);
        Task<bool> EliminarFisicoAsync(int id, int usuarioId);    
    }
}
