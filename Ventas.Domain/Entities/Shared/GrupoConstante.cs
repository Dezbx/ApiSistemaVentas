using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Ventas.Domain.ValueObjects;

namespace Ventas.Domain.Entities.Shared
{
    public class GrupoConstante
    {
        public int GrupoConstanteId { get; set; }
        public DescripcionTexto Descripcion { get; private set; } = null!;
        public bool IsDeleted { get; private set; }

        protected GrupoConstante() { } // Para EF Core / Dapper

        public GrupoConstante(DescripcionTexto descripcion)
        {
            Descripcion = descripcion ?? throw new ArgumentNullException(nameof(descripcion));
            IsDeleted = false;
        }

        public void CambiarDescripcion(DescripcionTexto nuevaDescripcion)
        {
            Descripcion = nuevaDescripcion ?? throw new ArgumentNullException(nameof(nuevaDescripcion));
        }

        public void Desactivar()
        {
            IsDeleted = true;
        }
    }
}
