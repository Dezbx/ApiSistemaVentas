using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Ventas.Domain.Entities.Core;
using Ventas.Domain.Interfaces.Repositories.Common;

namespace Ventas.Domain.Interfaces.Repositories.Core
{
    public interface IDetalleVenta : IGenericRepository<DetalleVenta>
    {
        // 1. Obtener todos los productos de una venta específica
        // Esencial para mostrar el detalle en la UI o para el proceso de impresión
        Task<IEnumerable<DetalleVenta>> ObtenerPorVentaIdAsync(int ventaId);

        // 2. Obtener el historial de ventas de un producto específico
        // Útil para ver la rotación de un artículo
        Task<IEnumerable<DetalleVenta>> ObtenerPorProductoIdAsync(int productoId);

        // 3. Obtener los productos más vendidos (Top N)
        // Datos clave para los tableros de Power BI
        Task<IEnumerable<dynamic>> ObtenerProductosMasVendidosAsync(int top);

        // 4. Validar si un producto ha sido vendido alguna vez
        // Útil para reglas de negocio (ej: no permitir borrar un producto con ventas)
        Task<bool> ProductoTieneVentasAsync(int productoId);

        // 5. Sumar la cantidad total vendida de un producto en un periodo
        Task<int> SumarCantidadVendidaAsync(int productoId, int periodoId);
    }
}
