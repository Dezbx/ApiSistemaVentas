using Ventas.Domain.Entities.Common;
using Ventas.Domain.Entities.Shared;
using Ventas.Domain.ValueObjects.Core;

namespace Ventas.Domain.Entities.Core
{
    public class Venta : AuditableEntity
    {
        public int VentaId { get; private set; }
        public int VentaClienteId { get; private set; }
        public virtual Cliente Cliente { get; private set; } = null!;
        public int VentaTipoPagoId { get; private set; }
        public virtual TipoPago TipoPago { get; private set; } = null!;
        public Precio Total { get; private set; } = null!;
        public DateTime Fecha { get; private set; }
        public int EstadoConstanteId { get; private set; }

        public virtual ICollection<DetalleVenta> Detalles { get; private set; } = new List<DetalleVenta>();

        protected Venta() { }
        public Venta(int clienteId, int tipoPagoId, Precio total, int estadoId, int createdBy)
        {
            if (clienteId <= 0) throw new ArgumentException("Cliente inválido");
            if (total.Valor < 0) throw new ArgumentException("El total no puede ser negativo");

            VentaClienteId = clienteId;
            VentaTipoPagoId = tipoPagoId;
            Total = total;
            EstadoConstanteId = estadoId;
            Fecha = DateTime.UtcNow;

            SetCreated(createdBy); // Método de AuditableEntity
        }

        public void CambiarEstado(int nuevoEstadoId, int updatedBy)
        {
            EstadoConstanteId = nuevoEstadoId;
            SetUpdated(updatedBy);
        }
    }
}
