using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Ventas.Domain.ValueObjects;

namespace Ventas.Domain.Entities.Core
{
    public class Cargo
    {
        public int CargoId { get; private set; }
        public DescripcionTexto Descripcion { get; private set; } = null!;
        public bool IsDeleted { get; private set; }

        protected Cargo() { } // Para EF Core / Dapper

        public Cargo(DescripcionTexto descripcion)
        {
            Descripcion = descripcion ?? throw new ArgumentException (nameof(descripcion));
            IsDeleted = false;
        }
        public void CambiarDescripcion(DescripcionTexto descripcion)
        {
            Descripcion = descripcion ?? throw new ArgumentException(nameof(descripcion));
        }
        public void Desactivar()
        {
            IsDeleted = true;
        }
    }
}
