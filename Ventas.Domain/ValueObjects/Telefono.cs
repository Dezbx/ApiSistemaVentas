using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Text.RegularExpressions;
using System.Threading.Tasks;

namespace Ventas.Domain.ValueObjects
{
    public record Telefono
    {
        public string Valor { get; }

        private Telefono (string valor) => Valor = valor;

        public static Telefono Crear(string telefono)
        {
            if (string.IsNullOrWhiteSpace(telefono))
                throw new ArgumentException("El teléfono no puede estar vacío.");

            // Limpieza: dejamos solo números y el símbolo '+' para códigos de país
            var telefonoLimpio = Regex.Replace(telefono.Trim(), @"[^\d+]", "");

            if (telefonoLimpio.Length < 7 || telefonoLimpio.Length > 15)
                throw new ArgumentException("El teléfono debe tener entre 7 y 15 caracteres.");

            // Validación de formato: debe empezar opcionalmente con '+' seguido de números
            if (!Regex.IsMatch(telefonoLimpio, @"^\+?[0-9]+$"))
                throw new ArgumentException("El formato del teléfono no es válido");

            return new Telefono(telefonoLimpio);
        }
        public override string ToString() => Valor;
        public static implicit operator string(Telefono telefono) => telefono.Valor;
    }
}
