using Ventas.Domain.Entities.Common;
using Ventas.Domain.ValueObjects;

namespace Ventas.Domain.Entities.Security
{
    public class Rol : AuditableEntity
    {
        public int RolId { get; set; }
        public DescripcionTexto Descripcion { get; private set; } = null!;

        protected Rol() { } // Para EF Core

        //Este constructor sirve para garantizar que un Rol nazca siempre válido desde el dominio.
        public Rol(DescripcionTexto descripcion, int createdBy)
        {
            Descripcion = descripcion ?? throw new ArgumentNullException(nameof(descripcion)); ;
            SetCreated(createdBy);
        }
        public void CambiarDescripcion(DescripcionTexto nuevaDescripcion, int updatedBy)
        {
            Descripcion = nuevaDescripcion ?? throw new ArgumentNullException(nameof(nuevaDescripcion));
            SetUpdated(updatedBy);
        }
    }
}
