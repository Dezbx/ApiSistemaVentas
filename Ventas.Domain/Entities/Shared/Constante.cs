using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Ventas.Domain.Entities.Shared
{
    public class Constante
    {
        public int ConstanteId { get; set; }
        public int GrupoConstanteId { get; set; }
        public string Valor { get; set; } = string.Empty; //1,2,3,4,5, etc
        public string Descripcion { get; set; } = string.Empty; // Pago en proceso, pago en ... etc
        public int Orden { get; set; } // Indica el orden en que se mostrará la constante dentro de su grupo


        public void ValidarConstante()
        {
        }
    }
}
