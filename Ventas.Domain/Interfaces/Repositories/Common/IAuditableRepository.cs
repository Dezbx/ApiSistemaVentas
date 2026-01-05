using Ventas.Domain.Entities.Common;

namespace Ventas.Domain.Interfaces.Repositories.Common
{
    public interface IAuditableRepository<T> : IGenericRepository<T> where T : AuditableEntity
    {
        // Gestión de Estado [cite: 80, 81]
        Task<IEnumerable<T>> ObtenerActivosAsync();
        Task<IEnumerable<T>> ObtenerEliminadosAsync();

        // Borrado y Restauración [cite: 120, 130]
        Task<bool> EliminarLogicoAsync(int id, int usuarioId);
        Task<bool> RestaurarAsync(int id, int usuarioId);

        // Conteos especializados [cite: 122, 133]
        Task<int> ContarActivosAsync();
        Task<int> ContarEliminadosAsync();
    }
}
