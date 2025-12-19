using System.Text.RegularExpressions;

namespace Ventas.Domain.Entities.Common
{
    public abstract record TextoValidado
    {
        public string Valor { get; }

        protected TextoValidado(string valor, int longitudMaxima, string regex, string nombreCampo)
        {
            if (string.IsNullOrWhiteSpace(valor))
                throw new ArgumentException($"El campo {nombreCampo} es obligatorio.");

            var valorLimpio = valor.Trim();

            if (valorLimpio.Length > longitudMaxima)
                throw new ArgumentException($"El campo {nombreCampo} no puede superar los {longitudMaxima} caracteres.");

            if (!Regex.IsMatch(valorLimpio, regex))
                throw new ArgumentException($"El campo {nombreCampo} contiene caracteres no permitidos.");

            Valor = valorLimpio;
        }

        public override string ToString() => Valor;
    }
}