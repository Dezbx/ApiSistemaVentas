using Ventas.Domain.Entities.Common;
using Ventas.Domain.ValueObjects;

namespace Ventas.Domain.Entities.Core
{
    public class Producto : AuditableEntity
    {
        public int ProductoId { get; private set; }
        public int ProductoCategoriaId { get; private set; }
        public virtual Categoria Categoria { get; private set; } = null!;
        public DescripcionTexto Nombre { get; private set; } = null!;
        public DescripcionTexto? Descripcion { get; private set; }
        public Sku CodigoSku { get; private set; } = null!;
        public Precio PrecioCompra { get; private set; } = null!;
        public Precio PrecioVenta  { get; private set; } = null!;
        public Cantidad Stock { get; private set; } = null!;
        public Cantidad StockMinimo { get; private set; } = null!;
        public DateTime FechaCreacion { get; private set; }

        protected Producto() { }

        public Producto(
            int productoCategoriaId,
            DescripcionTexto nombre,
            DescripcionTexto? descripcion,
            Sku codigoSku,
            Precio precioCompra,
            Precio precioVenta,
            Cantidad stock,
            Cantidad stockMinimo,
            int createdBy)
        {
            ProductoCategoriaId = productoCategoriaId;
            Nombre = nombre ?? throw new ArgumentNullException(nameof(nombre));
            Descripcion = descripcion;
            CodigoSku = codigoSku ?? throw new ArgumentNullException(nameof(codigoSku));
            PrecioCompra = precioCompra ?? throw new ArgumentNullException(nameof(precioCompra));
            PrecioVenta = precioVenta ?? throw new ArgumentNullException(nameof(precioVenta));
            Stock = stock ?? throw new ArgumentNullException(nameof(stock));
            StockMinimo = stockMinimo ?? throw new ArgumentNullException(nameof(stockMinimo));

            SetCreated(createdBy);
        }

        // --- MÉTODOS DE NEGOCIO ---

        public void ActualizarStock(Cantidad nuevoStock, int updatedBy)
        {
            Stock = nuevoStock ?? throw new ArgumentNullException(nameof(nuevoStock));
            SetUpdated(updatedBy);
        }

        public void AjustarPrecios(Precio compra, Precio venta, int updatedBy)
        {
            PrecioCompra = compra ?? throw new ArgumentNullException(nameof(compra));
            PrecioVenta = venta ?? throw new ArgumentNullException(nameof(venta));
            SetUpdated(updatedBy);
        }

        public bool RequiereReposicion() => Stock.Valor <= StockMinimo.Valor;
    }
}
