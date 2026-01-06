USE SistemaVentasBD
GO

IF NOT EXISTS (SELECT * FROM sys.schemas WHERE NAME = 'ventas')
BEGIN
	EXECUTE ('CREATE SCHEMA ventas')
END

IF NOT EXISTS (SELECT * FROM sys.schemas WHERE NAME = 'seguridad')
BEGIN
	EXECUTE ('CREATE SCHEMA seguridad')
END

IF NOT EXISTS (SELECT * FROM sys.schemas WHERE NAME = 'core')
BEGIN
	EXECUTE ('CREATE SCHEMA core')
END

IF NOT EXISTS (SELECT * FROM sys.schemas WHERE NAME = 'inventario')
BEGIN
	EXECUTE ('CREATE SCHEMA inventario')
END

IF NOT EXISTS (SELECT * FROM sys.schemas WHERE NAME = 'compartido')
BEGIN
	EXECUTE ('CREATE SCHEMA compartido')
END

IF NOT EXISTS (SELECT * FROM sys.schemas WHERE NAME = 'auditoria')
BEGIN
	EXECUTE ('CREATE SCHEMA auditoria')
END
GO


CREATE TABLE compartido.GrupoConstante
(
    GrupoConstanteId	INT IDENTITY (1,1) PRIMARY KEY,
    Descripcion			VARCHAR(100) NOT NULL,
	IsDeleted			BIT          NOT NULL DEFAULT 0 -- Soft delete

	CONSTRAINT UQ_GrupoConstante UNIQUE (Descripcion) 
)

CREATE TABLE compartido.Constante 
(
    ConstanteId			INT IDENTITY (1,1) PRIMARY KEY,
    GrupoConstanteId	INT FOREIGN KEY REFERENCES compartido.GrupoConstante(GrupoConstanteId),
    Valor				INT NOT NULL,
    Descripcion			VARCHAR(100) NOT NULL,
    Orden				INT NOT NULL,
	IsDeleted			BIT NOT NULL DEFAULT 0 -- Soft delete


	CONSTRAINT UQ_Constante UNIQUE (GrupoConstanteId, Valor),
);

CREATE TABLE auditoria.AuditLog 
(
    AuditLogId	BIGINT IDENTITY (1,1) PRIMARY KEY,
    TableName   SYSNAME      NOT NULL,
    RecordId    VARCHAR(50)  NOT NULL,
    Action      VARCHAR(10)  NOT NULL CONSTRAINT CK_AuditLog_Action CHECK (Action IN ('INSERT','UPDATE','DELETE')),
    OldValues   NVARCHAR(MAX) NULL,
    NewValues   NVARCHAR(MAX) NULL,
    ChangedAt   DATETIME2(0) NOT NULL DEFAULT SYSUTCDATETIME(),
    ChangedBy   INT          NOT NULL,
    IpAddress   VARCHAR(45)  NULL
)

CREATE TABLE seguridad.Rol 
(
	RolId			INT IDENTITY (1,1) PRIMARY KEY,
	Descripcion		NVARCHAR(20) NOT NULL,

	-- Auditoria
	CreatedAt		DATETIME2(0) NOT NULL DEFAULT SYSUTCDATETIME(), -- Fecha de creaci n
	CreatedBy		INT          NOT NULL, -- Usuario que cre 
	UpdatedAt		DATETIME2(0) NULL, --  ltima modificaci n
	UpdatedBy		INT          NULL, -- Usuario que modific 
	IsDeleted		BIT          NOT NULL DEFAULT 0 -- Soft delete

	CONSTRAINT UQ_Rol_Descripcion UNIQUE (Descripcion)
)

CREATE TABLE seguridad.Usuario
(
	UsuarioId		INT IDENTITY (1,1) PRIMARY KEY,
	UsuarioRolId	INT FOREIGN KEY REFERENCES seguridad.Rol (RolId),
	NombreUsuario	NVARCHAR (50) NOT NULL,
	Correo			NVARCHAR(100) NOT NULL,
	PasswordHash	VARBINARY (255) NOT NULL,
	PasswordSalt	VARBINARY (255) NOT NULL,
	FechaRegistro	DATETIME2(0) NOT NULL CONSTRAINT DF_Usuario_FechaRegistro DEFAULT SYSUTCDATETIME(),


	-- Auditoria
	CreatedAt		DATETIME2(0) NOT NULL DEFAULT SYSUTCDATETIME(),
	CreatedBy		INT          NOT NULL, 
	UpdatedAt		DATETIME2(0) NULL, 
	UpdatedBy		INT          NULL, 
	IsDeleted		BIT          NOT NULL DEFAULT 0 

	CONSTRAINT UQ_Usuario_Nombre UNIQUE (NombreUsuario),
	CONSTRAINT UQ_Usuario_Correo UNIQUE (Correo)

	-- agregar al sp los default
	--CONSTRAINT DF_Usuario_FechaRegistro DEFAULT GETDATE (FechaRegistro)
)

CREATE TABLE compartido.TipoDocumento
(
	TipoDocumentoID		INT IDENTITY (1,1) PRIMARY KEY,
	Descripcion			NVARCHAR(30) NOT NULL, --DNI, PASAPORTE, RUC, RFC, ETC
	IsDeleted			BIT          NOT NULL DEFAULT 0 -- Soft delete

	CONSTRAINT UQ_TipoDocumento_Descripcion UNIQUE (Descripcion)
)

CREATE TABLE core.Sede
(
	SedeId			INT IDENTITY (1,1) PRIMARY KEY,
	Descripcion		NVARCHAR (100) NOT NULL,
	Direccion		NVARCHAR (200) NOT NULL,
	IsDeleted		BIT          NOT NULL DEFAULT 0 -- Soft delete

	CONSTRAINT UQ_Sede UNIQUE (Descripcion, Direccion)
)

CREATE TABLE core.Cargo
(
	CargoId			INT IDENTITY (1,1) PRIMARY KEY,
	Descripcion		NVARCHAR(50) NOT NULL,
	IsDeleted		BIT          NOT NULL DEFAULT 0 -- Soft delete

	CONSTRAINT UQ_Cargo_Descripcion UNIQUE (Descripcion)
)

CREATE TABLE core.Empleado
(
	EmpleadoId					INT IDENTITY (1,1) PRIMARY KEY,
	EmpleadoUsuarioId			INT FOREIGN KEY REFERENCES seguridad.Usuario (UsuarioId),
	EmpleadoSedeId				INT FOREIGN KEY REFERENCES core.Sede (SedeId),
	EmpleadoTipoDocumentoId		INT FOREIGN KEY REFERENCES compartido.TipoDocumento (TipoDocumentoId),
	EmpleadoCargoId				INT FOREIGN KEY REFERENCES core.Cargo (CargoId),
	Paterno						NVARCHAR (50) NOT NULL,
	Materno						NVARCHAR (50) NOT NULL,
	Nombres						NVARCHAR (50) NOT NULL,
	NumeroDocumento				NVARCHAR (20) NOT NULL,
	Correo						NVARCHAR (100) NOT NULL, 
	Telefono					NVARCHAR (15) NOT NULL,
	Sexo						NCHAR (1) NOT NULL,
	FechaNacimiento				DATE NOT NULL,
	Direccion					NVARCHAR (200) NOT NULL,

	EstadoConstanteId			INT NOT NULL,

	-- Auditoria
	CreatedAt		DATETIME2(0) NOT NULL DEFAULT SYSUTCDATETIME(),
	CreatedBy		INT          NOT NULL, 
	UpdatedAt		DATETIME2(0) NULL, 
	UpdatedBy		INT          NULL, 
	IsDeleted		BIT          NOT NULL DEFAULT 0

	CONSTRAINT UQ_Empleado_NumeroDocumento UNIQUE (NumeroDocumento),
	CONSTRAINT UQ_Empleado_Correo UNIQUE (Correo),
	CONSTRAINT UQ_Empleado_Telefono UNIQUE (Telefono),
	CONSTRAINT CK_Empleado_Sexo CHECK (Sexo IN ('M', 'F')),
	CONSTRAINT FK_Empleado_EstadoConstanteId FOREIGN KEY (EstadoConstanteId) REFERENCES compartido.Constante (ConstanteId)
	--Agregar constraint default del EstadoConstanteId	en el sp
)

CREATE TABLE core.Cliente 
(
	ClienteId					INT IDENTITY (1,1) PRIMARY KEY,
	ClienteUsuarioId			INT FOREIGN KEY REFERENCES seguridad.Usuario (UsuarioId),
	ClienteTipoDocumentoId		INT FOREIGN KEY REFERENCES compartido.TipoDocumento (TipoDocumentoId),
	Paterno						NVARCHAR (50) NOT NULL,
	Materno						NVARCHAR (50) NOT NULL,
	Nombres						NVARCHAR (50) NOT NULL,
	NumeroDocumento				NVARCHAR (20) NOT NULL,
	Correo						NVARCHAR (100) NOT NULL, 
	Telefono					NVARCHAR (15) NOT NULL,
	Sexo						NCHAR (1) NOT NULL,
	FechaNacimiento				DATE NOT NULL,
	Direccion					NVARCHAR (200) NOT NULL,

	EstadoConstanteId			INT NOT NULL,

	-- Auditoria
	CreatedAt		DATETIME2(0) NOT NULL DEFAULT SYSUTCDATETIME(),
	CreatedBy		INT          NOT NULL, 
	UpdatedAt		DATETIME2(0) NULL, 
	UpdatedBy		INT          NULL, 
	IsDeleted		BIT          NOT NULL DEFAULT 0

	CONSTRAINT UQ_Cliente UNIQUE (NumeroDocumento, Correo, Telefono),
	CONSTRAINT CK_Cliente_Sexo CHECK (Sexo IN ('M', 'F')),
	CONSTRAINT FK_Cliente_EstadoConstanteId FOREIGN KEY (EstadoConstanteId) REFERENCES compartido.Constante (ConstanteId)
	--Agregar constraint default del EstadoConstanteId en el sp
)

CREATE TABLE compartido.TipoMovimiento
(
	TipoMovimientoId	INT IDENTITY (1,1) PRIMARY KEY,
	Descripcion			NVARCHAR(50) NOT NULL, --Ingresos o salidas
	IsDeleted			BIT          NOT NULL DEFAULT 0 -- Soft delete

	CONSTRAINT UQ_TipoMovimiento_Descripcion UNIQUE (Descripcion)
)

CREATE TABLE compartido.Periodo
(
	PeriodoId		INT IDENTITY (1,1) PRIMARY KEY,
	Descripcion		NVARCHAR(6) NOT NULL, --202601, 202602, ETC
	FechaInicio		DATE NOT NULL,
	FechaFin		DATE NOT NULL,
	IsDeleted		BIT          NOT NULL DEFAULT 0 -- Soft delete

	CONSTRAINT UQ_Periodo_Descripcion UNIQUE (Descripcion)
)

CREATE TABLE core.Proveedor
(
	ProveedorId						INT IDENTITY (1,1) PRIMARY KEY,
	ProveedorTipoDocumentoId		INT FOREIGN KEY REFERENCES compartido.TipoDocumento (TipoDocumentoId),
	Nombre							NVARCHAR (100) NOT NULL,
	NumeroIdentificacionFiscal		NVARCHAR (20) NOT NULL,
	DireccionFiscal					NVARCHAR (200) NOT NULL,
	Telefono						NVARCHAR (15) NOT NULL,
	Correo							NVARCHAR (100) NULL,
	NombreCompletoContacto			NVARCHAR (150) NOT NULL,
	NumeroDeCuenta					NVARCHAR (20) NULL,
	EstadoConstanteId				INT NOT NULL,

	-- Auditoria
	CreatedAt		DATETIME2(0) NOT NULL DEFAULT SYSUTCDATETIME(),
	CreatedBy		INT          NOT NULL, 
	UpdatedAt		DATETIME2(0) NULL, 
	UpdatedBy		INT          NULL, 
	IsDeleted		BIT          NOT NULL DEFAULT 0

	-- Mostrar alerta cuando haya mas de dos uq repetidas.
	CONSTRAINT UQ_Proveedor UNIQUE (NumeroIdentificacionFiscal, Telefono, Correo, NumeroDeCuenta)
	CONSTRAINT FK_Proveedor_EstadoConstanteId FOREIGN KEY (EstadoConstanteId) REFERENCES compartido.Constante (ConstanteId)
)

CREATE TABLE core.Categoria
(
	CategoriaId		INT IDENTITY (1,1) PRIMARY KEY,
	Nombre			NVARCHAR (50) NOT NULL,
	IsDeleted		BIT NOT NULL DEFAULT 0

	CONSTRAINT UQ_Categoria_Nombre UNIQUE (Nombre)
)

CREATE TABLE core.DetalleProveedor
(
	ProveedorId INT FOREIGN KEY REFERENCES core.Proveedor (ProveedorId),
	CategoriaId INT FOREIGN KEY REFERENCES core.Categoria (CategoriaId)

	CONSTRAINT PK_DetalleProveedor PRIMARY KEY (ProveedorId, CategoriaId)
)

CREATE TABLE core.Producto
(
	ProductoId				INT IDENTITY (1,1) PRIMARY KEY,
	ProductoCategoriaId		INT FOREIGN KEY REFERENCES core.Categoria (CategoriaId),
	Nombre					NVARCHAR(100) NOT NULL,
	Descripcion				NVARCHAR(200) NULL,
	CodigoSKU				NVARCHAR(50) NOT NULL, 
	/*
	Debe ser autogenerado?: [CATEGORIA]-[MARCA]-[ATRIBUTO]
		| Producto | SKU        | Descripci n           |
		| -------- | ---------- | --------------------- |
		| Camiseta | CAM-ROJ-M  | Camiseta roja talla M |
		| Camiseta | CAM-AZU-L  | Camiseta azul talla L |
		| Laptop   | LAP-DEL-15 | Laptop Dell 15"       |
	*/
	PrecioCompra			DECIMAL(9,2) NOT NULL CHECK (PrecioCompra >= 0),
	PrecioVenta				DECIMAL(9,2) NOT NULL CHECK (PrecioVenta >= 0),
	Stock					INT NOT NULL CHECK (Stock >= 0),
	StockMinimo				INT NOT NULL CHECK (StockMinimo >= 0),
	FechaCreacion			DATETIME2(0) NOT NULL DEFAULT SYSUTCDATETIME(),

	-- Auditoria
	CreatedAt		DATETIME2(0) NOT NULL DEFAULT SYSUTCDATETIME(),
	CreatedBy		INT          NOT NULL, 
	UpdatedAt		DATETIME2(0) NULL, 
	UpdatedBy		INT          NULL, 
	IsDeleted		BIT          NOT NULL DEFAULT 0

	CONSTRAINT UQ_Producto_CodigoSKU UNIQUE (CodigoSKU)
)

CREATE TABLE inventario.MovimientoInventario
(
	MovimientoInventarioId					INT IDENTITY (1,1) PRIMARY KEY,
	MovimientoInventarioTipoMovimientoId	INT NOT NULL FOREIGN KEY REFERENCES compartido.TipoMovimiento (TipoMovimientoId),	
	MovimientoInventarioPeriodoId			INT FOREIGN KEY REFERENCES compartido.Periodo (PeriodoId),
	Fecha									DATETIME2(0) NOT NULL DEFAULT SYSUTCDATETIME(),
	Motivo									NVARCHAR (200) NOT NULL,

	-- Auditoria
	CreatedAt		DATETIME2(0) NOT NULL DEFAULT SYSUTCDATETIME(),
	CreatedBy		INT          NOT NULL, 
	UpdatedAt		DATETIME2(0) NULL, 
	UpdatedBy		INT          NULL, 
	IsDeleted		BIT          NOT NULL DEFAULT 0
)

CREATE TABLE inventario.DetalleMovimiento
(
	MovimientoInventarioId	INT FOREIGN KEY REFERENCES inventario.MovimientoInventario (MovimientoInventarioId),
	ProductoId				INT FOREIGN KEY REFERENCES core.Producto (ProductoId),
	Cantidad				INT NOT NULL CHECK (Cantidad > 0)

	CONSTRAINT PK_DetalleMovimiento PRIMARY KEY ( MovimientoInventarioId, ProductoId) 
)

CREATE TABLE compartido.TipoPago
(
	TipoPagoId		INT IDENTITY (1,1) PRIMARY KEY,
	Descripcion		NVARCHAR(100) NOT NULL,
	IsDeleted		BIT          NOT NULL DEFAULT 0

	CONSTRAINT UQ_TipoPago_Descripcion UNIQUE (Descripcion)
)

CREATE TABLE core.Venta
(
	VentaId				INT IDENTITY (1,1) PRIMARY KEY,
	VentaClienteId		INT FOREIGN KEY REFERENCES core.Cliente (ClienteId),	
	VentaTipoPagoId		INT FOREIGN KEY REFERENCES compartido.TipoPago (TipoPagoId),
	Total				NUMERIC (9,2) NOT NULL CHECK (Total >= 0),
	Fecha				DATETIME2(0) NOT NULL DEFAULT SYSUTCDATETIME(),
	EstadoConstanteId				INT NOT NULL,

	-- Auditoria
	CreatedAt		DATETIME2(0) NOT NULL DEFAULT SYSUTCDATETIME(),
	CreatedBy		INT          NOT NULL, 
	UpdatedAt		DATETIME2(0) NULL, 
	UpdatedBy		INT          NULL, 
	IsDeleted		BIT          NOT NULL DEFAULT 0

	CONSTRAINT FK_Venta_EstadoConstanteId FOREIGN KEY (EstadoConstanteId) REFERENCES compartido.Constante (ConstanteId)
)

CREATE TABLE core.DetalleVenta
(
	DetalleVentaId		INT IDENTITY (1,1) PRIMARY KEY,
	VentaId				INT FOREIGN KEY REFERENCES core.Venta (VentaId),
	ProductoId			INT FOREIGN KEY REFERENCES core.Producto (ProductoId),
	Cantidad			INT NOT NULL CHECK (Cantidad > 0),
	PrecioUnitario		DECIMAL(9,2) NOT NULL CHECK (PrecioUnitario >= 0),
	SubTotal			AS (Cantidad * PrecioUnitario) PERSISTED

)

CREATE INDEX IX_Usuario_RolId ON seguridad.Usuario (UsuarioRolId);
CREATE INDEX IX_Empleado_EstadoConstanteId ON core.Empleado (EstadoConstanteId);
CREATE INDEX IX_Cliente_EstadoConstanteId ON core.Cliente (EstadoConstanteId);
CREATE INDEX IX_Venta_EstadoConstanteId ON core.Venta (EstadoConstanteId);
CREATE INDEX IX_Venta_ClienteId ON core.Venta (VentaClienteId);
CREATE INDEX IX_DetalleVenta_VentaId ON core.DetalleVenta (VentaId);
CREATE INDEX IX_DetalleVenta_ProductoId ON core.DetalleVenta (ProductoId);
CREATE INDEX IX_Constante_Grupo ON compartido.Constante (GrupoConstanteId);
CREATE INDEX IX_Empleado_UsuarioId ON core.Empleado (EmpleadoUsuarioId);
CREATE INDEX IX_Cliente_UsuarioId ON core.Cliente (ClienteUsuarioId);
CREATE INDEX IX_MovimientoInventario_Fecha ON inventario.MovimientoInventario (Fecha);