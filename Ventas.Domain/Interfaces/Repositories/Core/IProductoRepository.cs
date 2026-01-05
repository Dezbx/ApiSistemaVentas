using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Ventas.Domain.Entities.Core;
using Ventas.Domain.Interfaces.Repositories.Common;
using Ventas.Domain.ValueObjects.Core;

namespace Ventas.Domain.Interfaces.Repositories.Core
{
    public interface IProductoRepository : IAuditableRepository<Producto>
    {
        // 1. Búsqueda por SKU (Value Object) - Esencial para inventario
        Task<Producto?> ObtenerPorSkuAsync(Sku sku);

        // 2. Gestión de Stock (Para el método "requiere reposición" de tu entidad)
        Task<IEnumerable<Producto>> ObtenerBajoStockAsync();

        // 3. Filtro por Categoría (Clave para reportes en Power BI y la UI)
        Task<IEnumerable<Producto>> ObtenerPorCategoriaAsync(int categoriaId);

        // 4. Validación de duplicados antes de insertar en SQL Server
        Task<bool> ExisteSkuAsync(Sku sku);

        // 5. Buscador para la interfaz de Ventas (Nombre parcial o SKU)
        Task<IEnumerable<Producto>> BuscarAsync(string criterio);
    }
}
