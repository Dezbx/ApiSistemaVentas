using Ventas.Domain.Entities.Shared;
using Ventas.Domain.Interfaces.Repositories.Common;

namespace Ventas.Domain.Interfaces.Repositories.Shared
{
    public interface ITipoMovimientoRepository : IGenericRepository<TipoMovimiento>
    {
        // 1. Obtener por descripción exacta
        // Útil para validar el negocio al crear movimientos de inventario
        Task<TipoMovimiento?> ObtenerPorDescripcionAsync(string descripcion);

        // 2. Verificar si existe la descripción
        // Evita duplicados en la configuración de tipos de movimiento
        Task<bool> ExisteDescripcionAsync(string descripcion);

        // 3. Obtener tipos de movimiento por categoría de inventario
        // (Ej: Entradas vs Salidas) si decides clasificarlos
        Task<IEnumerable<TipoMovimiento>> ObtenerPorClasificacionAsync(string clasificacion);
    }
}
