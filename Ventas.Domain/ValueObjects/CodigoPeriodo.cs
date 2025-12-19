using System;
using System.Collections.Generic;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Ventas.Domain.Entities.Common;

namespace Ventas.Domain.ValueObjects
{
    public record CodigoPeriodo : TextoValidado
    {
        // Exactamente 6 dígitos numéricos
        private const string RegexPeriodo = @"^[0-9]{6}$";

        private CodigoPeriodo(string valor)
            : base(valor, 6, RegexPeriodo, "Periodo") { }

        public static CodigoPeriodo Crear(string valor)
        {
            var objeto = new CodigoPeriodo(valor);

            // Lógica extra: Validar que el mes (últimos 2 dígitos) sea entre 01 y 12
            int mes = int.Parse(valor.Substring(4, 2));
            if (mes < 1 || mes > 12)
                throw new ArgumentException("El mes del periodo debe estar entre 01 y 12.");

            return objeto;
        }

        public string ObtenerAnio() => Valor.Substring(0, 4);
        public string ObtenerMes() => Valor.Substring(4, 2);

        public static implicit operator string(CodigoPeriodo codigo) => codigo.Valor;
    }
}
