using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Text.RegularExpressions;
using System.Threading.Tasks;

namespace Ventas.Domain.ValueObjects
{
    public record NombreUsuario
    {
        public string Valor { get; }

        private NombreUsuario(string valor) => Valor = valor;

        public static NombreUsuario Crear(string nombreUsuario)
        {
            if (string.IsNullOrWhiteSpace(nombreUsuario))
                throw new ArgumentException("El nombre de usuario es obligatorio");

            if (nombreUsuario.Length > 50)
                throw new ArgumentException("El nombre de usuario no puede superar los 50 caracteres");

            if (!Regex.IsMatch(nombreUsuario, @"^[a-zA-Z0-9_\-\.]+$"))
                throw new ArgumentException("El nombre de usuario solo puede contener letras, números, guiones, guiones bajos y puntos");

            return new NombreUsuario(nombreUsuario.Trim());
        }

        public override string ToString() => Valor;
        public static implicit operator string(NombreUsuario nombre) => nombre.Valor;
    }
}
