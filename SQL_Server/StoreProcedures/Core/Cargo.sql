USE SistemaVentasBD
GO

CREATE OR ALTER PROCEDURE core.Cargo_spObtenerPorId
(
    @CargoId INT
)
AS
    BEGIN
        SET NOCOUNT ON;
        SELECT
            C.CargoId,
            C.Descripcion,
            C.IsDeleted
        FROM core.Cargo AS C
        WHERE C.CargoId = @CargoId
            AND C.IsDeleted = 0
    END
GO

CREATE OR ALTER PROCEDURE core.Cargo_spObtenerTodos 
AS
    BEGIN
        SET NOCOUNT ON;
        SELECT
            C.CargoId,
            C.Descripcion,
            C.IsDeleted
        FROM core.Cargo AS C
    END 
GO
CREATE OR ALTER PROCEDURE core.Cargo_spAgregar 
(
    @Descripcion NVARCHAR(100),
    @IsDeleted BIT = 0
)
AS
    BEGIN
        SET NOCOUNT ON;
        INSERT INTO core.Cargo (Descripcion, IsDeleted)
        VALUES (@Descripcion, @IsDeleted)

        -- Retorna el ID generado para que Dapper lo capture
        SELECT CAST(SCOPE_IDENTITY() AS INT);
    END
GO

CREATE OR ALTER PROCEDURE core.Cargo_spActualizar 
(
    @CargoId INT,
    @Descripcion NVARCHAR(100)
)
AS
    BEGIN
        SET NOCOUNT ON;
        UPDATE core.Cargo
        SET Descripcion = @Descripcion
        WHERE CargoId = @CargoId
    END
GO

CREATE OR ALTER PROCEDURE core.Cargo_spExistePorId
(
    @CargoId INT
)
AS
    BEGIN
        SET NOCOUNT ON;
        IF EXISTS (SELECT 1 FROM core.Cargo WHERE CargoId = @CargoId AND IsDeleted = 0)
            SELECT CAST (1 AS BIT)
        ELSE
            SELECT CAST (0 AS BIT)
    END
GO

CREATE OR ALTER PROCEDURE core.Cargo_spContarTotal 
AS
    BEGIN
        SET NOCOUNT ON;
        SELECT COUNT(*) AS TotalCargos
        FROM core.Cargo
        WHERE IsDeleted = 0
    END
GO

IF NOT EXISTS (SELECT * FROM sys.types WHERE name = 'CargoCreateType' AND schema_id = SCHEMA_ID('core'))
BEGIN
    CREATE TYPE core.CargoCreateType AS TABLE
    (
        Descripcion NVARCHAR(100),
        IsDeleted BIT
    )
END
GO

IF NOT EXISTS (SELECT * FROM sys.types WHERE name = 'CargoUpdateType' AND schema_id = SCHEMA_ID('core'))
BEGIN
    CREATE TYPE core.CargoUpdateType AS TABLE
    (
        Descripcion NVARCHAR(100)
    )
END
GO

CREATE OR ALTER PROCEDURE core.Cargo_spAgregarVarios 
(
    @Cargos core.CargoCreateType READONLY
)
AS
    BEGIN
        SET NOCOUNT ON;
        INSERT INTO core.Cargo (Descripcion, IsDeleted)
        SELECT Descripcion, IsDeleted
        FROM @Cargos

        SELECT @@ROWCOUNT;

    END
GO

CREATE OR ALTER PROCEDURE core.Cargo_spActualizarVarios 
(
    @Cargos core.CargoUpdateType READONLY
)
AS
    BEGIN
        SET NOCOUNT ON;
        UPDATE C
        SET C.Descripcion = ListaCargos.Descripcion
        FROM core.Cargo AS C
        INNER JOIN @Cargos AS ListaCargos
            ON C.CargoId = ListaCargos.CargoId
        WHERE C.IsDeleted = 0
    END
GO

CREATE OR ALTER PROCEDURE core.Cargo_spDesactivarVarios 
(
    @CargoIds compartido.IdListTableType READONLY
)
AS
    BEGIN
        SET NOCOUNT ON;
        UPDATE C
        SET C.IsDeleted = 1
        FROM core.Cargo AS C
        INNER JOIN @CargoIds AS Ids
            ON C.CargoId = Ids.Id
        WHERE C.IsDeleted = 0

        SELECT @@ROWCOUNT;
    END
GO

CREATE OR ALTER PROCEDURE core.Cargo_spActivarVarios
(
    @CargoIds compartido.IdListTableType READONLY
)
AS
    BEGIN
        SET NOCOUNT ON;
        UPDATE C
        SET C.IsDeleted = 0
        FROM core.Cargo AS C
        INNER JOIN @CargoIds AS Ids
            ON C.CargoId = Ids.Id
        WHERE C.IsDeleted = 1   
        SELECT @@ROWCOUNT;
    END
GO

CREATE OR ALTER PROCEDURE core.Cargo_spExisteNombre
(
    @Descripcion NVARCHAR(100)
)
AS
    BEGIN
        SET NOCOUNT ON;
        IF EXISTS (SELECT 1 FROM core.Cargo WHERE Descripcion = @Descripcion AND IsDeleted = 0)
            SELECT CAST (1 AS BIT)
        ELSE
            SELECT CAST (0 AS BIT)
    END
GO

CREATE OR ALTER PROCEDURE core.Cargo_spObtenerPorNombre
(
    @Descripcion NVARCHAR(100)
)
AS
    BEGIN
        SET NOCOUNT ON;
        SELECT
            C.CargoId,
            C.Descripcion
        FROM core.Cargo AS C
        WHERE C.Descripcion = @Descripcion
            AND C.IsDeleted = 0
    END
GO

/*
    CargoId			INT,
    Descripcion		NVARCHAR,
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
ExisteNombre
ObtenerPorNombre
*/