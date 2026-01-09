USE SistemaVentasBD
GO

CREATE OR ALTER PROCEDURE core.Sede_spObtenerPorId
(
    @SedeId INT
)
AS
    BEGIN
        SET NOCOUNT ON;
        SELECT
            SedeId,
            Descripcion,
            Direccion,
            IsDeleted
        FROM core.Sede
        WHERE SedeId = @SedeId
            AND IsDeleted = 0;
    END
GO

CREATE OR ALTER PROCEDURE core.Sede_spObtenerTodos 
AS
    BEGIN
        SET NOCOUNT ON;
        SELECT
            SedeId,
            Descripcion,
            Direccion,
            IsDeleted
        FROM core.Sede;
    END
GO

CREATE OR ALTER PROCEDURE core.Sede_spAgregar 
(   
    @Descripcion NVARCHAR(100),
    @Direccion NVARCHAR(200),
    @IsDeleted BIT = 0
)
AS
    BEGIN
        SET NOCOUNT ON;
        INSERT INTO core.Sede
        (
            Descripcion,
            Direccion,
            IsDeleted
        )
        VALUES
        (
            @Descripcion,
            @Direccion,
            @IsDeleted
        );

        SELECT CAST(SCOPE_IDENTITY() AS INT);
    END
GO

CREATE OR ALTER PROCEDURE core.Sede_spActualizar 
(
    @SedeId INT,
    @Descripcion NVARCHAR(100),
    @Direccion NVARCHAR(200)
)
AS
    BEGIN
        SET NOCOUNT ON;
        UPDATE core.Sede
        SET
            Descripcion = @Descripcion,
            Direccion = @Direccion
        WHERE SedeId = @SedeId 
            AND IsDeleted = 0;
    END
GO

CREATE OR ALTER PROCEDURE core.Sede_spExistePorId
(
    @SedeId INT
)
AS
    BEGIN
        SET NOCOUNT ON;
        IF EXISTS 
        (
            SELECT 1 
            FROM core.Sede 
            WHERE SedeId = @SedeId
        )
            SELECT CAST (1 AS BIT) AS Existe;
        ELSE
            SELECT CAST (0 AS BIT) AS Existe;
    END
GO
CREATE OR ALTER PROCEDURE core.Sede_spContarTotal 
AS
    BEGIN
        SET NOCOUNT ON;
        SELECT
            COUNT (SedeId) AS TotalSedes
        FROM core.Sede
        WHERE IsDeleted = 0;
    END
GO

IF NOT EXISTS (SELECT * FROM sys.types WHERE name = 'SedeCreateType' AND schema_id = SCHEMA_ID('core'))
BEGIN
    CREATE TYPE core.SedeCreateType AS TABLE
    (
        Descripcion     NVARCHAR (100),
        Direccion       NVARCHAR (200),
        IsDeleted       BIT
    );
END
GO

IF NOT EXISTS (SELECT * FROM sys.types WHERE name = 'SedeUpdateType' AND schema_id = SCHEMA_ID('core'))
BEGIN
    CREATE TYPE core.SedeUpdateType AS TABLE
    (
        SedeId          INT,
        Descripcion     NVARCHAR (100),
        Direccion       NVARCHAR (200)
    );
END
GO

CREATE OR ALTER PROCEDURE core.Sede_spAgregarVarios 
(
    @SedeTable core.SedeCreateType READONLY
)
AS
    BEGIN
        SET NOCOUNT ON;
        INSERT INTO core.Sede
        (
            Descripcion,
            Direccion,
            IsDeleted
        )
        SELECT
            Descripcion,
            Direccion,
            IsDeleted
        FROM @SedeTable;

        SELECT @@ROWCOUNT;
    END
GO

CREATE OR ALTER PROCEDURE core.Sede_spActualizarVarios 
(
    @SedeTable core.SedeUpdateType READONLY
)
AS
    BEGIN
        SET NOCOUNT ON;
        UPDATE S
        SET
            S.Descripcion = Lista.Descripcion,
            S.Direccion = Lista.Direccion
        FROM core.Sede AS S
        INNER JOIN @SedeTable AS Lista
            ON S.SedeId = Lista.SedeId
        WHERE S.IsDeleted = 0;
        SELECT @@ROWCOUNT;
    END
GO

CREATE OR ALTER PROCEDURE core.Sede_spDesactivarVarios 
(
    @SedeIds compartido.IdListType READONLY
)
AS
    BEGIN
        SET NOCOUNT ON;
        UPDATE S
        SET S.IsDeleted = 1
        FROM core.Sede AS S
        INNER JOIN @SedeIds AS Lista    
            ON S.SedeId = Lista.Id
            WHERE S.IsDeleted = 0;
        SELECT @@ROWCOUNT;
    END
GO
CREATE OR ALTER PROCEDURE core.Sede_spActivarVarios
(
    @SedeIds compartido.IdListType READONLY
)
AS
    BEGIN
        SET NOCOUNT ON;
        UPDATE S
        SET S.IsDeleted = 0
        FROM core.Sede AS S
        INNER JOIN @SedeIds AS Lista    
            ON S.SedeId = Lista.Id
            WHERE S.IsDeleted = 1;
        SELECT @@ROWCOUNT;
    END
GO

CREATE OR ALTER PROCEDURE core.Sede_spExisteSedeEnDireccion
(
    @Direccion NVARCHAR(200)
)
AS
    BEGIN
        SET NOCOUNT ON;
        IF EXISTS 
        (
            SELECT 1 
            FROM core.Sede 
            WHERE Direccion = @Direccion AND IsDeleted = 0
        )
            SELECT CAST (1 AS BIT);
        ELSE
            SELECT CAST (0 AS BIT);
    END
GO

CREATE OR ALTER PROCEDURE core.Sede_spObtenerPorDescripcion
(
    @Descripcion NVARCHAR(100)
)
AS
    BEGIN
        SET NOCOUNT ON;
        SELECT
            SedeId,
            Descripcion,
            Direccion,
            IsDeleted
        FROM core.Sede
        WHERE Descripcion = @Descripcion AND IsDeleted = 0;
    END
GO

CREATE OR ALTER PROCEDURE core.Sede_spObtenerSedesConEmpleados
AS
    BEGIN
        SET NOCOUNT ON;
        SELECT DISTINCT
            S.SedeId,
            S.Descripcion,
            S.Direccion,
            E.EmpleadoId,
            E.Nombres,
            E.Paterno,
            E.Materno,
            E.NumeroDocumento
        FROM core.Sede AS S
        INNER JOIN core.Empleado AS E
            ON S.SedeId = E.EmpleadoSedeId
        WHERE S.IsDeleted = 0 AND E.IsDeleted = 0;
    END
GO

CREATE OR ALTER PROCEDURE core.Sede_spTieneMovimientosAsociados
(
    @SedeId INT
)
AS
    BEGIN
        SET NOCOUNT ON;
        IF EXISTS 
        (
            SELECT 1 FROM core.Empleado WHERE EmpleadoSedeId = @SedeId AND IsDeleted = 0
        )
            SELECT CAST (1 AS BIT); -- Devuelve 1 si tiene movimientos asociados
        ELSE
            SELECT CAST (0 AS BIT); -- Devuelve 0 si NO tiene movimientos asociados
    END
GO  

/*
    SedeId			INT,
    Descripcion		NVARCHAR (100),
    Direccion		NVARCHAR (200),
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
PROPIOS:
ExisteSedeEnDireccion
ObtenerPorDescripcion
ObtenerSedesConEmpleados
TieneMovimientosAsociados
*/