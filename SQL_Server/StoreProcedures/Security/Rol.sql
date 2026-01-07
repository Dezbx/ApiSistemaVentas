USE SistemaVentasBD
GO

CREATE OR ALTER PROCEDURE seguridad.Rol_spObtenerPorId
(
    @RolId INT 
)
AS 
    BEGIN
        SET NOCOUNT ON;
        SELECT
        R.RolId,
        R.Descripcion
        FROM seguridad.Rol AS R
        WHERE R.RolId = @RolId
    END
GO

CREATE OR ALTER PROCEDURE seguridad.Rol_spObtenerTodos
AS 
    BEGIN
        SET NOCOUNT ON;
        SELECT
        R.RolId,
        R.Descripcion
        FROM seguridad.Rol AS R
    END
GO
 
CREATE OR ALTER PROCEDURE seguridad.Rol_spAgregar
(
    @Descripcion   NVARCHAR(20),
    @CreatedBy     INT -- ID del usuario que está creando el rol
)
AS
BEGIN
    SET NOCOUNT ON;
    SET XACT_ABORT ON; -- Revierte todo si hay un error (ej: violación de UQ_Rol_Descripcion)

    INSERT INTO seguridad.Rol 
    (
        Descripcion, 
        CreatedBy, 
        CreatedAt, 
        IsDeleted
    )
    VALUES 
    (
        UPPER(TRIM(@Descripcion)), -- Limpieza básica de datos
        @CreatedBy, 
        SYSUTCDATETIME(),           -- Usamos UTC como indica tu DEFAULT
        0                           -- IsDeleted = False
    );

    -- Retornamos el ID generado para el Task<int> del repositorio
    SELECT CAST(SCOPE_IDENTITY() AS INT);
END
GO
 
CREATE OR ALTER PROCEDURE seguridad.Rol_spActualizar
(
    @RolId         INT,
    @Descripcion   NVARCHAR(20),
    @UpdatedBy     INT -- ID del usuario que está modificando el rol
)
AS
    BEGIN
        SET NOCOUNT ON;
        SET XACT_ABORT ON;

        UPDATE seguridad.Rol
        SET Descripcion = UPPER(TRIM(@Descripcion)),
            UpdatedBy   = @UpdatedBy,
            UpdatedAt   = SYSUTCDATETIME() -- Usamos UTC para consistencia
        WHERE RolId = @RolId 
          AND IsDeleted = 0; -- Solo actualiza si no está borrado lógicamente

        -- Retornamos si se afectó alguna fila (éxito de la operación)
        SELECT CAST(@@ROWCOUNT AS BIT);
    END
GO
 
CREATE OR ALTER PROCEDURE seguridad.Rol_spExistePorId
(
    @RolId INT
)
AS 
    BEGIN
        SET NOCOUNT ON;
        IF EXISTS 
        (
            SELECT 1
            FROM seguridad.Rol 
            WHERE RolId = @RolId
        )
            SELECT CAST (1 AS BIT)
        ELSE
            SELECT CAST (0 AS bit)
    END
GO
 
CREATE OR ALTER PROCEDURE seguridad.Rol_spContarTotal 
(
    @RolId INT
)
AS 
    BEGIN
        SET NOCOUNT ON;
        SELECT
        COUNT (RolId) AS TotalRoles
        FROM seguridad.Rol 
        WHERE IsDeleted = 0
    END
GO
 
-- Necesario para la creación de varios registros
-- Creamos un tipo de tabla para el esquema seguridad
IF NOT EXISTS (SELECT * FROM sys.types WHERE name = 'RolCreateType' AND schema_id = SCHEMA_ID('seguridad'))
BEGIN
    CREATE TYPE seguridad.RolCreateType AS TABLE 
    (
        --Sin id pq es identity
        Descripcion NVARCHAR(20),
        CreatedAt		DATETIME2(0),
	    CreatedBy		INT ,         
	    IsDeleted		BIT
    );
END
GO

IF NOT EXISTS (SELECT * FROM sys.types WHERE name = 'RolUpdateType' AND schema_id = SCHEMA_ID('seguridad'))
BEGIN
    CREATE TYPE seguridad.RolUpdateType AS TABLE 
    (
        RolId       INT, -- con id para actualizar
        Descripcion NVARCHAR(20),
        UpdatedAt		DATETIME2(0),
	    UpdatedBy		INT
    );
END
GO


CREATE OR ALTER PROCEDURE seguridad.Rol_spAgregarVarios 
(
    @Roles seguridad.RolCreateType READONLY -- La lista de Roles que vienen de C#
)
AS 
    BEGIN
        SET NOCOUNT ON;
        INSERT INTO seguridad.Rol 
        (
            Descripcion, 
            CreatedBy, 
            CreatedAt, 
            IsDeleted
        )
        SELECT 
            UPPER(TRIM(R.Descripcion)), -- Limpieza básica de datos
            R.CreatedBy, 
            SYSUTCDATETIME(),           -- Usamos UTC como indica tu DEFAULT
            0                           -- IsDeleted = False
        FROM @Roles AS R;
    END
GO
 
CREATE OR ALTER PROCEDURE seguridad.Rol_spActualizarVarios 
(
    @Roles seguridad.RolUpdateType READONLY -- La lista de Roles que vienen de C#
)
AS 
    BEGIN
        SET NOCOUNT ON;
        UPDATE R
        SET R.Descripcion = UPPER(TRIM(Lista.Descripcion)),
            R.UpdatedAt   = SYSUTCDATETIME() -- Usamos UTC para consistencia
        FROM seguridad.Rol AS R
        INNER JOIN @Roles AS Lista 
            ON R.RolId = Lista.RolId
        WHERE R.IsDeleted = 0; -- solo actualizar los que no están eliminados
    END
GO
 
CREATE OR ALTER PROCEDURE seguridad.Rol_spDesactivarVarios
(
    @Ids compartido.IdListTableType READONLY, -- La lista de IDs que vienen de C#
    @UpdatedBy INT                            -- Quién hace la acción
)
AS
BEGIN
    SET NOCOUNT ON;

    UPDATE seguridad.Rol
    SET IsDeleted = 1,              -- Marcamos como "Borrado" (Inactivo)
        UpdatedBy = @UpdatedBy,
        UpdatedAt = SYSUTCDATETIME()
    WHERE RolId IN (SELECT Id FROM @Ids) -- Solo los que enviamos en la lista
      AND IsDeleted = 0;                 -- Solo los que NO estaban borrados ya

    -- Retornamos la cantidad de registros que cambiaron
    SELECT @@ROWCOUNT;
END
GO
 
CREATE OR ALTER PROCEDURE seguridad.Rol_spActivarVarios
(
    @Ids compartido.IdListTableType READONLY, -- La lista de IDs que vienen de C#
    @UpdatedBy INT                            -- Quién hace la acción
)
AS 
    BEGIN
        SET NOCOUNT ON;
        UPDATE seguridad.Rol
        SET IsDeleted = 0,              -- Marcamos como "No Borrado" (Activo)
            UpdatedBy = @UpdatedBy,
            UpdatedAt = SYSUTCDATETIME()
        WHERE RolId IN (SELECT Id FROM @Ids) -- Solo los que enviamos en la lista
          AND IsDeleted = 1;                 -- Solo los que estaban borrados
    END
GO
 
CREATE OR ALTER PROCEDURE seguridad.Rol_spObtenerEliminados 
AS 
    BEGIN
        SET NOCOUNT ON;
        SELECT
        R.RolId,
        R.Descripcion
        FROM seguridad.Rol AS R
        WHERE R.IsDeleted = 1;
    END
GO
 
CREATE OR ALTER PROCEDURE seguridad.Rol_spEliminarLogico 
(
    @RolId INT,
    @UpdatedBy INT -- Quién hace la acción
)
AS 
    BEGIN
        SET NOCOUNT ON;
        UPDATE seguridad.Rol
        SET IsDeleted = 1,              -- Marcamos como "Borrado" (Inactivo)
            UpdatedBy = @UpdatedBy,
            UpdatedAt = SYSUTCDATETIME()
        WHERE RolId = @RolId;
    END
GO
 
CREATE OR ALTER PROCEDURE seguridad.Rol_spExisteDescripcion 
(
    @Descripcion NVARCHAR(20)
)
AS 
    BEGIN
        SET NOCOUNT ON;
        IF EXISTS 
        (
            SELECT 1
            FROM seguridad.Rol 
            WHERE UPPER(TRIM(Descripcion)) = UPPER(TRIM(@Descripcion))
        )
            SELECT CAST (1 AS BIT)
        ELSE
            SELECT CAST (0 AS bit)
    END
GO
 
CREATE OR ALTER PROCEDURE seguridad.Rol_spObtenerPorDescripcion 
(
    @Descripcion NVARCHAR(20)
)
AS 
    BEGIN
        SET NOCOUNT ON;
        SELECT
        R.RolId,
        R.Descripcion
        FROM seguridad.Rol AS R
        WHERE UPPER(TRIM(R.Descripcion)) = UPPER(TRIM(@Descripcion))
          AND R.IsDeleted = 0;
    END
GO
/*
    RolId			INT
	Descripcion		NVARCHAR(20) 

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
ExisteDescripcion 
ObtenerPorDescripcion 
*/