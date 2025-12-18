using Ventas.Domain.Entities.Common;
using Ventas.Domain.ValueObjects;

namespace Ventas.Domain.Entities.Security
{
    public class Usuario : AuditableEntity
    {
        public int UsuarioId { get; private set; }
        public int RolId { get; private set; }
        public Rol Rol { get; private set; } = null!;

        // Usando Value Objects
        public NombreUsuario NombreUsuario { get; private set; } = null!;
        public CorreoElectronico Correo { get; private set; } = null!;
        public Password Password { get; private set; } = null!;
        public DateTime FechaRegistro { get; private set; }

        protected Usuario() { }

        public Usuario(Rol rol, NombreUsuario nombreUsuario, CorreoElectronico correo,
                      Password password, int createdBy)
        {
            SetRol(rol);
            NombreUsuario = nombreUsuario ?? throw new ArgumentNullException(nameof(nombreUsuario));
            Correo = correo ?? throw new ArgumentNullException(nameof(correo));
            Password = password ?? throw new ArgumentNullException(nameof(password));
            FechaRegistro = DateTime.UtcNow;
            SetCreated(createdBy);
        }

        // Métodos simplificados
        public void ActualizarCorreo(CorreoElectronico nuevoCorreo, int updatedBy)
        {
            Correo = nuevoCorreo ?? throw new ArgumentNullException(nameof(nuevoCorreo));
            SetUpdated(updatedBy);
        }

        public void CambiarPassword(Password nuevaPassword, int updatedBy)
        {
            Password = nuevaPassword ?? throw new ArgumentNullException(nameof(nuevaPassword));
            SetUpdated(updatedBy);
        }

        private void SetRol(Rol rol)
        {
            Rol = rol ?? throw new ArgumentNullException(nameof(rol), "El rol no puede ser nulo");
            RolId = rol.RolId;
        }
    }
}
