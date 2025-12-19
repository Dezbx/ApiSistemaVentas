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

        private Cantidad(int valor)
        {
            if (valor < 0)
                throw new ArgumentException("La cantidad no puede ser negativa.");

            Valor = valor;
        }

        public static Cantidad Crear(int valor) => new Cantidad(valor);

        // Lógica de inventario
        public Cantidad Sumar(int cantidad) => new Cantidad(Valor + cantidad);

        public Cantidad Restar(int cantidad)
        {
            if (Valor - cantidad < 0)
                throw new InvalidOperationException("No hay suficiente stock para realizar la operación.");
            return new Cantidad(Valor - cantidad);
        }

        public override string ToString() => Valor.ToString();

        public static implicit operator int(Cantidad cantidad) => cantidad.Valor;
    }
}
