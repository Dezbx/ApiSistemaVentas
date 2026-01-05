using Ventas.Domain.ValueObjects.Core;

namespace Ventas.Domain.Entities.Core
{
    public class DetalleVenta
    {
        public int DetalleVentaId { get; private set; }
        public int VentaId { get; private set; }
        public virtual Venta Venta { get; private set; } = null!;
        public int ProductoId { get; private set; }
        public virtual Producto Producto { get; private set; } = null!;

        public Cantidad Cantidad { get; private set; } = null!;
        public Precio PrecioUnitario { get; private set; } = null!;

        // El SubTotal es calculado (Cantidad * Precio)
        public decimal SubTotal => Cantidad.Valor * PrecioUnitario.Valor;

        protected DetalleVenta() { } // Para Dapper

        public DetalleVenta(int productoId, Cantidad cantidad, Precio precioUnitario)
        {
            if (productoId <= 0) throw new ArgumentException("Producto inválido");

            ProductoId = productoId;
            Cantidad = cantidad ?? throw new ArgumentNullException(nameof(cantidad));
            PrecioUnitario = precioUnitario ?? throw new ArgumentNullException(nameof(precioUnitario));
        }
    }
}
