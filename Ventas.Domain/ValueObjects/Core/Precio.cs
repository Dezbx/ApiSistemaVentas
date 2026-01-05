namespace Ventas.Domain.ValueObjects.Core
{
    public record Precio
    {
        public decimal Valor { get; }
        public string Moneda { get; }

        private Precio(decimal valor, string moneda)
        {
            if (valor < 0)
                throw new ArgumentException("El precio no puede ser negativo.");

            Valor = valor;
            Moneda = moneda;
        }

        public static Precio Crear(decimal valor, string moneda = "PEN")
            => new Precio(valor, moneda);

        // Operaciones útiles para el dominio
        public Precio AplicarDescuento(decimal porcentaje)
            => new Precio(Valor * (1 - porcentaje / 100), Moneda);

        public override string ToString() => $"{Moneda} {Valor:N2}";

        public static implicit operator decimal(Precio precio) => precio.Valor;
    }
}
