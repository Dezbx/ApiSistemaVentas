using Ventas.Domain.Entities.Common;

namespace Ventas.Domain.Entities.Security
{
    public class Rol : AuditableEntity
    {
        public int RolId { get; set; }
        public string Descripcion { get; private set; } = string.Empty;

        protected Rol() { } // Para EF Core

        //Este constructor sirve para garantizar que un Rol nazca siempre válido desde el dominio.
        public Rol(string descripcion, int createdBy)
        {
            SetDescripcion(descripcion);
            SetCreated(createdBy);
        }

        //revisar si es valido xd
        public void ValidarRol()
        {
            SetDescripcion(Descripcion);
        }   
        private void SetDescripcion(string descripcion)
        {
            if (string.IsNullOrWhiteSpace(descripcion))
                throw new ArgumentException("La descripción del rol es obligatoria");

            if (descripcion.Length > 20)
                throw new ArgumentException("La descripción no puede superar los 20 caracteres");

            Descripcion = descripcion.Trim();
        }
    }
}
