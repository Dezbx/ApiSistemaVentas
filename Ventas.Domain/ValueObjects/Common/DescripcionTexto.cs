using Ventas.Domain.Entities.Common;

namespace Ventas.Domain.ValueObjects.Common
{
    public record DescripcionTexto : TextoValidado
    {
        private const string RegexAlfanumerico = @"^[a-zA-Z0-9áéíóúÁÉÍÓÚñÑ\s\.,\-]+$";

        private DescripcionTexto(string valor, int longitud, string campo)
            : base(valor, longitud, RegexAlfanumerico, campo) { }

        // El método Crear ahora recibe la longitud obligatoria o con un default
        public static DescripcionTexto Crear(string valor, int longitud, string campo = "Descripción")
            => new(valor, longitud, campo);

        public static implicit operator string(DescripcionTexto desc) => desc.Valor;
    }
}
