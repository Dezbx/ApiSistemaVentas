using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Ventas.Domain.Entities.Shared
{
    public class GrupoConstante
    {
        public int GrupoConstanteId { get; set; }
        public string Descripcion { get; set; } = string.Empty;
        public bool Activo { get; set; }

        public void ValidarGrupoConstante()
        {
        }
    }
}
