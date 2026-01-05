using Ventas.Domain.Entities.Core;
using Ventas.Domain.Interfaces.Repositories.Common;

namespace Ventas.Domain.Interfaces.Repositories.Core
{
    public interface IVentaRepository : IAuditableRepository<Venta>
    {
        // 1. Obtener la venta completa con su Cliente, Sede y lista de Productos
        // Crucial para imprimir el comprobante o ver el detalle en pantalla
        Task<Venta?> ObtenerVentaCompletaPorIdAsync(int id);

        // 2. Filtrar historial de ventas por cliente
        Task<IEnumerable<Venta>> ObtenerPorClienteIdAsync(int clienteId);

        // 3. Reporte de ventas por sede (Para comparar rendimiento de locales)
        Task<IEnumerable<Venta>> ObtenerPorSedeIdAsync(int sedeId);

        // 4. Buscador por rango de fechas
        // El Task más usado para cierres de caja y reportes diarios
        Task<IEnumerable<Venta>> ObtenerPorRangoFechasAsync(DateTime inicio, DateTime fin);

        // 5. Ventas por periodo contable (Relación con la tabla Periodo)
        Task<IEnumerable<Venta>> ObtenerPorPeriodoIdAsync(int periodoId);

        // 6. Obtener el correlativo del siguiente comprobante (Ej: "BOL-000543")
        Task<string> ObtenerUltimoCorrelativoAsync(int tipoDocumentoId);

        // 7. Calcular el monto total vendido en un periodo
        // Proporciona datos directos para los indicadores de Power BI
        Task<decimal> ObtenerMontoTotalPorPeriodoAsync(int periodoId);

        // 8. Datos para impresión de comprobante
        Task<Venta?> ObtenerDatosParaImpresionAsync(int ventaId);
    }
}
