using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Ventas.Domain.ValueObjects;

namespace Ventas.Domain.Entities.Shared
{
    public class TipoMovimiento
    {
        public int TipoMovientoId { get; private set; }
        public DescripcionTexto Descripcion { get; private set; } = null!;
        public bool IsDeleted { get; private set; } = false;

        public TipoMovimiento() { } // Para EF Core / Dapper

        public TipoMovimiento(DescripcionTexto descripcion)
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

        public void Activar()
        {
            IsDeleted = false;
        }
    }
}
