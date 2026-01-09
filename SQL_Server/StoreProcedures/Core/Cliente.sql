USE SistemaVentasBD
GO

CREATE OR ALTER PROCEDURE core.Cliente_spObtenerPorId 
(
    @ClienteId INT
)
AS
    BEGIN
        SET NOCOUNT ON;
        SELECT
            C.ClienteId,
            C.ClienteUsuarioId,
            C.ClienteTipoDocumentoId,
            C.Paterno,
            C.Materno,
            C.Nombres,
            C.NumeroDocumento,
            C.Correo,
            C.Telefono,
            C.Sexo,
            C.FechaNacimiento,
            C.Direccion,
            C.EstadoConstanteId
        FROM core.Cliente AS C
        INNER JOIN compartido.Constante AS CO 
            ON C.EstadoConstanteId = CO.ConstanteId
        INNER JOIN core.ClienteTipoDocumento AS CTD
            ON C.ClienteTipoDocumentoId = CTD.ClienteTipoDocumentoId
        WHERE C.ClienteId = @ClienteId
            AND C.IsDeleted = 0;
    END
GO

CREATE OR ALTER PROCEDURE core.Cliente_spObtenerTodos 
AS
    BEGIN
        SET NOCOUNT ON;
        SELECT
            C.ClienteId,
            C.ClienteUsuarioId,
            C.ClienteTipoDocumentoId,
            C.Paterno,
            C.Materno,
            C.Nombres,
            C.NumeroDocumento,
            C.Correo,
            C.Telefono,
            C.Sexo,
            C.FechaNacimiento,
            C.Direccion,
            C.EstadoConstanteId
        FROM core.Cliente AS C
    END
GO
CREATE OR ALTER PROCEDURE core.Cliente_spAgregar 
CREATE OR ALTER PROCEDURE core.Cliente_spActualizar 
CREATE OR ALTER PROCEDURE core.Cliente_spExistePorId
CREATE OR ALTER PROCEDURE core.Cliente_spContarTotal 
CREATE OR ALTER PROCEDURE core.Cliente_spAgregarVarios 
CREATE OR ALTER PROCEDURE core.Cliente_spActualizarVarios 
CREATE OR ALTER PROCEDURE core.Cliente_spDesactivarVarios 
CREATE OR ALTER PROCEDURE core.Cliente_spActivarVarios
CREATE OR ALTER PROCEDURE core.Cliente_spObtenerEliminados
CREATE OR ALTER PROCEDURE core.Cliente_spEliminarLogico
CREATE OR ALTER PROCEDURE core.Cliente_spPROPIOS:
CREATE OR ALTER PROCEDURE core.Cliente_spObtenerPorNumeroDocumento
CREATE OR ALTER PROCEDURE core.Cliente_spExisteCorreo
CREATE OR ALTER PROCEDURE core.Cliente_spObtenerPorEstadoConstanteId
CREATE OR ALTER PROCEDURE core.Cliente_spExisteUsuarioVinculado
CREATE OR ALTER PROCEDURE core.Cliente_spBuscarPorNombreCompleto

/*
    ClienteId					INT,
    ClienteUsuarioId			INT, 
    ClienteTipoDocumentoId		INT,
    Paterno						NVARCHAR (50), 
    Materno						NVARCHAR (50), 
    Nombres						NVARCHAR (50), 
    NumeroDocumento				NVARCHAR (20),
    Correo						NVARCHAR (100),
    Telefono					NVARCHAR (15), 
    Sexo						NCHAR (1), 
    FechaNacimiento				DATE,
    Direccion					NVARCHAR (200),
    EstadoConstanteId			INT,
    -- Auditoria
    CreatedAt		DATETIME2(0),
    CreatedBy		INT,           
    UpdatedAt		DATETIME2(0), 
    UpdatedBy		INT, 
    IsDeleted		BIT

GENERICOS:
ObtenerPorId
ObtenerTodos 
Agregar 
Actualizar 
ExistePorId
ContarTotal 
AgregarVarios 
ActualizarVarios 
DesactivarVarios 
ActivarVarios
AUDITORIA:
ObtenerEliminados
EliminarLogico
PROPIOS:
ObtenerPorNumeroDocumento
ExisteCorreo
ObtenerPorEstadoConstanteId
ExisteUsuarioVinculado
BuscarPorNombreCompleto
*/