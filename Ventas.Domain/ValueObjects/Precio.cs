using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Ventas.Domain.ValueObjects
{
    public record Precio
    {
        public decimal Valor { get; }
        public string Moneda { get; } = "USD";

        private Precio(decimal valor) => Valor = valor >= 0 ? valor : throw new ArgumentException("El precio no puede ser negativo");

        public static Precio Crear(decimal valor) => new(valor);

        // Métodos para operaciones matemáticas
        public Precio AplicarDescuento(decimal porcentaje) => new(Valor * (1 - porcentaje / 100));
    }
}
