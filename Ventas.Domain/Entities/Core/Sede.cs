using Ventas.Domain.ValueObjects.Common;
using Ventas.Domain.ValueObjects.Core;

namespace Ventas.Domain.Entities.Core
{
    public class Sede
    {
        public int SedeId { get; private set; }
        public DescripcionTexto Descripcion { get; private set; } = null!;
        public Direccion Direccion { get; private set; } = null!;
        public bool IsDeleted { get; private set; }

        protected Sede() { } // Para EF Core / Dapper

        public Sede(DescripcionTexto descripcion, Direccion direccion)
        {
            Descripcion = descripcion ?? throw new ArgumentNullException(nameof(descripcion));
            Direccion = direccion ?? throw new ArgumentNullException(nameof(direccion));
            IsDeleted = false;
        }

        public void CambiarDescripcion(DescripcionTexto nuevaDescripcion)
        {
            Descripcion = nuevaDescripcion ?? throw new ArgumentNullException(nameof(nuevaDescripcion));
        }
        public void CambiarDireccion(Direccion nuevaDireccion)
        {
            Direccion = nuevaDireccion ?? throw new ArgumentNullException(nameof(nuevaDireccion));
        }
        public void Desactivar()
        {
            IsDeleted = true;
        }
    }
}
