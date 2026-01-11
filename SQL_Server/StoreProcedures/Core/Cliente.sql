USE SistemaVentasBD
GO

CREATE OR ALTER PROCEDURE core.Cliente_spObtenerPorId 
(
    @ClienteId INT
)
AS
    BEGIN
        SET NOCOUNT ON;
        SELECT
            C.ClienteId,
            C.ClienteUsuarioId,
            C.ClienteTipoDocumentoId,
            C.Paterno,
            C.Materno,
            C.Nombres,
            C.NumeroDocumento,
            C.Correo,
            C.Telefono,
            C.Sexo,
            C.FechaNacimiento,
            C.Direccion,
            C.EstadoConstanteId
        FROM core.Cliente AS C
        INNER JOIN compartido.Constante AS CO 
            ON C.EstadoConstanteId = CO.ConstanteId
        INNER JOIN compartido.TipoDocumento AS TD
            ON C.ClienteTipoDocumentoId = TD.TipoDocumentoID
        WHERE C.ClienteId = @ClienteId
            AND C.IsDeleted = 0;
    END
GO

CREATE OR ALTER PROCEDURE core.Cliente_spObtenerTodos 
AS
    BEGIN
        SET NOCOUNT ON;
        SELECT
            C.ClienteId,
            C.ClienteUsuarioId,
            C.ClienteTipoDocumentoId,
            C.Paterno,
            C.Materno,
            C.Nombres,
            C.NumeroDocumento,
            C.Correo,
            C.Telefono,
            C.Sexo,
            C.FechaNacimiento,
            C.Direccion,
            C.EstadoConstanteId
        FROM core.Cliente AS C
    END
GO

CREATE OR ALTER PROCEDURE core.Cliente_spAgregar 
(
    @ClienteUsuarioId			INT, 
    @ClienteTipoDocumentoId		INT,
    @Paterno					NVARCHAR (50), 
    @Materno					NVARCHAR (50), 
    @Nombres					NVARCHAR (50), 
    @NumeroDocumento			NVARCHAR (20),
    @Correo						NVARCHAR (100),
    @Telefono					NVARCHAR (15), 
    @Sexo						NCHAR (1), 
    @FechaNacimiento			DATE,
    @Direccion					NVARCHAR (200),
    @EstadoConstanteId			INT,
    -- Auditoria
    @CreatedAt		DATETIME2(0),
    @CreatedBy		INT,           
    @IsDeleted		BIT
)
AS 
    BEGIN
        SET NOCOUNT ON;
        INSERT INTO core.Cliente (
        ClienteUsuarioId,		
        ClienteTipoDocumentoId,
        Paterno,				
        Materno,			
        Nombres,				
        NumeroDocumento,		
        Correo,					
        Telefono,				
        Sexo,					
        FechaNacimiento,	
        Direccion,				
        EstadoConstanteId,
        CreatedAt,
        CreatedBy,
        IsDeleted
        )
        VALUES
        (
        @ClienteUsuarioId,		
        @ClienteTipoDocumentoId,
        @Paterno,				
        @Materno,			
        @Nombres,				
        @NumeroDocumento,		
        @Correo,					
        @Telefono,				
        @Sexo,					
        @FechaNacimiento,	
        @Direccion,				
        @EstadoConstanteId,
        @CreatedAt,
        @CreatedBy,
        @IsDeleted
        )
        SELECT CAST(SCOPE_IDENTITY() AS INT)
    END
GO
 
CREATE OR ALTER PROCEDURE core.Cliente_spActualizar 
(
    @ClienteTipoDocumentoId		INT,
    @Paterno					NVARCHAR (50), 
    @Materno					NVARCHAR (50), 
    @Nombres					NVARCHAR (50), 
    @NumeroDocumento			NVARCHAR (20),
    @Correo						NVARCHAR (100),
    @Telefono					NVARCHAR (15), 
    @Sexo						NCHAR (1), 
    @FechaNacimiento			DATE,
    @Direccion					NVARCHAR (200),
    @EstadoConstanteId			INT,
    -- Auditoria
    @UpdatedAt		DATETIME2(0),
    @UpdatedBy		INT   
)
AS 
    BEGIN
        SET NOCOUNT ON;
        UPDATE core.Cliente 
        SET
           ClienteTipoDocumentoId   = @ClienteTipoDocumentoId,
           Paterno			        = @Paterno,				
           Materno			        = @Materno,				
           Nombres			        = @Nombres,				
           NumeroDocumento		    = @NumeroDocumento,		
           Correo				    = @Correo,				
           Telefono			        = @Telefono,				
           Sexo				        = @Sexo,				
           FechaNacimiento		    = @FechaNacimiento,		
           Direccion			    = @Direccion,			
           EstadoConstanteId	    = @EstadoConstanteId,	
           UpdatedAt                = @UpdatedAt,
           UpdatedBy                = @UpdatedBy
    END
GO
 
CREATE OR ALTER PROCEDURE core.Cliente_spExistePorId
(
    @ClienteId INT
)
AS 
    BEGIN
        SET NOCOUNT ON;
        IF EXISTS 
        (
            SELECT 1 
            FROM core.Cliente 
            WHERE ClienteId = @ClienteId  
                AND IsDeleted = 0
        )
            SELECT CAST(1 AS BIT);
        ELSE
            SELECT CAST(0 AS BIT)
    END
GO
 
CREATE OR ALTER PROCEDURE core.Cliente_spContarTotal 
AS 
    BEGIN
        SET NOCOUNT ON;
        SELECT
        COUNT (C.ClienteId) AS TotalClientes
        FROM core.Cliente AS C
            WHERE C.IsDeleted = 0
    END
GO

IF NOT EXISTS (SELECT * FROM sys.types WHERE name = 'ClienteCreateType' AND schema_id = SCHEMA_ID('core'))
BEGIN
 CREATE TYPE core.ClienteCreateType AS TABLE
    (
    ClienteUsuarioId			INT, 
    ClienteTipoDocumentoId		INT,
    Paterno						NVARCHAR (50), 
    Materno						NVARCHAR (50), 
    Nombres						NVARCHAR (50), 
    NumeroDocumento				NVARCHAR (20),
    Correo						NVARCHAR (100),
    Telefono					NVARCHAR (15), 
    Sexo						NCHAR (1), 
    FechaNacimiento				DATE,
    Direccion					NVARCHAR (200),
    EstadoConstanteId			INT,
    -- Auditoria
    CreatedAt		DATETIME2(0),
    CreatedBy		INT,
    IsDeleted       BIT 
    )
END
GO

IF NOT EXISTS (SELECT * FROM sys.types WHERE name = 'ClienteUpdateType' AND schema_id = SCHEMA_ID('core'))
BEGIN
 CREATE TYPE core.ClienteUpdateType AS TABLE
    (
    ClienteId					INT,
    ClienteUsuarioId			INT, 
    ClienteTipoDocumentoId		INT,
    Paterno						NVARCHAR (50), 
    Materno						NVARCHAR (50), 
    Nombres						NVARCHAR (50), 
    NumeroDocumento				NVARCHAR (20),
    Correo						NVARCHAR (100),
    Telefono					NVARCHAR (15), 
    Sexo						NCHAR (1), 
    FechaNacimiento				DATE,
    Direccion					NVARCHAR (200),
    EstadoConstanteId			INT,
    UpdatedAt		DATETIME2(0), 
    UpdatedBy		INT
    )
END
GO
 
CREATE OR ALTER PROCEDURE core.Cliente_spAgregarVarios 
(
    @Clientes core.ClienteCreateType READONLY
)
AS 
    BEGIN
        SET NOCOUNT ON;
        INSERT INTO core.Cliente
        (
         ClienteUsuarioId,		
         ClienteTipoDocumentoId,
         Paterno,				
         Materno,			
         Nombres,				
         NumeroDocumento,		
         Correo,					
         Telefono,				
         Sexo,					
         FechaNacimiento,	
         Direccion,				
         EstadoConstanteId,
         CreatedAt,
         CreatedBy,
         IsDeleted
        )
        SELECT
         ClienteUsuarioId,	
         ClienteTipoDocumentoId,
         Paterno,				
         Materno,			
         Nombres,				
         NumeroDocumento,		
         Correo,					
         Telefono,				
         Sexo,					
         FechaNacimiento,	
         Direccion,				
         EstadoConstanteId,
         CreatedAt,
         CreatedBy,
         IsDeleted
        FROM @Clientes
    END
GO
 
CREATE OR ALTER PROCEDURE core.Cliente_spActualizarVarios 
(
    @Clientes core.ClienteUpdateType READONLY

)
AS 
    BEGIN
        SET NOCOUNT ON;

        UPDATE C
        SET
            C.ClienteId			      = ListaClientes.ClienteId,		    
            C.ClienteUsuarioId	      = ListaClientes.ClienteUsuarioId,	    
            C.ClienteTipoDocumentoId  = ListaClientes.ClienteTipoDocumentoId,
            C.Paterno				  = ListaClientes.Paterno,				
            C.Materno				  = ListaClientes.Materno,				
            C.Nombres				  = ListaClientes.Nombres,				
            C.NumeroDocumento		  = ListaClientes.NumeroDocumento,		
            C.Correo				  = ListaClientes.Correo,				
            C.Telefono			      = ListaClientes.Telefono,			    
            C.Sexo				      = ListaClientes.Sexo,				    
            C.FechaNacimiento		  = ListaClientes.FechaNacimiento,		
            C.Direccion			      = ListaClientes.Direccion,			    
            C.EstadoConstanteId	      = ListaClientes.EstadoConstanteId,	    
            C.UpdatedAt		          = ListaClientes.UpdatedAt,		        
            C.UpdatedBy		          = ListaClientes.UpdatedBy		        
        FROM core.Cliente AS C
        INNER JOIN @Clientes AS ListaClientes 
            ON C.ClienteId = ListaClientes.ClienteId
        WHERE C.IsDeleted = 0

        SELECT @@ROWCOUNT;

    END
GO
 
CREATE OR ALTER PROCEDURE core.Cliente_spDesactivarVarios 
(
    @ClientesIds compartido.IdListType READONLY
)
AS 
    BEGIN
        SET NOCOUNT ON;
        UPDATE C
        SET
            C.IsDeleted = 1
        FROM core.Cliente AS C
        INNER JOIN @ClientesIds AS Lista ON C.ClienteId = Lista.Id 
        WHERE C.IsDeleted = 0

        SELECT @@ROWCOUNT;
    END
GO
 
CREATE OR ALTER PROCEDURE core.Cliente_spActivarVarios
(
    @ClientesIds compartido.IdListType READONLY
)
AS 
    BEGIN
        SET NOCOUNT ON;
        UPDATE C
        SET
            C.IsDeleted = 0
        FROM core.Cliente AS C
        INNER JOIN @ClientesIds AS Lista ON C.ClienteId = Lista.Id 
        WHERE C.IsDeleted = 1

        SELECT @@ROWCOUNT;
    END
GO
 
CREATE OR ALTER PROCEDURE core.Cliente_spObtenerEliminados
AS 
    BEGIN
        SET NOCOUNT ON;
        SELECT
            C.ClienteId,
            C.ClienteUsuarioId,
            C.ClienteTipoDocumentoId,
            C.Paterno,
            C.Materno,
            C.Nombres,
            C.NumeroDocumento,
            C.Correo,
            C.Telefono,
            C.Sexo,
            C.FechaNacimiento,
            C.Direccion,
            C.EstadoConstanteId
        FROM core.Cliente AS C
        INNER JOIN compartido.Constante AS CO 
            ON C.EstadoConstanteId = CO.ConstanteId
        INNER JOIN compartido.TipoDocumento AS TD
            ON C.ClienteTipoDocumentoId = TD.TipoDocumentoID
        WHERE C.IsDeleted = 0
    END
GO
 
CREATE OR ALTER PROCEDURE core.Cliente_spEliminarLogico
(
    @ClienteId INT,
    @UpdatedAt DATETIME2 (0),
    @UpdatedBy INT
)
AS 
    BEGIN
        SET NOCOUNT ON;
        UPDATE C 
        SET
            C.IsDeleted = 1,
            UpdatedAt = @UpdatedAt,     
            UpdatedBy = @UpdatedBy
        FROM core.Cliente AS C
        WHERE ClienteId = @ClienteId
    END
GO
 
CREATE OR ALTER PROCEDURE core.Cliente_spObtenerPorNumeroDocumento
(
    @NumeroDocumento NVARCHAR (20)
)
AS 
    BEGIN
        SET NOCOUNT ON;
        SELECT
            C.ClienteId,
            C.ClienteUsuarioId,
            C.ClienteTipoDocumentoId,
            C.Paterno,
            C.Materno,
            C.Nombres,
            C.NumeroDocumento,
            C.Correo,
            C.Telefono,
            C.Sexo,
            C.FechaNacimiento,
            C.Direccion,
            C.EstadoConstanteId
        FROM core.Cliente AS C
        INNER JOIN compartido.Constante AS CO 
            ON C.EstadoConstanteId = CO.ConstanteId
        INNER JOIN compartido.TipoDocumento AS TD
            ON C.ClienteTipoDocumentoId = TD.TipoDocumentoID
        WHERE C.NumeroDocumento = @NumeroDocumento 
            AND C.IsDeleted = 0
    END
GO
 
CREATE OR ALTER PROCEDURE core.Cliente_spExisteCorreo
(
    @Correo NVARCHAR (100)
)
AS 
    BEGIN
        SET NOCOUNT ON;
        IF EXISTS
        (
            SELECT 1 FROM core.Cliente WHERE Correo = @Correo 
        )
            SELECT CAST(1 AS BIT);
        ELSE
            SELECT CAST(0 AS BIT)
    END
GO
 
CREATE OR ALTER PROCEDURE core.Cliente_spObtenerPorEstadoConstanteId
(
    @EstadoConstante INT
)
AS 
    BEGIN
        SET NOCOUNT ON;
        SELECT
            C.ClienteId,
            C.ClienteUsuarioId,
            C.ClienteTipoDocumentoId,
            C.Paterno,
            C.Materno,
            C.Nombres,
            C.NumeroDocumento,
            C.Correo,
            C.Telefono,
            C.Sexo,
            C.FechaNacimiento,
            C.Direccion,
            C.EstadoConstanteId
        FROM core.Cliente AS C
        INNER JOIN compartido.Constante AS CO 
            ON C.EstadoConstanteId = CO.ConstanteId
        INNER JOIN compartido.TipoDocumento AS TD
            ON C.ClienteTipoDocumentoId = TD.TipoDocumentoID
        WHERE C.EstadoConstanteId = @EstadoConstante 
            AND C.IsDeleted = 0
    END
GO
 
CREATE OR ALTER PROCEDURE core.Cliente_spExisteUsuarioVinculado
(
   @UsuarioId INT,
   @ExcludeClienteId INT = NULL -- �til para cuando est�s editando
)
AS 
    BEGIN
        SET NOCOUNT ON;

        IF EXISTS (
            SELECT 1 
            FROM core.Cliente 
            WHERE ClienteUsuarioId = @UsuarioId 
              AND (@ExcludeClienteId IS NULL OR ClienteId <> @ExcludeClienteId)
              AND IsDeleted = 0 -- Solo buscamos entre clientes activos
        )
            SELECT CAST(1 AS BIT); -- Retorna True
        ELSE
            SELECT CAST(0 AS BIT); -- Retorna False
    END
GO
 
CREATE OR ALTER PROCEDURE core.Cliente_spBuscarPorNombreCompleto
(
    @TerminoBusqueda NVARCHAR(150) -- "Paterno Materno Nombres"
)
AS 
    BEGIN
        SET NOCOUNT ON;

        -- Limpiamos el t�rmino y agregamos comodines para b�squeda parcial
        SET @TerminoBusqueda = '%' + TRIM(@TerminoBusqueda) + '%';
        SELECT 
            C.ClienteId,
            C.Paterno,
            C.Materno,
            C.Nombres,
            (C.Paterno + ' ' + C.Materno + ' ' + C.Nombres) AS NombreCompleto,
            C.NumeroDocumento,
            C.Correo,
            C.Telefono,
            C.IsDeleted,
            TD.Descripcion AS TipoDocumentoNombre
        FROM core.Cliente C
        INNER JOIN compartido.TipoDocumento TD ON C.ClienteTipoDocumentoId = TD.TipoDocumentoId
        WHERE (C.Paterno + ' ' + C.Materno + ' ' + C.Nombres) LIKE @TerminoBusqueda
          AND C.IsDeleted = 0 -- Solo clientes activos
        ORDER BY C.Paterno, C.Materno, C.Nombres;
    END
GO

/*
    ClienteId					INT,
    ClienteUsuarioId			INT, 
    ClienteTipoDocumentoId		INT,
    Paterno						NVARCHAR (50), 
    Materno						NVARCHAR (50), 
    Nombres						NVARCHAR (50), 
    NumeroDocumento				NVARCHAR (20),
    Correo						NVARCHAR (100),
    Telefono					NVARCHAR (15), 
    Sexo						NCHAR (1), 
    FechaNacimiento				DATE,
    Direccion					NVARCHAR (200),
    EstadoConstanteId			INT,
    -- Auditoria
    CreatedAt		DATETIME2(0),
    CreatedBy		INT,           
    UpdatedAt		DATETIME2(0), 
    UpdatedBy		INT, 
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
ObtenerPorNumeroDocumento
ExisteCorreo
ObtenerPorEstadoConstanteId
ExisteUsuarioVinculado
BuscarPorNombreCompleto
*/