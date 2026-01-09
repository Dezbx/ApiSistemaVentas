USE SistemaVentasBD
GO

CREATE OR ALTER PROCEDURE compartido.GrupoConstante_spObtenerPorId
(
    @GrupoConstanteId INT
)
AS
    BEGIN
        SET NOCOUNT ON;

        SELECT 
        GC.GrupoConstanteId,
        GC.Descripcion,
        GC.IsDeleted
        FROM compartido.GrupoConstante AS GC
            WHERE GC.GrupoConstanteId = @GrupoConstanteId
                AND GC.IsDeleted = 0 -- Solo se devuelve activos
    END
GO

CREATE OR ALTER PROCEDURE compartido.GrupoConstante_spObtenerTodos

AS
    BEGIN
        SET NOCOUNT ON;
        SELECT 
            GC.GrupoConstanteId,
            GC.Descripcion,
            GC.IsDeleted
            FROM compartido.GrupoConstante AS GC
    END
GO

CREATE OR ALTER PROCEDURE compartido.GrupoConstante_spAgregar
(
    @Descripcion    VARCHAR (100),
    @IsDeleted      BIT = 0 -- Por defecto 0 (Activo)
)
AS
    BEGIN
        SET NOCOUNT ON;
        INSERT INTO compartido.GrupoConstante (Descripcion, IsDeleted)
        VALUES (@Descripcion, @IsDeleted)

        -- Retorna el ID generado para que Dapper lo capture
        SELECT CAST(SCOPE_IDENTITY() AS INT);
    END
GO

CREATE OR ALTER PROCEDURE compartido.GrupoConstante_spActualizar
(
    @GrupoConstanteId INT,
    @Descripcion VARCHAR (100)
)
AS
    BEGIN
        SET NOCOUNT ON;
        UPDATE compartido.GrupoConstante
        SET Descripcion = @Descripcion
        WHERE GrupoConstanteId = @GrupoConstanteId
        AND IsDeleted = 0; -- solo permite actualizar si no está "borrado"
    
        SELECT @@ROWCOUNT;

    END
GO

CREATE OR ALTER PROCEDURE compartido.GrupoConstante_spExistePorId
(
    @GrupoConstanteId INT
)
AS
    BEGIN
        SET NOCOUNT ON;

        IF EXISTS 
        (
            SELECT 1
            FROM compartido.GrupoConstante AS GC
            WHERE GC.GrupoConstanteId = @GrupoConstanteId
                AND IsDeleted = 0
        )
            SELECT CAST(1 AS BIT); -- Retornamos un valor seleccionable para Dapper
        ELSE
            SELECT CAST(0 AS BIT);
    END
GO

CREATE OR ALTER PROCEDURE compartido.GrupoConstante_spContarTotal
AS
    BEGIN
        SET NOCOUNT ON;
        SELECT
        COUNT (GrupoConstanteId) AS TotalGrupoConstante
        FROM compartido.GrupoConstante AS GC
        WHERE IsDeleted = 0
END
GO

-- Necesario para la creacion de varios registros
-- Creamos un tipo de tabla para el esquema compartido
IF NOT EXISTS (SELECT * FROM sys.types WHERE name = 'GrupoConstanteCreateType' AND schema_id = SCHEMA_ID('compartido'))
BEGIN
    CREATE TYPE compartido.GrupoConstanteCreateType AS TABLE
    (   
        Descripcion      VARCHAR(100),
        IsDeleted        BIT
    );
END
GO

IF NOT EXISTS (SELECT * FROM sys.types WHERE name = 'GrupoConstanteUpdateType' AND schema_id = SCHEMA_ID('compartido'))
BEGIN
    CREATE TYPE compartido.GrupoConstanteUpdateType AS TABLE
    (   
        GrupoConstanteId INT NULL, -- Necesario para actualizaciones
        Descripcion      VARCHAR(100)
    );
END
GO

CREATE OR ALTER PROCEDURE compartido.GrupoConstante_spAgregarVarios
(
    @GrupoConstanteLista compartido.GrupoConstanteCreateType READONLY
)
AS
BEGIN
    SET NOCOUNT ON;

    INSERT INTO compartido.GrupoConstante (Descripcion, IsDeleted)
    SELECT Descripcion, IsDeleted
    FROM @GrupoConstanteLista;

    -- Retorna la cantidad de registros insertados
    SELECT @@ROWCOUNT;
END
GO

CREATE OR ALTER PROCEDURE compartido.GrupoConstante_spActualizarVarios
(
    @GrupoConstanteLista compartido.GrupoConstanteUpdateType READONLY
)
AS
BEGIN
    SET NOCOUNT ON;

    UPDATE GC
    SET GC.Descripcion = Lista.Descripcion
    FROM compartido.GrupoConstante AS GC
    INNER JOIN @GrupoConstanteLista AS Lista 
        ON GC.GrupoConstanteId = Lista.GrupoConstanteId
    WHERE GC.IsDeleted = 0; -- solo actualizar los que no están eliminados

    SELECT @@ROWCOUNT;
END
GO

CREATE OR ALTER PROCEDURE compartido.GrupoConstante_spDesactivarVarios
(
    @GrupoConstanteIds compartido.IdListType READONLY
)
AS
    BEGIN
        SET NOCOUNT ON;
        UPDATE GU
        SET GU.IsDeleted = 1 -- Lo desactivamos
        FROM compartido.GrupoConstante AS GU
        INNER JOIN @GrupoConstanteIds AS ListaGrupoConstante ON GU.GrupoConstanteId = ListaGrupoConstante.Id
        WHERE GU.IsDeleted = 0; -- solo actualizar los que NO están eliminados
        SELECT @@ROWCOUNT;
END
GO

CREATE OR ALTER PROCEDURE compartido.GrupoConstante_spActivarVarios
(
    @GrupoConstanteIds compartido.IdListType READONLY
)
AS
    BEGIN
        SET NOCOUNT ON;
        UPDATE GU
        SET GU.IsDeleted = 0 -- Lo activamos
        FROM compartido.GrupoConstante AS GU
        INNER JOIN @GrupoConstanteIds AS ListaGrupoConstante ON GU.GrupoConstanteId = ListaGrupoConstante.Id
        WHERE GU.IsDeleted = 1; -- solo actualizar los que están eliminados
        SELECT @@ROWCOUNT;

    END
GO

CREATE OR ALTER PROCEDURE compartido.GrupoConstante_spObtenerPorDescripcion
(
    @Descripcion VARCHAR (100)
)
AS
    BEGIN
        SET NOCOUNT ON;
        SELECT 
        GC.GrupoConstanteId,
        GC.Descripcion,
        GC.IsDeleted
        FROM compartido.GrupoConstante AS GC
        WHERE TRIM(GC.Descripcion) LIKE '%' + TRIM(@Descripcion) + '%'
            AND IsDeleted = 0
    END
GO

CREATE OR ALTER PROCEDURE compartido.GrupoConstante_spExisteDescripcion
(
    @Descripcion VARCHAR (100)
)
AS
    BEGIN
        SET NOCOUNT ON;
        IF EXISTS 
                (
                    SELECT 1
                    FROM compartido.GrupoConstante AS GC
                    WHERE GC.Descripcion = TRIM(@Descripcion)
                        AND IsDeleted = 0
                )
                    SELECT CAST(1 AS BIT); -- Retornamos un valor seleccionable para Dapper
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
ObtenerPorDescripcionAsync
ExisteDescripcionAsync
*/