namespace Ventas.Domain.ValueObjects.Shared
{
    public record CorreoElectronico
    {
        public string Valor { get; }

        private CorreoElectronico(string valor) => Valor = valor;

        public static CorreoElectronico Crear(string correo)
        {
            if (string.IsNullOrWhiteSpace(correo))
                throw new ArgumentException("El correo es obligatorio");

            if (correo.Length > 100)
                throw new ArgumentException("El correo no puede superar los 100 caracteres");

            if (!EsValido(correo))
                throw new ArgumentException("El correo no tiene un formato válido");

            return new CorreoElectronico(correo.Trim().ToLowerInvariant());
        }

        private static bool EsValido(string correo)
        {
            try
            {
                var mailAddress = new System.Net.Mail.MailAddress(correo);
                return mailAddress.Address == correo;
            }
            catch
            {
                return false;
            }
        }

        public override string ToString() => Valor;

        // Operadores implícitos para facilitar el uso
        public static implicit operator string(CorreoElectronico correo) => correo.Valor;
    }
}
