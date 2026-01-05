using Ventas.Domain.Entities.Core;
using Ventas.Domain.Interfaces.Repositories.Common;

namespace Ventas.Domain.Interfaces.Repositories.Core
{

    public interface IProveedorRepository : IAuditableRepository<Proveedor>
    {
        // 1. Búsqueda por RUC o Documento de Identidad
        // Crucial para evitar duplicidad de proveedores en SQL Server
        Task<Proveedor?> ObtenerPorNumeroDocumentoAsync(string numeroDocumento);

        // 2. Validar existencia de correo o teléfono
        // Relacionado con tu método "Actualizar contacto" (teléfono, correo)
        Task<bool> ExisteCorreoAsync(string correo);
        Task<bool> ExisteTelefonoAsync(string telefono);

        // 3. Obtener proveedores por rubro o categoría de productos
        // Útil para filtros en el módulo de compras e inventario
        Task<IEnumerable<Proveedor>> ObtenerPorRubroAsync(string rubro);

        // 4. Buscar por número de cuenta bancaria
        // Relacionado con tu método "Actualizar información bancaria"
        Task<Proveedor?> ObtenerPorCuentaBancariaAsync(string numeroCuenta);

        // 5. Verificar si tiene deudas o movimientos pendientes
        // Importante antes de cambiar su estado a "Inactivo"
        Task<bool> TieneMovimientosPendientesAsync(int proveedorId);
    }
}
