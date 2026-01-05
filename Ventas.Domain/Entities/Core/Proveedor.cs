using Ventas.Domain.Entities.Common;
using Ventas.Domain.Entities.Shared;
using Ventas.Domain.ValueObjects.Common;
using Ventas.Domain.ValueObjects.Core;
using Ventas.Domain.ValueObjects.Shared;

namespace Ventas.Domain.Entities.Core
{
    public class Proveedor : AuditableEntity
    {
        public int ProveedorId { get; private set; }
        public int TipoDocumentoId { get; private set; }
        public virtual TipoDocumento TipoDocumento { get; private set; } = null!;
        public DescripcionTexto Nombre { get; private set; } = null!;
        public NumeroDocumento NumeroIdentificacionFiscal { get; private set; } = null!;
        public Direccion DireccionFiscal { get; private set; } = null!;
        public Telefono Telefono { get; private set; } = null!;
        public CorreoElectronico? Correo { get; private set; } // Opcional en SQL
        public NombrePersona NombreCompletoContacto { get; private set; } = null!;
        public DescripcionTexto NumeroDeCuenta { get; private set; } = null!;
        public int EstadoConstanteId { get; private set; }

        protected Proveedor() { } // Para EF Core / Dapper
        public Proveedor(
            int tipoDocumentoId,
            DescripcionTexto nombre,
            NumeroDocumento numeroIdentificacionFiscal,
            Direccion direccionFiscal,
            Telefono telefono,
            CorreoElectronico? correo,
            NombrePersona nombreCompletoContacto,
            DescripcionTexto numeroDeCuenta,
            int estadoConstanteId,
            int createdBy)
        {
            TipoDocumentoId = tipoDocumentoId;
            Nombre = nombre ?? throw new ArgumentNullException(nameof(nombre));
            NumeroIdentificacionFiscal = numeroIdentificacionFiscal ?? throw new ArgumentNullException(nameof(numeroIdentificacionFiscal));
            DireccionFiscal = direccionFiscal ?? throw new ArgumentNullException(nameof(direccionFiscal));
            Telefono = telefono ?? throw new ArgumentNullException(nameof(telefono));
            Correo = correo ?? throw new ArgumentNullException(nameof(correo));
            NombreCompletoContacto = nombreCompletoContacto ?? throw new ArgumentNullException(nameof(nombreCompletoContacto));
            NumeroDeCuenta = numeroDeCuenta ?? throw new ArgumentNullException(nameof(numeroDeCuenta));
            EstadoConstanteId = estadoConstanteId;
            SetCreated(createdBy); // Método de AuditableEntity
        }

        public void ActualizarContacto(Telefono nuevoTelefono, CorreoElectronico? nuevoCorreo, Direccion nuevaDireccion, int updatedBy)
        {
            Telefono = nuevoTelefono ?? throw new ArgumentNullException(nameof(nuevoTelefono));
            Correo = nuevoCorreo;
            DireccionFiscal = nuevaDireccion ?? throw new ArgumentNullException(nameof(nuevaDireccion));
            SetUpdated(updatedBy);
        }

        public void ActualizarInformacionBancaria(DescripcionTexto nuevaCuenta, int updatedBy)
        {
            NumeroDeCuenta = nuevaCuenta ?? throw new ArgumentNullException(nameof(nuevaCuenta));
            SetUpdated(updatedBy);
        }

        public void CambiarEstado(int nuevoEstadoId, int updatedBy)
        {
            EstadoConstanteId = nuevoEstadoId;
            SetUpdated(updatedBy);
        }
    }
}
