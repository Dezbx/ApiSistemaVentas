using Ventas.Domain.Entities.Common;

namespace Ventas.Domain.ValueObjects
{
    public record NombrePersona : TextoValidado
    {
        // Regla: Solo letras, espacios, tildes y ñ.
        private const string RegexLetras = @"^[a-zA-ZáéíóúÁÉÍÓÚñÑ\s]+$";

        private NombrePersona(string valor, string campo)
            : base(valor, 50, RegexLetras, campo) { }

        public static NombrePersona Crear(string valor, string campo = "Nombre")
            => new(valor, campo);

        public static implicit operator string(NombrePersona nombre) => nombre.Valor;
    }
}
