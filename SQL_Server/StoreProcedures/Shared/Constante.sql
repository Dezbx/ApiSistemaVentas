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
        C.Valor
        FROM compartido.Constante AS C
            WHERE ConstanteId = @ConstanteId
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
        C.Valor
        FROM compartido.Constante AS C
    END
GO

CREATE OR ALTER PROCEDURE compartido.Constante_spAgregar
(
    @GrupoConstanteId	INT, 
    @Valor				INT,
    @Descripcion		VARCHAR(100),
    @Orden				INT 
)
AS
    BEGIN
        SET NOCOUNT ON;
        INSERT INTO compartido.Constante (GrupoConstanteId, Valor, Descripcion, Orden)
        VALUES (@GrupoConstanteId, @Valor, @Descripcion, @Orden)

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
    END
GO


CREATE OR ALTER PROCEDURE compartido.Constante_spExistePorId
(
    @ConstanteId INT
)
AS
    BEGIN
        SET NOCOUNT ON;
        IF EXISTS (SELECT 1 FROM compartido.Constante WHERE ConstanteId = @ConstanteId)
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
    END
GO

-- Necesario para la creacion de varios registros
-- Creamos un tipo de tabla para el esquema compartido

CREATE OR ALTER PROCEDURE compartido.Constante_spAgregarVarios
(

)
AS
    BEGIN
        SET NOCOUNT ON;
    END
GO


CREATE OR ALTER PROCEDURE compartido.Constante_spActualizarVarios
(

)
AS
    BEGIN
        SET NOCOUNT ON;
    END
GO


CREATE OR ALTER PROCEDURE compartido.Constante_spDesactivarVarios
(

)
AS
    BEGIN
        SET NOCOUNT ON;
    END
GO


CREATE OR ALTER PROCEDURE compartido.Constante_spObtenerPorGrupoConstanteId
(

)
AS
    BEGIN
        SET NOCOUNT ON;
    END
GO


CREATE OR ALTER PROCEDURE compartido.Constante_spObtenerPorGrupoYValor
(

)
AS
    BEGIN
        SET NOCOUNT ON;
    END
GO


CREATE OR ALTER PROCEDURE compartido.Constante_spExisteValorEnGrupo
(

)
AS
    BEGIN
        SET NOCOUNT ON;
    END
GO


CREATE OR ALTER PROCEDURE compartido.Constante_spExisteDescripcionEnGrupo
(

)
AS
    BEGIN
        SET NOCOUNT ON;
    END
GO


CREATE OR ALTER PROCEDURE compartido.Constante_spContarConstantesEnGrupo
(

)
AS
    BEGIN
        SET NOCOUNT ON;
    END
GO


CREATE OR ALTER PROCEDURE compartido.Constante_spTieneConstantesAsociadas
(

)
AS
    BEGIN
        SET NOCOUNT ON;
    END
GO


CREATE OR ALTER PROCEDURE compartido.Constante_spObtenerConstantePorDescripcion
(

)
AS
    BEGIN
        SET NOCOUNT ON;
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
PROPIOS:
ObtenerPorGrupoConstanteId
ObtenerPorGrupoYValor
ExisteValorEnGrupo
ExisteDescripcionEnGrupo
ContarConstantesEnGrupo
TieneConstantesAsociadas
ObtenerConstantePorDescripcion
*/

