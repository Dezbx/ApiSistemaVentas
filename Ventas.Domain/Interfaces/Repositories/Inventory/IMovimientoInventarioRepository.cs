using Ventas.Domain.Entities.Inventory;
using Ventas.Domain.Interfaces.Repositories.Common;

namespace Ventas.Domain.Interfaces.Repositories.Inventory
{
    public interface IMovimientoInventarioRepository : IAuditableRepository<MovimientoInventario>
    {
        // 1. Obtener movimientos por Sede
        // Fundamental para el control de stock local
        Task<IEnumerable<MovimientoInventario>> ObtenerPorSedeIdAsync(int sedeId);

        // 2. Filtrar por Tipo de Movimiento (Entradas, Salidas, Traslados)
        Task<IEnumerable<MovimientoInventario>> ObtenerPorTipoMovimientoIdAsync(int tipoMovimientoId);

        // 3. Consultar movimientos por rango de fechas
        // Crítico para cierres de inventario y auditorías
        Task<IEnumerable<MovimientoInventario>> ObtenerPorRangoFechasAsync(DateTime inicio, DateTime fin);

        // 4. Obtener movimientos por Periodo (Relación con la tabla Periodo)
        Task<IEnumerable<MovimientoInventario>> ObtenerPorPeriodoIdAsync(int periodoId);

        // 5. Obtener la cabecera con sus detalles en una sola consulta
        // Evita el problema de las N+1 consultas en Entity Framework
        Task<MovimientoInventario?> ObtenerConDetallesPorIdAsync(int id);

        // 6. Validar si existe un movimiento asociado a un documento de referencia 
        // (Ej: Factura de compra o Guía)
        Task<bool> ExisteReferenciaAsync(string documentoReferencia);
    }
}
