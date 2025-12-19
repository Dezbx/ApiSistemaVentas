using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Ventas.Domain.Entities.Core;
using Ventas.Domain.ValueObjects;

namespace Ventas.Domain.Entities.Inventory
{
    public class DetalleMovimiento
    {
        public int MovimientoInventarioId { get; private set; }
        public virtual MovimientoInventario MovimientoInventario { get; private set; } = null!;
        public int ProductoId { get; private set; }
        public virtual Producto Producto { get; private set; } = null!;
        public Cantidad Cantidad { get; private set; } = null!;

        protected DetalleMovimiento() { }

        public DetalleMovimiento(int movimientoInventarioId, int productoId, Cantidad cantidad)
        {
            if (movimientoInventarioId <= 0)
                throw new ArgumentException("ID de movimiento inválido.");

            if (productoId <= 0)
                throw new ArgumentException("ID de producto inválido.");

            MovimientoInventarioId = movimientoInventarioId;
            ProductoId = productoId;
            Cantidad = cantidad ?? throw new ArgumentNullException(nameof(cantidad));
        }
    }
}
