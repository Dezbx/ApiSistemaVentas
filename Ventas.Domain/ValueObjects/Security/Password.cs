using System.Text;

namespace Ventas.Domain.ValueObjects.Security
{
    public record Password
    {
        public byte[] Hash { get; }
        public byte[] Salt { get; }

        private Password(byte[] hash, byte[] salt)
        {
            Hash = hash ?? throw new ArgumentNullException(nameof(hash));
            Salt = salt ?? throw new ArgumentNullException(nameof(salt));
        }

        public static Password Crear(string passwordPlana)
        {
            if (string.IsNullOrWhiteSpace(passwordPlana))
                throw new ArgumentException("La contraseña es obligatoria");

            if (passwordPlana.Length < 8)
                throw new ArgumentException("La contraseña debe tener al menos 8 caracteres");

            using var hmac = new System.Security.Cryptography.HMACSHA512();
            var salt = hmac.Key;
            var hash = hmac.ComputeHash(Encoding.UTF8.GetBytes(passwordPlana));

            return new Password(hash, salt);
        }

        public static Password FromHash(byte[] hash, byte[] salt)
        {
            if (hash == null || hash.Length == 0)
                throw new ArgumentException("Hash inválido");

            if (salt == null || salt.Length == 0)
                throw new ArgumentException("Salt inválido");

            return new Password(hash, salt);
        }

        public bool Verificar(string passwordPlana)
        {
            using var hmac = new System.Security.Cryptography.HMACSHA512(Salt);
            var computedHash = hmac.ComputeHash(Encoding.UTF8.GetBytes(passwordPlana));
            return computedHash.SequenceEqual(Hash);
        }
    }
}
