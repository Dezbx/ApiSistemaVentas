using Ventas.Domain.ValueObjects;

namespace Ventas.Domain.Entities.Core
{
    public class Categoria
    {
        public int CategoriaId { get; private set; } 
        public DescripcionTexto Nombre { get; private set; } = null!;
        public bool IsDeleted { get; private set; }

        protected Categoria() { } // Para EF Core / Dapper

        public Categoria(DescripcionTexto nombre)
        {
            Nombre = nombre ?? throw new ArgumentNullException(nameof(nombre));
            IsDeleted = false;
        }

        public void CambiarNombre(DescripcionTexto nuevoNombre)
        {
            Nombre = nuevoNombre ?? throw new ArgumentNullException(nameof(nuevoNombre));
        }

        public void Desactivar()
        {
            IsDeleted = true;
        }
    }
}
