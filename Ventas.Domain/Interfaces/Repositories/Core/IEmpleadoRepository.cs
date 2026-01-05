using Ventas.Domain.Entities.Core;
using Ventas.Domain.Interfaces.Repositories.Common;

namespace Ventas.Domain.Interfaces.Repositories.Core
{
    public interface IEmpleadoRepository : IAuditableRepository<Empleado>
    {
        // 1. Obtener empleados por Sede (Relacionado al método CambiarSede)
        Task<IEnumerable<Empleado>> ObtenerPorSedeIdAsync(int sedeId);

        // 2. Buscar por número de documento (Usa el Value Object NumeroDocumento)
        Task<Empleado?> ObtenerPorNumeroDocumentoAsync(string numeroDocumento);

        // 3. Verificar si un usuario ya está asignado a otro empleado
        // (Relacionado al método AsignarUsuario de tu entidad)
        Task<bool> ExisteUsuarioAsignadoAsync(int usuarioId);

        // 4. Buscar empleados por cargo
        Task<IEnumerable<Empleado>> ObtenerPorCargoIdAsync(int cargoId);

        // 5. Validar duplicidad de correo electrónico antes de actualizar contacto
        Task<bool> ExisteCorreoAsync(string correo);
    }
}
