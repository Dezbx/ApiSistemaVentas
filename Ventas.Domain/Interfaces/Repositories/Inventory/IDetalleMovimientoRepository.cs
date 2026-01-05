using Ventas.Domain.Entities.Inventory;
using Ventas.Domain.Interfaces.Repositories.Common;

namespace Ventas.Domain.Interfaces.Repositories.Inventory
{
    public interface IDetalleMovimientoRepository : IGenericRepository<DetalleMovimiento>
    {
        // 1. Obtener todos los artículos de un movimiento específico
        // Esencial para mostrar el "cuerpo" de una nota de entrada o salida
        Task<IEnumerable<DetalleMovimiento>> ObtenerPorMovimientoIdAsync(int movimientoId);

        // 2. Obtener el historial de movimientos de un producto específico
        // Crucial para el Kárdex de inventario
        Task<IEnumerable<DetalleMovimiento>> ObtenerPorProductoIdAsync(int productoId);

        // 3. Consultar productos movidos en una sede específica
        // Útil para reportes de rotación de inventario por local
        Task<IEnumerable<DetalleMovimiento>> ObtenerPorSedeIdAsync(int sedeId);

        // 4. Sumar total de cantidades movidas de un producto en un periodo
        // Ayuda a calcular el stock final sin recorrer toda la tabla
        Task<decimal> SumarCantidadMovidaAsync(int productoId, int tipoMovimientoId, int periodoId);
    }
}
