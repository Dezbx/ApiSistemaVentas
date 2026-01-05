using System.Text.RegularExpressions;

namespace Ventas.Domain.ValueObjects.Shared
{
    public record NumeroDocumento
    {
        public string Valor { get; }

        private NumeroDocumento(string valor) => Valor = valor;

        public static NumeroDocumento Crear(string numero)
        {
            if (string.IsNullOrWhiteSpace(numero))
                throw new ArgumentException("El número de documento es obligatorio, no puede estar vacío.");

            var numeroLimpio = numero.Trim();

            if (numeroLimpio.Length > 20)
                throw new ArgumentException("El número de documento no puede exceder los 20 caracteres.");

            if (numeroLimpio.Length < 8)
                throw new ArgumentException("El número de documento debe tener al menos 8 caracteres.");

            // Esto cubre DNI (solo números), RUC (solo números) y Pasaportes (letras y números)
            if (!Regex.IsMatch(numeroLimpio, @"^[a-zA-Z0-9]+$"))
                throw new ArgumentException("El número de documento solo puede contener letras y números");

            return new NumeroDocumento(numeroLimpio);
        }

        public override string ToString() => Valor;

        // Operador implícito para facilitar el uso en Dapper
        public static implicit operator string(NumeroDocumento numero) => numero.Valor;
    }
}
