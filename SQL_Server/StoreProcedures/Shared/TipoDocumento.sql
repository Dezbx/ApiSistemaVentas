USE SistemaVentasBD
GO

CREATE OR ALTER PROCEDURE compartido.TipoDocumento_spObtenerPorId
(
    @TipoDocumentoId INT
)
AS
    BEGIN
        SET NOCOUNT ON;
    END
GO
 
CREATE OR ALTER PROCEDURE compartido.TipoDocumento_spObtenerTodos 
()
AS
    BEGIN
        SET NOCOUNT ON;
    END
GO
 
CREATE OR ALTER PROCEDURE compartido.TipoDocumento_spAgregar 
()
AS
    BEGIN
        SET NOCOUNT ON;
    END
GO
 
CREATE OR ALTER PROCEDURE compartido.TipoDocumento_spActualizar 
()
AS
    BEGIN
        SET NOCOUNT ON;
    END
GO
 
CREATE OR ALTER PROCEDURE compartido.TipoDocumento_spExistePorId
()
AS
    BEGIN
        SET NOCOUNT ON;
    END
GO
 
CREATE OR ALTER PROCEDURE compartido.TipoDocumento_spContarTotal 
()
AS
    BEGIN
        SET NOCOUNT ON;
    END
GO
 
CREATE OR ALTER PROCEDURE compartido.TipoDocumento_spAgregarVarios
()
AS
    BEGIN
        SET NOCOUNT ON;
    END
GO
  
CREATE OR ALTER PROCEDURE compartido.TipoDocumento_spActualizarVarios 
()
AS
    BEGIN
        SET NOCOUNT ON;
    END
GO
 
CREATE OR ALTER PROCEDURE compartido.TipoDocumento_spDesactivarVarios 
()
AS
    BEGIN
        SET NOCOUNT ON;
    END
GO
 
CREATE OR ALTER PROCEDURE compartido.TipoDocumento_spActivarVarios
()
AS
    BEGIN
        SET NOCOUNT ON;
    END
GO
 
CREATE OR ALTER PROCEDURE compartido.TipoDocumento_spObtenerPorDescripcion
()
AS
    BEGIN
        SET NOCOUNT ON;
    END
GO
 
CREATE OR ALTER PROCEDURE compartido.TipoDocumento_spExisteDescripcion
()
AS
    BEGIN
        SET NOCOUNT ON;
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