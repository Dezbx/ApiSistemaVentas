using Ventas.Domain.ValueObjects.Shared;

namespace Ventas.Domain.Entities.Shared
{
    public class Periodo
    {
        public int PeriodoId { get; private set; }
        public CodigoPeriodo Descripcion { get; private set; } = null!;
        public DateOnly FechaInicio { get; private set; }
        public DateOnly FechaFin { get; private set; }
        public bool IsDeleted { get; private set; }

        protected Periodo() { } // Para EF Core / Dapper

        public Periodo(CodigoPeriodo descripcion, DateOnly fechaInicio, DateOnly fechaFin)
        {
            if (fechaFin < fechaInicio)
                throw new ArgumentException("La fecha de fin no puede ser anterior a la fecha de inicio.");
            Descripcion = descripcion ?? throw new ArgumentException(nameof(descripcion));
            FechaInicio = fechaInicio;
            FechaFin = fechaFin;
            IsDeleted = false;
        }

        public void CambiarDescripcion(CodigoPeriodo nuevaDescripcion)
        {
            Descripcion = nuevaDescripcion ?? throw new ArgumentException(nameof(nuevaDescripcion));
        }
        public void Desactivar()
        {
            IsDeleted = true;
        }

        public void Activar()
        {
            IsDeleted = false;
        }
    }
}
