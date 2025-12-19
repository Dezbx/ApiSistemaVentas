using Ventas.Domain.Entities.Common;
using Ventas.Domain.Entities.Shared;
using Ventas.Domain.ValueObjects;

namespace Ventas.Domain.Entities.Inventory
{
    public class MovimientoInventario : AuditableEntity
    {
        public int MovimientoInventarioId { get; private set; }
        public int MovimientoInventarioTipoMovimientoId { get; private set; }
        public virtual TipoMovimiento TipoMovimiento { get; private set; } = null!;
        public int MovimientoInventarioPeriodoId { get; private set; }
        public virtual Periodo Periodo { get; private set; } = null!;

        public DateTime Fecha{ get; private set; }
        public DescripcionTexto Motivo { get; private set; } = null!; // "Entrada" o "Salida"

        protected MovimientoInventario() { }

        public MovimientoInventario(
            int tipoMovimientoId,
            int periodoId,
            DescripcionTexto motivo,
            int createdBy)
        {
            if (tipoMovimientoId <= 0) throw new ArgumentException("El tipo de movimiento es requerido.");
            if (periodoId <= 0) throw new ArgumentException("El periodo es requerido.");

            MovimientoInventarioTipoMovimientoId = tipoMovimientoId;
            MovimientoInventarioPeriodoId = periodoId;

            // Usamos el límite de 200 definido en tu SQL para el motivo
            Motivo = motivo ?? throw new ArgumentNullException(nameof(motivo));

            Fecha = DateTime.UtcNow; // Se asigna la fecha actual del movimiento
            SetCreated(createdBy);
        }

        // Método de dominio para registrar el motivo con validación de longitud
        public void ActualizarMotivo(DescripcionTexto nuevoMotivo, int updatedBy)
        {
            Motivo = nuevoMotivo ?? throw new ArgumentNullException(nameof(nuevoMotivo));
            SetUpdated(updatedBy);
        }

    }
}
