USE SistemaVentasBD
GO

CREATE OR ALTER PROCEDURE compartido.TipoDocumento_spObtenerPorId
(
    @TipoDocumentoId INT
)
AS
    BEGIN
        SET NOCOUNT ON;
        SELECT
            TipoDocumentoId,
            Descripcion,
            IsDeleted
        FROM compartido.TipoDocumento
        WHERE TipoDocumentoId = @TipoDocumentoId
            AND IsDeleted = 0;
    END
GO
 
CREATE OR ALTER PROCEDURE compartido.TipoDocumento_spObtenerTodos 
AS
    BEGIN
        SET NOCOUNT ON;
        SELECT
            TipoDocumentoId,
            Descripcion,
            IsDeleted
        FROM compartido.TipoDocumento;
    END
GO
 
CREATE OR ALTER PROCEDURE compartido.TipoDocumento_spAgregar 
(   
    @Descripcion NVARCHAR(100),
    @IsDeleted BIT = 0
)
AS
    BEGIN
        SET NOCOUNT ON;
        INSERT INTO compartido.TipoDocumento
        (
            Descripcion,
            IsDeleted
        )
        VALUES
        (
            @Descripcion,
            @IsDeleted
        );

        SELECT CAST(SCOPE_IDENTITY() AS INT);
    END
GO
 
CREATE OR ALTER PROCEDURE compartido.TipoDocumento_spActualizar 
(
    @TipoDocumentoId INT,
    @Descripcion NVARCHAR(100)
)
AS
    BEGIN
        SET NOCOUNT ON;
        UPDATE compartido.TipoDocumento
        SET
            Descripcion = @Descripcion
        WHERE TipoDocumentoId = @TipoDocumentoId 
            AND IsDeleted = 0;

        SELECT @@ROWCOUNT;
    END
GO
 
CREATE OR ALTER PROCEDURE compartido.TipoDocumento_spExistePorId
(
    @TipoDocumentoId INT
)
AS
    BEGIN
        SET NOCOUNT ON;
        IF EXISTS 
        (
            SELECT 1
            FROM compartido.TipoDocumento
            WHERE TipoDocumentoId = @TipoDocumentoId
        )
            SELECT CAST(1 AS BIT);
        ELSE
            SELECT CAST(0 AS BIT);
    END
GO
 
CREATE OR ALTER PROCEDURE compartido.TipoDocumento_spContarTotal 
AS
    BEGIN
        SET NOCOUNT ON;
        SELECT
            COUNT(TipoDocumentoId) AS TotalTipoDocumento
        FROM compartido.TipoDocumento
        WHERE IsDeleted = 0;
    END
GO

IF NOT EXISTS (SELECT * FROM sys.types WHERE name = 'TipoDocumentoCreateType' AND schema_id = SCHEMA_ID('compartido'))
BEGIN
    CREATE TYPE compartido.TipoDocumentoCreateType AS TABLE
    (
        Descripcion NVARCHAR(100),
        IsDeleted BIT DEFAULT 0
    );
END
GO 

IF NOT EXISTS (SELECT * FROM sys.types WHERE name = 'TipoDocumentoUpdateType' AND schema_id = SCHEMA_ID('compartido'))
BEGIN
    CREATE TYPE compartido.TipoDocumentoUpdateType AS TABLE
    (
        TipoDocumentoId INT NULL,
        Descripcion NVARCHAR(100)
    );
END
GO

CREATE OR ALTER PROCEDURE compartido.TipoDocumento_spAgregarVarios
(
    @TipoDocumentoTable compartido.TipoDocumentoCreateType READONLY
)
AS
    BEGIN
        SET NOCOUNT ON;
        INSERT INTO compartido.TipoDocumento
        (
            Descripcion,
            IsDeleted
        )
        SELECT
            Descripcion,
            IsDeleted
        FROM @TipoDocumentoTable;

        SELECT @@ROWCOUNT;
    END
GO
  
CREATE OR ALTER PROCEDURE compartido.TipoDocumento_spActualizarVarios 
(
    @TipoDocumentoTable compartido.TipoDocumentoUpdateType READONLY
)
AS
    BEGIN
        SET NOCOUNT ON;
        UPDATE TD
        SET
            TD.Descripcion = Lista.Descripcion
        FROM compartido.TipoDocumento AS TD
        INNER JOIN @TipoDocumentoTable AS Lista
            ON TD.TipoDocumentoId = Lista.TipoDocumentoId
        WHERE TD.IsDeleted = 0;
        SELECT @@ROWCOUNT;
    END
GO
 
CREATE OR ALTER PROCEDURE compartido.TipoDocumento_spDesactivarVarios 
(
    @Ids compartido.IdListTableType READONLY
)
AS
    BEGIN
        SET NOCOUNT ON;
        UPDATE TD
        SET
            TD.IsDeleted = 1
        FROM compartido.TipoDocumento AS TD
        INNER JOIN @Ids AS Ids
            ON TD.TipoDocumentoId = Ids.Id
        WHERE TD.IsDeleted = 0;
        SELECT @@ROWCOUNT;
    END
GO
 
CREATE OR ALTER PROCEDURE compartido.TipoDocumento_spActivarVarios
(
    @Ids compartido.IdListTableType READONLY
)
AS
    BEGIN
        SET NOCOUNT ON;
        UPDATE TD
        SET
            TD.IsDeleted = 0
        FROM compartido.TipoDocumento AS TD
        INNER JOIN @Ids AS Ids
            ON TD.TipoDocumentoId = Ids.Id
        WHERE TD.IsDeleted = 1;
        SELECT @@ROWCOUNT;
    END
GO
 
CREATE OR ALTER PROCEDURE compartido.TipoDocumento_spObtenerPorDescripcion
(
    @Descripcion NVARCHAR(100)
)
AS
    BEGIN
        SET NOCOUNT ON;
        SELECT
            TipoDocumentoId,
            Descripcion,
            IsDeleted
        FROM compartido.TipoDocumento
        WHERE Descripcion = @Descripcion
            AND IsDeleted = 0;
    END
GO
 
CREATE OR ALTER PROCEDURE compartido.TipoDocumento_spExisteDescripcion
(
    @Descripcion NVARCHAR(100)
)
AS
    BEGIN
        SET NOCOUNT ON;
        IF EXISTS 
        (
            SELECT 1
            FROM compartido.TipoDocumento
            WHERE Descripcion = @Descripcion
                AND IsDeleted = 0
        )
            SELECT CAST(1 AS BIT);
        ELSE
            SELECT CAST(0 AS BIT);
    END
GO
 

/*
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
ObtenerPorDescripcion
ExisteDescripcion
*/