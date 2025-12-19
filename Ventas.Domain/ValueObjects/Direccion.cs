using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Ventas.Domain.ValueObjects
{
    public record Direccion
    {
        public string Valor { get; }

        private Direccion(string valor) => Valor = valor;

        public static Direccion Crear(string direccion)
        {
            if (string.IsNullOrWhiteSpace(direccion))
                throw new ArgumentException("La dirección es obligatoria");

            if (direccion.Length > 200)
                throw new ArgumentException("La dirección no puede superar los 150 caracteres");

            if (direccion.Length < 5)
                throw new ArgumentException("La dirección es demasiado corta");

            return new Direccion(direccion.Trim());
        }

        public override string ToString() => Valor;

        // Operador implícito para facilitar el uso en Dapper y lógica de negocio
        public static implicit operator string(Direccion direccion) => direccion.Valor;
    }
}
