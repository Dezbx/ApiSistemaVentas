USE SistemaVentasBD
GO

CREATE OR ALTER PROCEDURE seguridad.Usuario_spObtenerPorId
(
    @UsuarioId INT 
)
AS
    BEGIN
        SET NOCOUNT ON;
        SELECT
        U.UsuarioId,
        U.UsuarioRolId,
        U.NombreUsuario,
        U.Correo,
        U.FechaRegistro
        FROM seguridad.Usuario AS U
        WHERE U.UsuarioId = @UsuarioId
          AND U.IsDeleted = 0;
    END
GO
        
CREATE OR ALTER PROCEDURE seguridad.Usuario_spObtenerTodos
AS
    BEGIN
        SET NOCOUNT ON;
        SELECT
        U.UsuarioId,
        U.UsuarioRolId,
        U.NombreUsuario,
        U.Correo,  
        U.FechaRegistro
        FROM seguridad.Usuario AS U
    END
GO 
 
CREATE OR ALTER PROCEDURE seguridad.Usuario_spAgregar 
(
    @UsuarioRolId INT,
    @NombreUsuario NVARCHAR(50),
    @Correo NVARCHAR(100),
    @PasswordHash VARBINARY(255),
    @PasswordSalt VARBINARY(255),
    @CreatedBy INT,
    @CreatedAt DATETIME2(0) ,
    @IsDeleted BIT
)
AS
    BEGIN
        SET NOCOUNT ON;
        INSERT INTO seguridad.Usuario
        (
            UsuarioRolId,
            NombreUsuario,
            Correo,
            PasswordHash,
            PasswordSalt,
            CreatedBy,
            CreatedAt,
            IsDeleted
        )
        VALUES
        (
            @UsuarioRolId,
            @NombreUsuario,
            @Correo,
            @PasswordHash,
            @PasswordSalt,
            @CreatedBy,
            @CreatedAt,
            @IsDeleted
        );
        SELECT SCOPE_IDENTITY() AS NewUsuarioId;
    END
GO 
 
CREATE OR ALTER PROCEDURE seguridad.Usuario_spActualizar 
(
    @UsuarioId INT,
    @UsuarioRolId INT,
    @NombreUsuario NVARCHAR(50),
    @Correo NVARCHAR(100),
    @UpdatedBy INT,
    @UpdatedAt DATETIME2(0)
)
AS
    BEGIN
        SET NOCOUNT ON;
        UPDATE seguridad.Usuario
        SET UsuarioRolId = @UsuarioRolId,
            NombreUsuario = @NombreUsuario,
            Correo = @Correo,   
            UpdatedBy = @UpdatedBy,
            UpdatedAt = @UpdatedAt
        WHERE UsuarioId = @UsuarioId;
        SELECT CAST(@@ROWCOUNT AS BIT);
    END
GO 
 
CREATE OR ALTER PROCEDURE seguridad.Usuario_spExistePorId
(
    @UsuarioId INT
)
AS
    BEGIN
        SET NOCOUNT ON;
        IF EXISTS 
        (
            SELECT 1
            FROM seguridad.Usuario 
            WHERE UsuarioId = @UsuarioId
        )
            SELECT CAST (1 AS BIT)
        ELSE
            SELECT CAST (0 AS bit)
    END
GO 
 
CREATE OR ALTER PROCEDURE seguridad.Usuario_spContarTotal 
AS
    BEGIN
        SET NOCOUNT ON;
        SELECT COUNT(*) AS TotalUsuarios
        FROM seguridad.Usuario
        WHERE IsDeleted = 0;
    END
GO 

IF NOT EXISTS (SELECT * FROM sys.types WHERE name = 'UsuarioCreateType' AND schema_id = SCHEMA_ID('seguridad'))
BEGIN
    CREATE TYPE seguridad.UsuarioCreateType AS TABLE 
    (
        UsuarioRolId	INT,
        NombreUsuario	NVARCHAR (50),
        Correo			NVARCHAR(100),
        PasswordHash	VARBINARY (255),
        PasswordSalt	VARBINARY (255),
        FechaRegistro	DATETIME2(0), 
        -- Auditoria
        CreatedAt		DATETIME2(0),
        CreatedBy		INT,          
        IsDeleted		BIT          
    );
    END
GO

IF NOT EXISTS (SELECT * FROM sys.types WHERE name = 'UsuarioUpdateType' AND schema_id = SCHEMA_ID('seguridad'))
BEGIN
    CREATE TYPE seguridad.UsuarioUpdateType AS TABLE 
    (
        UsuarioId       INT,
        UsuarioRolId	INT,
        NombreUsuario	NVARCHAR (50), 
        Correo			NVARCHAR(100), 
        FechaRegistro	DATETIME2(0),
        -- Auditoria
        UpdatedAt		DATETIME2(0), 
        UpdatedBy		INT        
    );
    END
GO

CREATE OR ALTER PROCEDURE seguridad.Usuario_spAgregarVarios 
(
    @Usuarios seguridad.UsuarioCreateType READONLY
)
AS
    BEGIN
        SET NOCOUNT ON;
        INSERT INTO seguridad.Usuario
        (
            UsuarioRolId,
            NombreUsuario,
            Correo,
            PasswordHash,
            PasswordSalt,
            FechaRegistro,
            CreatedAt,
            CreatedBy,
            IsDeleted
        )
        SELECT
            U.UsuarioRolId,
            U.NombreUsuario,
            U.Correo,
            U.PasswordHash,
            U.PasswordSalt,
            U.FechaRegistro,
            U.CreatedAt,    
            U.CreatedBy,
            U.IsDeleted
        FROM @Usuarios AS U;
        SELECT @@ROWCOUNT;
    END
GO 

CREATE OR ALTER PROCEDURE seguridad.Usuario_spActualizarVarios 
(
    @Usuarios seguridad.UsuarioUpdateType READONLY
)
AS
    BEGIN
        SET NOCOUNT ON;
        UPDATE U
        SET U.UsuarioRolId = Lista.UsuarioRolId,
            U.NombreUsuario = Lista.NombreUsuario,
            U.Correo = Lista.Correo,   
            U.UpdatedAt = Lista.UpdatedAt,
            U.UpdatedBy = Lista.UpdatedBy  
        FROM seguridad.Usuario AS U
        INNER JOIN @Usuarios AS Lista
            ON U.UsuarioId = Lista.UsuarioId
        WHERE U.IsDeleted = 0;

        SELECT @@ROWCOUNT;
    END
GO 
 
CREATE OR ALTER PROCEDURE seguridad.Usuario_spDesactivarVarios 
(
    @UsuarioIds compartido.IdListType READONLY
)
AS
    BEGIN
        SET NOCOUNT ON;
        UPDATE U
        SET U.IsDeleted = 1
        FROM seguridad.Usuario AS U
        INNER JOIN @UsuarioIds AS ListaUsuarios
            ON U.UsuarioId = ListaUsuarios.Id
        WHERE U.IsDeleted = 0;
        SELECT @@ROWCOUNT;
    END
GO 
 
CREATE OR ALTER PROCEDURE seguridad.Usuario_spActivarVarios
(
    @UsuarioIds compartido.IdListType READONLY
)
AS
    BEGIN
        SET NOCOUNT ON;
        UPDATE U
        SET U.IsDeleted = 0
        FROM seguridad.Usuario AS U
        INNER JOIN @UsuarioIds AS ListaUsuarios
            ON U.UsuarioId = ListaUsuarios.Id
        WHERE U.IsDeleted = 1;
        SELECT @@ROWCOUNT;
    END
GO 

CREATE OR ALTER PROCEDURE seguridad.Usuario_spObtenerEliminados
AS
    BEGIN
        SET NOCOUNT ON;
        SELECT
            U.UsuarioId,
            U.UsuarioRolId,
            U.NombreUsuario,
            U.Correo,
            U.FechaRegistro,
            U.CreatedAt,
            U.CreatedBy,
            U.UpdatedAt,
            U.UpdatedBy
        FROM seguridad.Usuario AS U
        WHERE U.IsDeleted = 1;
    END
GO

CREATE OR ALTER PROCEDURE seguridad.Usuario_spEliminarLogico
(
    @UsuarioId INT,
    @UpdatedBy INT -- Quién hace la acción
)
AS
    BEGIN
        SET NOCOUNT ON;
        UPDATE seguridad.Usuario
        SET IsDeleted = 1,              -- Marcamos como "Borrado" (Inactivo)
            UpdatedBy = @UpdatedBy,
            UpdatedAt = SYSUTCDATETIME()
        WHERE UsuarioId = @UsuarioId
            AND IsDeleted = 0;
    END
GO

 
CREATE OR ALTER PROCEDURE seguridad.Usuario_spExisteNombreUsuario
(
    @NombreUsuario NVARCHAR(50)
)
AS
    BEGIN
        SET NOCOUNT ON;
        IF EXISTS 
        (
            SELECT 1
            FROM seguridad.Usuario 
            WHERE NombreUsuario = @NombreUsuario
        )
            SELECT CAST (1 AS BIT)
        ELSE
            SELECT CAST (0 AS bit)

    END
GO 
 
CREATE OR ALTER PROCEDURE seguridad.Usuario_spExisteCorreo
(
    @Correo NVARCHAR(100)
)
AS
    BEGIN
        SET NOCOUNT ON;
        IF EXISTS 
        (
            SELECT 1
            FROM seguridad.Usuario 
            WHERE Correo = @Correo
        )
            SELECT CAST (1 AS BIT)
        ELSE
            SELECT CAST (0 AS BIT)
    END
GO 

CREATE OR ALTER PROCEDURE seguridad.Usuario_spObtenerPorNombreUsuario
(
    @NombreUsuario NVARCHAR(50)
)
AS
    BEGIN
        SET NOCOUNT ON;
        SELECT
        U.UsuarioId,
        U.UsuarioRolId,
        U.NombreUsuario,
        U.Correo,
        U.FechaRegistro
        FROM seguridad.Usuario AS U
        WHERE U.NombreUsuario = @NombreUsuario
            AND U.IsDeleted = 0;
    END
GO 
 
CREATE OR ALTER PROCEDURE seguridad.Usuario_spContarUsuariosPorRolId
(
    @UsuarioRolId INT
)
AS
    BEGIN
        SET NOCOUNT ON;
        SELECT COUNT(*) AS TotalUsuarios
        FROM seguridad.Usuario AS U
        WHERE U.UsuarioRolId = @UsuarioRolId
            AND U.IsDeleted = 0;
    END
GO 
 

 
/*
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
ExisteNombreUsuarioAsync
ExisteCorreoAsync
ObtenerPorNombreUsuarioAsync
ContarUsuariosPorRolIdAsync
*/