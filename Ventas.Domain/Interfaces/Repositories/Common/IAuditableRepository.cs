using Ventas.Domain.Entities.Common;

namespace Ventas.Domain.Interfaces.Repositories.Common
{
    // Usamos 'T' para que devuelva la entidad real (Usuario, Producto, etc.)
    // Ponemos el 'where' para asegurar que solo se use con entidades que heredan de AuditableEntity
    public interface IAuditableRepository<T> : IGenericRepository<T> where T : AuditableEntity
    {
        // OJOOOOOO: 
        // La interfaz IGenericRepository<T> usa int id, pero la tabla AuditLog usa BIGINT (long en C#).
        
        
        // YA NO declaramos ObtenerPorId, Agregar, etc. (Ya los hereda de IGenericRepository)
        // Agregamos SOLO lo que es propio de auditoría
        Task<IEnumerable<T>> ObtenerEliminadosAsync();
        
        // El método de eliminar ahora es auditable porque recibe quién lo hace
        Task<bool> EliminarLogicoAsync(int id, int usuarioId);
    }
}