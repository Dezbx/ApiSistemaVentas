using Ventas.Domain.Entities.Core;
using Ventas.Domain.Interfaces.Repositories.Common;

namespace Ventas.Domain.Interfaces.Repositories.Core
{
    public interface IClienteRepository: IAuditableRepository<Cliente>
    {
        // 1. Búsqueda por documento único (DNI/RUC) 
        // Crucial para el método de validación de identidad
        Task<Cliente?> ObtenerPorNumeroDocumentoAsync(string numeroDocumento);

        // 2. Búsqueda por correo electrónico
        // Relacionado al método ActualizarInformación (Correo)
        Task<bool> ExisteCorreoAsync(string correo);

        // 3. Obtener clientes por su estado (usando Constantes)
        // Relacionado a la propiedad EstadoConstanteId
        Task<IEnumerable<Cliente>> ObtenerPorEstadoConstanteIdAsync(int estadoId);

        // 4. Verificar si un Usuario ya está vinculado a un cliente
        // Relacionado al método AsignarUsuario
        Task<bool> ExisteUsuarioVinculadoAsync(int usuarioId);

        // 5. Búsqueda por nombres o apellidos 
        // Útil para filtros de búsqueda en la UI
        Task<IEnumerable<Cliente>> BuscarPorNombreCompletoAsync(string criterio);
    }
}
