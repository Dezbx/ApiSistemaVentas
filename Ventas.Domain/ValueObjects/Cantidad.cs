using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Ventas.Domain.ValueObjects
{
    public record Cantidad
    {
        public int Valor { get; }

        private Cantidad(int valor) => Valor = valor > 0 ? valor : throw new ArgumentException("La cantidad debe ser mayor a cero");

        public static Cantidad Crear(int valor) => new(valor);

        public Cantidad Sumar(Cantidad otra) => new(Valor + otra.Valor);
    }
}
