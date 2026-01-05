using Ventas.Domain.Entities.Core;
using Ventas.Domain.Interfaces.Repositories.Common;
using Ventas.Domain.ValueObjects.Common;

namespace Ventas.Domain.Interfaces.Repositories.Core
{
    public interface ICargoRepository : IGenericRepository<Cargo>
    {
        // 1. Validar si ya existe un cargo con el mismo nombre para evitar el error de UNIQUE del SQL
        Task<bool> ExisteNombreAsync(DescripcionTexto nombre);

        // 3. Buscar un cargo específico por su descripción exacta
        Task<Cargo?> ObtenerPorNombreAsync(DescripcionTexto nombre);
    }
}
