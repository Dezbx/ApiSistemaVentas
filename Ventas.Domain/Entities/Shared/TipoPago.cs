using Ventas.Domain.ValueObjects.Common;

namespace Ventas.Domain.Entities.Shared
{
    public class TipoPago
    {
        public int TipoPagoId { get; private set; }
        public DescripcionTexto Descripcion { get; private set; } = null!;
        public bool IsDeleted { get; private set; }
        protected TipoPago() { } // Para EF Core / Dapper  
        public TipoPago(DescripcionTexto descripcion)
        {
            Descripcion = descripcion ?? throw new ArgumentException(nameof(descripcion));
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
