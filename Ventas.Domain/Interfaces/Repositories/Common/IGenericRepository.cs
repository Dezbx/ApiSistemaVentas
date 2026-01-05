using Ventas.Domain.Entities.Common;

namespace Ventas.Domain.Interfaces.Repositories.Common
{
    public interface IGenericRepository<T> where T : class
    {
        // CRUD Básico [cite: 83, 84, 85, 86]
        Task<T?> ObtenerPorIdAsync(int id);
        Task<IEnumerable<T>> ObtenerTodosAsync();
        Task<int> AgregarAsync(T entidad);
        Task<bool> ActualizarAsync(T entidad);

        // Consultas comunes (Para evitar repetición en cada repo) [cite: 149, 151]
        Task<bool> ExisteAsync(int id);
        Task<int> ContarTotalAsync();

        // Operaciones Masivas (Basado en tu arquitectura de Tipos y Grupos) [cite: 152, 154]
        Task<bool> AgregarVariosAsync(IEnumerable<T> entidades);
        Task<bool> ActualizarVariosAsync(IEnumerable<T> entidades);
    }
}
