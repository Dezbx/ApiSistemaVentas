using Ventas.Domain.Entities.Common;
using Ventas.Domain.Entities.Security;
using Ventas.Domain.Entities.Shared;
using Ventas.Domain.ValueObjects.Core;
using Ventas.Domain.ValueObjects.Shared;

namespace Ventas.Domain.Entities.Core
{
    public class Cliente : AuditableEntity
    {
        public int ClienteId { get; private set; }
        public int ClienteUsuarioId { get; private set; }
        public Usuario Usuario { get; private set; } = null!;
        public int TipoDocumentoId { get; private set; }
        public TipoDocumento TipoDocumento { get; private set; } = null!;
        public NombrePersona Paterno { get; private set; } = null!;
        public NombrePersona Materno { get; private set; } = null!;
        public NombrePersona Nombres { get; private set; } = null!;
        public NumeroDocumento NumeroDocumento { get; private set; } = null!;
        public CorreoElectronico Correo { get; private set; } = null!;
        public Telefono Telefono { get; private set; } = null!;
        public Sexo Sexo { get; private set; } = null!;
        public DateOnly FechaNacimiento { get; private set; }
        public Direccion Direccion { get; private set; } = null!;
        public int EstadoConstanteId { get; private set; }

        protected Cliente() { } // Para EF Core / Dapper

        //Constructor para garantizar un estado válido
        public Cliente(
            int clienteId, int clienteUsuarioId, int tipoDocumentoId,
            NombrePersona paterno, NombrePersona materno, NombrePersona nombres,
            NumeroDocumento numeroDocumento, CorreoElectronico correo, Telefono telefono,
            Sexo sexo, DateOnly fechaNacimiento, Direccion direccion, int estadoConstanteId, int createdBy)
        {
            // Asignación
            ClienteId = clienteId;
            ClienteUsuarioId = clienteUsuarioId;
            TipoDocumentoId = tipoDocumentoId;
            Paterno = paterno ?? throw new ArgumentNullException(nameof(paterno));
            Materno = materno ?? throw new ArgumentNullException(nameof(materno));
            Nombres = nombres ?? throw new ArgumentNullException(nameof(nombres));
            NumeroDocumento = numeroDocumento ?? throw new ArgumentNullException(nameof(numeroDocumento));
            Correo = correo ?? throw new ArgumentNullException(nameof(correo));
            Telefono = telefono ?? throw new ArgumentNullException(nameof(telefono));
            Sexo = sexo ?? throw new ArgumentNullException(nameof(sexo));
            FechaNacimiento = fechaNacimiento;
            Direccion = direccion ?? throw new ArgumentNullException(nameof(direccion));
            EstadoConstanteId = estadoConstanteId;

            SetCreated(createdBy); // Método de AuditableEntity
        }

        public void ActualizarInformacion(CorreoElectronico nuevoCorreo, Telefono nuevoTelefono, Direccion nuevaDireccion, int updatedBy)
        {
            Correo = nuevoCorreo ?? throw new ArgumentNullException(nameof(nuevoCorreo)); ;
            Telefono = nuevoTelefono ?? throw new ArgumentNullException(nameof(nuevoTelefono));
            Direccion = nuevaDireccion ?? throw new ArgumentNullException(nameof(nuevaDireccion));
            SetUpdated(updatedBy);
        }
        public void AsignarUsuario(int usuarioId, int updatedBy)
        {
            if (usuarioId <= 0) throw new ArgumentException("Usuario inválido");
            ClienteUsuarioId = usuarioId;
            SetUpdated(updatedBy);
        }
        public void CambiarEstado(int nuevoEstadoConstanteId, int updatedBy)
        {
            EstadoConstanteId = nuevoEstadoConstanteId;
            SetUpdated(updatedBy);
        }

    }
}
