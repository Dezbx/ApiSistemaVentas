/*
	ProveedorId						INT 
	ProveedorTipoDocumentoId		INT 
	Nombre							NVARCHAR (100)
	NumeroIdentificacionFiscal		NVARCHAR (20) 
	DireccionFiscal					NVARCHAR (200) 
	Telefono						NVARCHAR (15) 
	Correo							NVARCHAR (100) 
	NombreCompletoContacto			NVARCHAR (150) 
	NumeroDeCuenta					NVARCHAR (20) 
	EstadoConstanteId				INT
	
	-- Auditoria
	CreatedAt		DATETIME2(0) 
	CreatedBy		INT          
	UpdatedAt		DATETIME2(0) 
	UpdatedBy		INT          
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
ExisteTelefono
ExisteTelefono
ObtenerPorCuentaBancaria
TieneMovimientosPendientes
*/