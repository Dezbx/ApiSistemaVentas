using Ventas.Domain.ValueObjects.Common;

namespace Ventas.Domain.Entities.Shared
{
    public class Constante
    {
        public int ConstanteId { get; set; }
        public int GrupoConstanteId { get; set; }
        public string Valor { get; set; } = string.Empty; //1,2,3,4,5, etc
        public DescripcionTexto Descripcion { get; private set; } = null!; // Pago en proceso, pago en ... etc
        public int Orden { get; set; } // Indica el orden en que se mostrará la constante dentro de su grupo
        public bool IsDeleted { get; set; }

        protected Constante() { } // Para EF Core / Dapper

        public Constante(int grupoConstanteId, string valor, DescripcionTexto descripcion, int orden, bool isDeleted)
        {
            GrupoConstanteId = grupoConstanteId;
            Valor = valor;
            Descripcion = descripcion ?? throw new ArgumentNullException(nameof(descripcion));
            Orden = orden;
            IsDeleted = isDeleted;
        }

        public void CambiarDescripcion(DescripcionTexto nuevaDescripcion)
        {
            Descripcion = nuevaDescripcion ?? throw new ArgumentNullException(nameof(nuevaDescripcion));
        }

    }
}
