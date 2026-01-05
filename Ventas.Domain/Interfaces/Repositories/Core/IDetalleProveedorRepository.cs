using Ventas.Domain.Entities.Core;
using Ventas.Domain.Interfaces.Repositories.Common;

namespace Ventas.Domain.Interfaces.Repositories.Core
{
    public interface IDetalleProveedorRepository : IGenericRepository<DetalleProveedor>
    {
        // 1. Obtener todos los detalles vinculados a un proveedor específico
        // Esencial para ver la lista de productos o servicios que ofrece un solo proveedor
        Task<IEnumerable<DetalleProveedor>> ObtenerPorProveedorIdAsync(int proveedorId);

        // 2. Obtener los proveedores que suministran un producto específico
        // Útil para el módulo de compras cuando buscas quién vende X producto
        Task<IEnumerable<DetalleProveedor>> ObtenerPorProductoIdAsync(int productoId);

        // 3. Eliminar todos los detalles de un proveedor 
        // Útil si vas a reasignar su lista de productos masivamente
        Task<bool> EliminarPorProveedorIdAsync(int proveedorId);
    }
}
