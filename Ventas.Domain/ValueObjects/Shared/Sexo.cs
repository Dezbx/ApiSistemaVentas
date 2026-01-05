namespace Ventas.Domain.ValueObjects.Shared
{
    public record Sexo
    {
        public char Valor { get; }
        private Sexo(char valor) => Valor = valor;

        public static Sexo Masculino => new Sexo('M');
        public static Sexo Femenino => new Sexo('F');

        public static Sexo Crear(char valor)
        {
            char valorUpper = char.ToUpper(valor);

            if (valorUpper != 'M' && valorUpper != 'F')
                throw new ArgumentException("El sexo debe ser 'M' (Masculino) o 'F' (Femenino)");

            return new Sexo(valorUpper);
        }

        public bool EsMasculino() => Valor == 'M';
        public bool EsFemenino() => Valor == 'F';

        public override string ToString() => Valor.ToString();

        public static implicit operator char(Sexo sexo) => sexo.Valor;
    }
}
