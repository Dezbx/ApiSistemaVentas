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
 
CREATE OR ALTER PROCEDURE seguridad.Rol_spAgregarVarios 
()
AS 
    BEGIN
        SET NOCOUNT ON;
    END
GO
 
CREATE OR ALTER PROCEDURE seguridad.Rol_spActualizarVarios 
()
AS 
    BEGIN
        SET NOCOUNT ON;
    END
GO
 
CREATE OR ALTER PROCEDURE seguridad.Rol_spDesactivarVarios 
()
AS 
    BEGIN
        SET NOCOUNT ON;
    END
GO
 
CREATE OR ALTER PROCEDURE seguridad.Rol_spActivarVarios
()
AS 
    BEGIN
        SET NOCOUNT ON;
    END
GO
 
CREATE OR ALTER PROCEDURE seguridad.Rol_spObtenerEliminados 
()
AS 
    BEGIN
        SET NOCOUNT ON;
    END
GO
 
CREATE OR ALTER PROCEDURE seguridad.Rol_spEliminarLogico 
()
AS 
    BEGIN
        SET NOCOUNT ON;
    END
GO
 
CREATE OR ALTER PROCEDURE seguridad.Rol_spExisteDescripcion 
()
AS 
    BEGIN
        SET NOCOUNT ON;
    END
GO
 
CREATE OR ALTER PROCEDURE seguridad.Rol_spObtenerPorDescripcion 
()
AS 
    BEGIN
        SET NOCOUNT ON;
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
Existe 
ContarTotal 
AgregarVarios 
ActualizarVarios 
DesactivarVarios 
ActivarVarios
ObtenerEliminados 
EliminarLogico 
PROPIOS:
ExisteDescripcion 
ObtenerPorDescripcion 
*/