using Ventas.Domain.Entities.Common;
using Ventas.Domain.Entities.Security;
using Ventas.Domain.Entities.Shared;
using Ventas.Domain.ValueObjects;

namespace Ventas.Domain.Entities.Core
{
    public class Empleado : AuditableEntity
    {
        public int EmpleadoId { get; private set; }
        public int UsuarioId { get; private set; }
        public Usuario Usuario { get; private set; } = null!;
        public int SedeId { get; private set; }
        public Sede Sede { get; private set; } = null!;
        public int TipoDocumentoId { get; private set; }
        public TipoDocumento TipoDocumento { get; private set; } = null!;
        public int CargoId { get; private set; }
        public Cargo Cargo { get; private set; } = null!;
        public string Paterno { get; private set; } = null!;
        public string Materno { get; private set; } = null!;
        public string Nombres { get; private set; } = null!;
        public NumeroDocumento NumeroDocumento { get; private set; } = null!;
        public CorreoElectronico Correo { get; private set; } = null!;
        public Telefono Telefono { get; private set; } = null!;
        public Sexo Sexo { get; private set; } = null!;
        public DateOnly FechaNacimiento { get; private set; }
        public Direccion Direccion { get; private set; } = null!;
        public int EstadoConstanteId { get; private set; }

        protected Empleado() { } // Para EF Core / Dapper

        // Constructor para garantizar un estado válido
        public Empleado(
            int sedeId, int tipoDocumentoId, int cargoId,
            string paterno, string materno, string nombres,
            NumeroDocumento numeroDocumento, CorreoElectronico correo,
            Telefono telefono, Sexo sexo, DateOnly fechaNacimiento,
            Direccion direccion, int estadoConstanteId, int createdBy)
        {
            // Validaciones de negocio básicas
            if (string.IsNullOrWhiteSpace(paterno)) throw new ArgumentException("El apellido paterno es requerido");
            if (string.IsNullOrWhiteSpace(materno)) throw new ArgumentException("El apellido paterno es requerido");
            if (string.IsNullOrWhiteSpace(nombres)) throw new ArgumentException("Los nombres son requeridos");

            // Asignación
            SedeId = sedeId;
            TipoDocumentoId = tipoDocumentoId;
            CargoId = cargoId;
            Paterno = paterno.Trim();
            Materno = materno.Trim();
            Nombres = nombres.Trim();
            NumeroDocumento = numeroDocumento;
            Correo = correo;
            Telefono = telefono;
            Sexo = sexo;
            FechaNacimiento = fechaNacimiento;
            Direccion = direccion;
            EstadoConstanteId = estadoConstanteId;

            SetCreated(createdBy); // Método de AuditableEntity
        }

        public void CambiarSede(int nuevaSedeId, int updatedBy)
        {
            if (nuevaSedeId <= 0) throw new ArgumentException("Sede inválida");
            SedeId = nuevaSedeId;
            SetUpdated(updatedBy);
        }

        public void ActualizarInformacionContacto(CorreoElectronico nuevoCorreo, Telefono nuevoTelefono, Direccion nuevaDireccion, int updatedBy)
        {
            Correo = nuevoCorreo ?? throw new ArgumentNullException(nameof(nuevoCorreo));
            Telefono = nuevoTelefono ?? throw new ArgumentNullException(nameof(nuevoTelefono));
            Direccion = nuevaDireccion ?? throw new ArgumentNullException(nameof(nuevaDireccion));
            SetUpdated(updatedBy);
        }

        public void AsignarUsuario(int usuarioId, int updatedBy)
        {
            if (usuarioId <= 0) throw new ArgumentException("Usuario inválido");
            UsuarioId = usuarioId;
            SetUpdated(updatedBy);
        }

        public void ActualizarEstado(int nuevoEstadoId, int updatedBy)
        {
            // Aquí podrías validar contra constantes específicas (ej. Activo, Inactivo)
            EstadoConstanteId = nuevoEstadoId;
            SetUpdated(updatedBy);
        }

        // Propiedad calculada útil para la UI
        public string NombreCompleto => $"{Nombres} {Paterno} {Materno}";
    }
}
