using Ventas.Domain.Entities.Auditing;

namespace Ventas.Domain.Interfaces.Repositories.Inventory
{
    public interface IAuditRepository
    {
        Task GuardarRastroAsync(AuditLog rastro);
        Task<IEnumerable<AuditLog>> ObtenerHistorialPorEntidadAsync(string tablaNombre, int entidadId);
        Task<IEnumerable<AuditLog>> ObtenerActividadUsuarioAsync(int usuarioId, DateTime desde, DateTime hasta);
    }

}
