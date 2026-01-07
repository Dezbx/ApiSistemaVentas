USE SistemaVentasBD
GO

CREATE OR ALTER PROCEDURE compartido.Constante_spObtenerPorId 
(
    @ConstanteId INT
)
AS
    BEGIN
        SET NOCOUNT ON;
        SELECT 
        C.ConstanteId,
        C.GrupoConstanteId,
        C.Descripcion,
        C.Orden,
        C.Valor,
		C.IsDeleted
        FROM compartido.Constante AS C
            WHERE ConstanteId = @ConstanteId
				AND C.IsDeleted = 0
    END
GO

CREATE OR ALTER PROCEDURE compartido.Constante_spObtenerTodos
(
    @ConstanteId INT

)
AS
    BEGIN
        SET NOCOUNT ON;
        SELECT 
        C.ConstanteId,
        C.GrupoConstanteId,
        C.Descripcion,
        C.Orden,
        C.Valor,
		C.IsDeleted
        FROM compartido.Constante AS C
    END
GO

CREATE OR ALTER PROCEDURE compartido.Constante_spAgregar
(
    @GrupoConstanteId	INT, 
    @Valor				INT,
    @Descripcion		VARCHAR(100),
    @Orden				INT,
	@IsDeleted			BIT
)
AS
    BEGIN
        SET NOCOUNT ON;
        INSERT INTO compartido.Constante (GrupoConstanteId, Valor, Descripcion, Orden, IsDeleted)
        VALUES (@GrupoConstanteId, @Valor, @Descripcion, @Orden, @IsDeleted)

        -- Retorna el ID generado para que Dapper lo capture
        SELECT CAST(SCOPE_IDENTITY() AS INT);
    END
GO


CREATE OR ALTER PROCEDURE compartido.Constante_spActualizar
(
    @ConstanteId        INT,
    @GrupoConstanteId	INT, 
    @Valor				INT,
    @Descripcion		VARCHAR(100),
    @Orden				INT
)
AS
    BEGIN
        SET NOCOUNT ON;
        UPDATE compartido.Constante
        SET GrupoConstanteId = @GrupoConstanteId,
            Valor = @Valor,
            Descripcion = @Descripcion,
            Orden = @Orden
        WHERE ConstanteId = @ConstanteId
			AND C.IsDeleted = 0;
    END
GO


CREATE OR ALTER PROCEDURE compartido.Constante_spExistePorId
(
    @ConstanteId INT
)
AS
    BEGIN
        SET NOCOUNT ON;
        IF EXISTS 
		(
			SELECT 1 
			FROM compartido.Constante 
			WHERE ConstanteId = @ConstanteId  
				AND C.IsDeleted = 0
		)
            SELECT CAST(1 AS BIT);
        ELSE
            SELECT CAST(0 AS BIT)
    END
GO


CREATE OR ALTER PROCEDURE compartido.Constante_spContarTotal
AS
    BEGIN
        SET NOCOUNT ON;
        SELECT 
        COUNT (C.ConstanteId)
        FROM compartido.Constante AS C
		WHERE C.IsDeleted = 0
    END
GO

-- Necesario para la creacion de varios registros
-- Creamos un tipo de tabla para el esquema compartido
IF NOT EXISTS (SELECT * FROM sys.types WHERE name = 'ConstanteCreateType' AND schema_id = SCHEMA_ID('compartido'))
BEGIN
    CREATE TYPE compartido.ConstanteCreateType AS TABLE
    (   
			GrupoConstanteId	INT,
			Valor				INT,
			Descripcion			VARCHAR(100),
			Orden				INT,
			IsDeleted			BIT
    );
END
GO

IF NOT EXISTS (SELECT * FROM sys.types WHERE name = 'ConstanteUpdateType' AND schema_id = SCHEMA_ID('compartido'))
BEGIN
    CREATE TYPE compartido.ConstanteUpdateType AS TABLE
    (   
			ConstanteId			INT NULL,
			GrupoConstanteId	INT,
			Valor				INT,
			Descripcion			VARCHAR(100),
			Orden				INT
    );
END
GO

CREATE OR ALTER PROCEDURE compartido.Constante_spAgregarVarios
(
	@ConstanteLista compartido.ConstanteCreateType READONLY	
)
AS
    BEGIN
        SET NOCOUNT ON;
		INSERT INTO compartido.Constante (GrupoConstanteId, Valor, Descripcion, Orden,IsDeleted)
		SELECT GrupoConstanteId, Valor, Descripcion, Orden, IsDeleted
		FROM @ConstanteLista

		-- Retorna la cantidad de registros insertados
		SELECT @@ROWCOUNT;
	END
GO

CREATE OR ALTER PROCEDURE compartido.Constante_spActualizarVarios
(
	@ConstanteLista compartido.ConstanteUpdateType READONLY
)
AS
    BEGIN
        SET NOCOUNT ON;
		UPDATE C 	-- Modificar tabla C (Constante) Linea 175
		SET C.GrupoConstanteId = Lista.GrupoConstanteId,
			C.Valor = Lista.Valor,
			C.Descripcion = Lista.Descripcion,
			C.Orden = Lista.Orden
		FROM compartido.Constante AS C 
		INNER JOIN @ConstanteLista AS Lista
			ON C.ConstanteId = Lista.ConstanteId
		WHERE C.IsDeleted = 0

		SELECT @@ROWCOUNT;
    END
GO


CREATE OR ALTER PROCEDURE compartido.Constante_spDesactivarVarios
(
	@Ids compartido.IdListTableType READONLY
)
AS
    BEGIN
        SET NOCOUNT ON;

		UPDATE C 	
		SET C.IsDeleted = 1
		FROM compartido.Constante AS C 
		INNER JOIN @Ids AS Lista
			ON C.ConstanteId = Lista.Id
		WHERE C.IsDeleted = 0

		SELECT @@ROWCOUNT;

    END
GO

CREATE OR ALTER PROCEDURE compartido.Constante_spActivarVarios
(
	@Ids compartido.IdListTableType READONLY
)
AS
    BEGIN
        SET NOCOUNT ON;

		UPDATE C 	
		SET C.IsDeleted = 0
		FROM compartido.Constante AS C 
		INNER JOIN @Ids AS Lista
			ON C.ConstanteId = Lista.Id
		WHERE C.IsDeleted = 1

		SELECT @@ROWCOUNT;

    END
GO


CREATE OR ALTER PROCEDURE compartido.Constante_spObtenerPorGrupoConstanteId
(
	@GrupoConstanteId INT
)
AS
    BEGIN
        SET NOCOUNT ON;
		SELECT
		C.ConstanteId,
		C.GrupoConstanteId,
		C.Valor,
		C.Descripcion,
		C.Orden,
		C.IsDeleted
		FROM compartido.Constante AS C
			WHERE C.GrupoConstanteId = @GrupoConstanteId
				AND C.IsDeleted = 0
    END
GO


CREATE OR ALTER PROCEDURE compartido.Constante_spObtenerPorGrupoYValor
(
	@GrupoConstanteId INT,
	@Valor INT
)
AS
    BEGIN
        SET NOCOUNT ON;
		SELECT
		C.ConstanteId,
		C.GrupoConstanteId,
		C.Valor,
		C.Descripcion,
		C.Orden,
		C.IsDeleted
		FROM compartido.Constante AS C
			WHERE C.GrupoConstanteId = @GrupoConstanteId
				AND C.Valor = @Valor
				AND C.IsDeleted = 0
    END
GO


CREATE OR ALTER PROCEDURE compartido.Constante_spExisteValorEnGrupo
(
	@GrupoConstanteId INT,
	@Valor INT	
)
AS
    BEGIN
        SET NOCOUNT ON;
		IF EXISTS 
		(
			SELECT 1 
			FROM compartido.Constante  AS C
			WHERE C.GrupoConstanteId = @GrupoConstanteId 
				AND C.Valor = @Valor 
		)
			SELECT CAST (1 AS BIT) -- Devuelve 1 si existe
		ELSE
			SELECT CAST (0 AS BIT) -- Devuelve 0 si NO existe
    END
GO


CREATE OR ALTER PROCEDURE compartido.Constante_spExisteDescripcionEnGrupo
(
	@GrupoConstanteId INT,
	@Descripcion VARCHAR(100)
)
AS
    BEGIN
        SET NOCOUNT ON;
		IF EXISTS 
		(
			SELECT 1 
			FROM compartido.Constante  AS C
			WHERE C.GrupoConstanteId = @GrupoConstanteId 
				AND C.Descripcion = @Descripcion 
		)
			SELECT CAST (1 AS BIT) -- Devuelve 1 si existe
		ELSE
			SELECT CAST (0 AS BIT) -- Devuelve 0 si NO existe
    END
GO


CREATE OR ALTER PROCEDURE compartido.Constante_spContarConstantesEnGrupo
(
	@GrupoConstanteId INT
)
AS
    BEGIN
        SET NOCOUNT ON;
		SELECT 
		COUNT (C.GrupoConstanteId) AS ConstantePorGrupo
		FROM compartido.Constante  AS C
			WHERE C.GrupoConstanteId = @GrupoConstanteId
    END
GO


CREATE OR ALTER PROCEDURE compartido.Constante_spTieneConstantesAsociadas
(
	@ConstanteId INT
)
AS
    BEGIN
        SET NOCOUNT ON;
		IF EXISTS 
		(
			SELECT 1 FROM core.Empleado WHERE EstadoConstanteId = @ConstanteId AND IsDeleted = 0
			UNION ALL
			-- Verificar en Clientes
			SELECT 1 FROM core.Cliente WHERE EstadoConstanteId = @ConstanteId AND IsDeleted = 0
			UNION ALL
			-- Verificar en Proveedores
			SELECT 1 FROM core.Proveedor WHERE EstadoConstanteId = @ConstanteId AND IsDeleted = 0
			UNION ALL
			-- Verificar en Ventas
			SELECT 1 FROM core.Venta WHERE EstadoConstanteId = @ConstanteId AND IsDeleted = 0
		)
		    SELECT CAST(1 AS BIT); -- Devuelve True (1) si hay asociaciones
		ELSE
		    SELECT CAST(0 AS BIT); -- Devuelve False (0) si est� libre
		END
GO


CREATE OR ALTER PROCEDURE compartido.Constante_spObtenerConstantePorDescripcion
(
	@GrupoConstanteId INT,
	@Descripcion VARCHAR(100)
)
AS
    BEGIN
        SET NOCOUNT ON;
		SELECT 
		C.ConstanteId,
		C.GrupoConstanteId,
		C.Valor,
		C.Descripcion,
		C.Orden,
		C.IsDeleted
		FROM compartido.Constante  AS C
		WHERE C.GrupoConstanteId = @GrupoConstanteId 
			AND C.Descripcion = @Descripcion
    END
GO
/*
    ConstanteId			INT 
    GrupoConstanteId	INT 
    Valor				INT 
    Descripcion			VARCHAR(100) 
    Orden				INT 

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
ObtenerPorGrupoConstanteId
ObtenerPorGrupoYValor
ExisteValorEnGrupo
ExisteDescripcionEnGrupo
ContarConstantesEnGrupo
TieneConstantesAsociadas
ObtenerConstantePorDescripcion
*/

