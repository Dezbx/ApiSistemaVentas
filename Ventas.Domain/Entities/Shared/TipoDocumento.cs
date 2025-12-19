using Ventas.Domain.ValueObjects;

namespace Ventas.Domain.Entities.Shared
{
    public class TipoDocumento
    {
        public int TipoDocumentoId { get; private set; }
        public DescripcionTexto Descripcion { get; private set; } = null!;
        public bool IsDeleted { get; private set; }

        protected TipoDocumento() { } // Para EF Core / Dapper  

        public TipoDocumento(DescripcionTexto descripcion)
        {
            Descripcion = descripcion?? throw new ArgumentException(nameof(descripcion));
            IsDeleted = false;
        }

        public void CambiarDescripcion(DescripcionTexto nuevaDescripcion)
        {
            Descripcion = nuevaDescripcion ?? throw new ArgumentException(nameof(nuevaDescripcion));
        }

        public void Desactivar()
        {
            IsDeleted = true;
        }
    }
}
