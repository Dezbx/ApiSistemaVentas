using Ventas.Domain.Entities.Common;

namespace Ventas.Domain.ValueObjects.Core
{
    public record Sku : TextoValidado
    {
        // Regla: 3 grupos de letras/números separados por guiones (mínimo)
        private const string RegexSku = @"^[A-Z0-9]+-[A-Z0-9]+-[A-Z0-9]+$";

        private Sku(string valor) : base(valor, 50, RegexSku, "SKU") { }

        public static Sku Crear(string valor) => new(valor.ToUpper());

        // Método de fábrica para la generación
        public static Sku Generar(string categoria, string marca, string atributo)
        {
            if (string.IsNullOrWhiteSpace(categoria) || string.IsNullOrWhiteSpace(marca) || string.IsNullOrWhiteSpace(atributo))
                throw new ArgumentException("Los componentes para generar el SKU son obligatorios.");

            // Tomamos las primeras 3 letras de cada parte para estandarizar
            string c = categoria.Trim().Substring(0, Math.Min(3, categoria.Length)).ToUpper();
            string m = marca.Trim().Substring(0, Math.Min(3, marca.Length)).ToUpper();
            string a = atributo.Trim().Substring(0, Math.Min(3, atributo.Length)).ToUpper();

            return new Sku($"{c}-{m}-{a}");
        }

        public static implicit operator string(Sku sku) => sku.Valor;
    }
}
