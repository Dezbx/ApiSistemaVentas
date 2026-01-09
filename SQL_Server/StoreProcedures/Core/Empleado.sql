USE SistemaVentasBD
GO

CREATE OR ALTER PROCEDURE core.Empleado_spObtenerPorId
(
    @EmpleadoId INT
)
AS
    BEGIN
        SET NOCOUNT ON;
        SELECT 
        E.EmpleadoId,				
        U.NombreUsuario,	
        S.Descripcion AS Sede,			
        TD.Descripcion AS TipoDocumento,
        C.Descripcion AS Cargo,		
        E.Paterno,				
        E.Materno,				
        E.Nombres,				
        E.NumeroDocumento,		
        E.Correo,				
        E.Telefono,				
        E.Sexo,				
        E.FechaNacimiento,		
        E.Direccion,				
        CO.Descripcion AS Estado		
        FROM core.Empleado AS E
        INNER JOIN seguridad.Usuario AS U ON E.EmpleadoUsuarioId = U.UsuarioId
        INNER JOIN core.Sede AS S ON E.EmpleadoSedeId = S.SedeId
        INNER JOIN compartido.TipoDocumento AS TD ON E.EmpleadoTipoDocumentoId = TD.TipoDocumentoId
        INNER JOIN Cargo AS C ON E.EmpleadoCargoId = C.CargoId
        INNER JOIN compartido.Constante AS CO ON E.EstadoConstanteId = CO.ConstanteId
            WHERE EmpleadoId = @EmpleadoId
                AND E.IsDeleted = 0
    END
GO

CREATE OR ALTER PROCEDURE core.Empleado_spObtenerTodos 
AS
    BEGIN
        SET NOCOUNT ON;
        SELECT 
        E.EmpleadoId,				
        U.NombreUsuario,	
        S.Descripcion AS Sede,			
        TD.Descripcion AS TipoDocumento,
        C.Descripcion AS Cargo,		
        E.Paterno,				
        E.Materno,				
        E.Nombres,				
        E.NumeroDocumento,		
        E.Correo,				
        E.Telefono,				
        E.Sexo,				
        E.FechaNacimiento,		
        E.Direccion,				
        CO.Descripcion AS Estado		
        FROM core.Empleado AS E
        INNER JOIN seguridad.Usuario AS U ON E.EmpleadoUsuarioId = U.UsuarioId
        INNER JOIN core.Sede AS S ON E.EmpleadoSedeId = S.SedeId
        INNER JOIN compartido.TipoDocumento AS TD ON E.EmpleadoTipoDocumentoId = TD.TipoDocumentoId
        INNER JOIN Cargo AS C ON E.EmpleadoCargoId = C.CargoId
        INNER JOIN compartido.Constante AS CO ON E.EstadoConstanteId = CO.ConstanteId
    END
GO

CREATE OR ALTER PROCEDURE core.Empleado_spAgregar 
(
	@EmpleadoUsuarioId			INT,
	@EmpleadoSedeId				INT,
	@EmpleadoTipoDocumentoId	INT,
	@EmpleadoCargoId			INT,
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
	@CreatedAt		DATETIME2 (0),
	@CreatedBy		INT, 
	@IsDeleted		BIT   
)
AS
    BEGIN
        SET NOCOUNT ON;
        INSERT INTO core.Empleado
        (
            EmpleadoUsuarioId,			
            EmpleadoSedeId,				
            EmpleadoTipoDocumentoId,	
            EmpleadoCargoId,			
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
            -- Auditoria
            CreatedAt,		
            CreatedBy,		
            IsDeleted		
        )
        VALUES
        (
            @EmpleadoUsuarioId,			
            @EmpleadoSedeId,				
            @EmpleadoTipoDocumentoId,	
            @EmpleadoCargoId,			
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
            -- Auditoria
            @CreatedAt,		
            @CreatedBy,		
            @IsDeleted		
        )

        SELECT CAST(SCOPE_IDENTITY() AS INT);
    END
GO

CREATE OR ALTER PROCEDURE core.Empleado_spActualizar 
(
    @EmpleadoId					INT,
    @EmpleadoSedeId				INT,
    @EmpleadoCargoId			INT,
    @Paterno					NVARCHAR (50),
    @Materno					NVARCHAR (50),
    @Nombres					NVARCHAR (50),
    @Correo						NVARCHAR (100), 
    @Telefono					NVARCHAR (15),
    @Sexo						NCHAR (1),
    @Direccion					NVARCHAR (200),
    @EstadoConstanteId			INT,
    -- Auditoria
    @UpdatedAt		DATETIME2 (0), 
    @UpdatedBy		INT 
)
AS
    BEGIN
        SET NOCOUNT ON;
        UPDATE core.Empleado
        SET 
            EmpleadoSedeId				= @EmpleadoSedeId,				
            EmpleadoCargoId				= @EmpleadoCargoId,			
            Paterno						= @Paterno,					
            Materno						= @Materno,					
            Nombres						= @Nombres,					
            Correo						= @Correo,					
            Telefono					= @Telefono,					
            Sexo						= @Sexo,						
            Direccion					= @Direccion,					
            EstadoConstanteId			= @EstadoConstanteId,			
            -- Auditoria
            UpdatedAt					= @UpdatedAt, 
            UpdatedBy					= @UpdatedBy 
        WHERE EmpleadoId = @EmpleadoId
        AND IsDeleted = 0;
    END
GO

CREATE OR ALTER PROCEDURE core.Empleado_spExistePorId
(
    @EmpleadoId INT
)
AS
    BEGIN
        SET NOCOUNT ON;
        IF EXISTS 
        (
            SELECT 1 
            FROM core.Empleado 
            WHERE EmpleadoId = @EmpleadoId  
                AND IsDeleted = 0
        )
            SELECT CAST(1 AS BIT);
        ELSE
            SELECT CAST(0 AS BIT)
    END
GO

CREATE OR ALTER PROCEDURE core.Empleado_spContarTotal 
AS
    BEGIN
        SET NOCOUNT ON;
        SELECT 
        COUNT (EmpleadoId) AS TotalEmpleados
        FROM core.Empleado
        WHERE IsDeleted = 0
    END 
GO

IF NOT EXISTS (SELECT * FROM sys.types WHERE name = 'EmpleadoCreateType' AND schema_id = SCHEMA_ID('core'))
BEGIN
    CREATE TYPE core.EmpleadoCreateType AS TABLE
    (
        EmpleadoUsuarioId			INT,
        EmpleadoSedeId				INT,
        EmpleadoTipoDocumentoId		INT,
        EmpleadoCargoId				INT,
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
        CreatedAt		DATETIME2 (0),
        CreatedBy		INT, 
        IsDeleted		BIT   
    )
END
GO

IF NOT EXISTS (SELECT * FROM sys.types WHERE name = 'EmpleadoUpdateType' AND schema_id = SCHEMA_ID('core'))
BEGIN
    CREATE TYPE core.EmpleadoUpdateType AS TABLE
    (
        EmpleadoId					INT,
        EmpleadoSedeId				INT,
        EmpleadoCargoId				INT,
        Paterno						NVARCHAR (50),
        Materno						NVARCHAR (50),
        Nombres						NVARCHAR (50),
        Correo						NVARCHAR (100), 
        Telefono					NVARCHAR (15),
        Sexo						NCHAR (1),
        Direccion					NVARCHAR (200),
        EstadoConstanteId			INT,
        -- Auditoria
        UpdatedAt		DATETIME2 (0), 
        UpdatedBy		INT 
    )
    END
GO

CREATE OR ALTER PROCEDURE core.Empleado_spAgregarVarios
(
    @Empleados core.EmpleadoCreateType READONLY
)
AS
    BEGIN
        SET NOCOUNT ON;
        INSERT INTO core.Empleado
        (
            EmpleadoUsuarioId,
            EmpleadoSedeId,
            EmpleadoTipoDocumentoId,
            EmpleadoCargoId,
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
            -- Auditoria
            CreatedAt,
            CreatedBy,
            IsDeleted
        )
        SELECT
            EmpleadoUsuarioId,
            EmpleadoSedeId,
            EmpleadoTipoDocumentoId,
            EmpleadoCargoId,
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
            -- Auditoria
            CreatedAt,
            CreatedBy,
            IsDeleted
        FROM @Empleados;    
    END
GO

CREATE OR ALTER PROCEDURE core.Empleado_spActualizarVarios
(
    @Empleados core.EmpleadoUpdateType READONLY
)
AS
    BEGIN
        SET NOCOUNT ON;
        UPDATE E
        SET 
            E.EmpleadoSedeId				= Lista.EmpleadoSedeId,                
            E.EmpleadoCargoId				= Lista.EmpleadoCargoId,   
            E.Paterno						= Lista.Paterno,                    
            E.Materno						= Lista.Materno,                    
            E.Nombres						= Lista.Nombres,                    
            E.Correo						= Lista.Correo,                    
            E.Telefono						= Lista.Telefono,                    
            E.Sexo							= Lista.Sexo,
            E.Direccion						= Lista.Direccion,                    
            E.EstadoConstanteId				= Lista.EstadoConstanteId,                
            -- Auditoria
            E.UpdatedAt						= Lista.UpdatedAt, 
            E.UpdatedBy						= Lista.UpdatedBy 
        FROM core.Empleado AS E
        INNER JOIN @Empleados AS Lista
            ON E.EmpleadoId = Lista.EmpleadoId
        WHERE E.IsDeleted = 0;
    END
GO

CREATE OR ALTER PROCEDURE core.Empleado_spDesactivarVarios
(
    @EmpleadoIds compartido.IdListType READONLY
)
AS
    BEGIN
        SET NOCOUNT ON;

        UPDATE E 	
        SET E.IsDeleted = 1
        FROM core.Empleado AS E 
        INNER JOIN @EmpleadoIds AS Lista
            ON E.EmpleadoId = Lista.Id
        WHERE E.IsDeleted = 0

        SELECT @@ROWCOUNT;

    END
GO

CREATE OR ALTER PROCEDURE core.Empleado_spActivarVarios
(
    @EmpleadoIds compartido.IdListType READONLY
)
AS
    BEGIN
        SET NOCOUNT ON;

        UPDATE E 	
        SET E.IsDeleted = 0
        FROM core.Empleado AS E 
        INNER JOIN @EmpleadoIds AS Lista
            ON E.EmpleadoId = Lista.Id
        WHERE E.IsDeleted = 1

        SELECT @@ROWCOUNT;

    END
GO

CREATE OR ALTER PROCEDURE core.Empleado_spObtenerEliminados
AS
BEGIN
    SET NOCOUNT ON;
     SELECT 
        E.EmpleadoId,				
        U.NombreUsuario,	
        S.Descripcion AS Sede,			
        TD.Descripcion AS TipoDocumento,
        C.Descripcion AS Cargo,		
        E.Paterno,				
        E.Materno,				
        E.Nombres,				
        E.NumeroDocumento,		
        E.Correo,				
        E.Telefono,				
        E.Sexo,				
        E.FechaNacimiento,		
        E.Direccion,				
        CO.Descripcion AS Estado		
        FROM core.Empleado AS E
        INNER JOIN seguridad.Usuario AS U ON E.EmpleadoUsuarioId = U.UsuarioId
        INNER JOIN core.Sede AS S ON E.EmpleadoSedeId = S.SedeId
        INNER JOIN compartido.TipoDocumento AS TD ON E.EmpleadoTipoDocumentoId = TD.TipoDocumentoId
        INNER JOIN Cargo AS C ON E.EmpleadoCargoId = C.CargoId
        INNER JOIN compartido.Constante AS CO ON E.EstadoConstanteId = CO.ConstanteId
    WHERE E.IsDeleted = 1
END
GO

CREATE OR ALTER PROCEDURE core.Empleado_spEliminarLogico
(
    @EmpleadoId INT,
    @UpdatedAt DATETIME2 (0),
    @UpdatedBy INT
)
AS
BEGIN
    SET NOCOUNT ON;
    UPDATE core.Empleado
    SET 
        IsDeleted = 1,
        UpdatedAt = @UpdatedAt,     
        UpdatedBy = @UpdatedBy  
    WHERE EmpleadoId = @EmpleadoId
END
GO

CREATE OR ALTER PROCEDURE core.Empleado_spObtenerPorSedeId
(
    @EmpleadoSedeId INT
)
AS
BEGIN
    SET NOCOUNT ON;
    SELECT 
        E.EmpleadoId,				
        U.NombreUsuario,	
        S.Descripcion AS Sede,			
        TD.Descripcion AS TipoDocumento,
        C.Descripcion AS Cargo,		
        E.Paterno,				
        E.Materno,				
        E.Nombres,				
        E.NumeroDocumento,		
        E.Correo,				
        E.Telefono,				
        E.Sexo,				
        E.FechaNacimiento,		
        E.Direccion,				
        CO.Descripcion AS Estado		
        FROM core.Empleado AS E
        INNER JOIN seguridad.Usuario AS U ON E.EmpleadoUsuarioId = U.UsuarioId
        INNER JOIN core.Sede AS S ON E.EmpleadoSedeId = S.SedeId
        INNER JOIN compartido.TipoDocumento AS TD ON E.EmpleadoTipoDocumentoId = TD.TipoDocumentoId
        INNER JOIN Cargo AS C ON E.EmpleadoCargoId = C.CargoId
        INNER JOIN compartido.Constante AS CO ON E.EstadoConstanteId = CO.ConstanteId
        WHERE EmpleadoSedeId = @EmpleadoSedeId 
            AND E.IsDeleted = 0
END
GO

CREATE OR ALTER PROCEDURE core.Empleado_spObtenerPorNumeroDocumento
(
    @NumeroDocumento NVARCHAR (20)
)
AS
BEGIN
    SET NOCOUNT ON;
    SELECT 
        E.EmpleadoId,				
        U.NombreUsuario,	
        S.Descripcion AS Sede,			
        TD.Descripcion AS TipoDocumento,
        C.Descripcion AS Cargo,		
        E.Paterno,				
        E.Materno,				
        E.Nombres,				
        E.NumeroDocumento,		
        E.Correo,				
        E.Telefono,				
        E.Sexo,				
        E.FechaNacimiento,		
        E.Direccion,				
        CO.Descripcion AS Estado		
        FROM core.Empleado AS E
        INNER JOIN seguridad.Usuario AS U ON E.EmpleadoUsuarioId = U.UsuarioId
        INNER JOIN core.Sede AS S ON E.EmpleadoSedeId = S.SedeId
        INNER JOIN compartido.TipoDocumento AS TD ON E.EmpleadoTipoDocumentoId = TD.TipoDocumentoId
        INNER JOIN Cargo AS C ON E.EmpleadoCargoId = C.CargoId
        INNER JOIN compartido.Constante AS CO ON E.EstadoConstanteId = CO.ConstanteId
WHERE NumeroDocumento = @NumeroDocumento AND E.IsDeleted = 0
END
GO

CREATE OR ALTER PROCEDURE core.Empleado_spExisteUsuarioAsignadO
(
    @EmpleadoUsuarioId INT
)
AS
    BEGIN   
        SET NOCOUNT ON;
        IF EXISTS 
        (
            SELECT 1 
            FROM core.Empleado 
            WHERE EmpleadoUsuarioId = @EmpleadoUsuarioId  
                AND IsDeleted = 0
        )
            SELECT CAST(1 AS BIT);
        ELSE
            SELECT CAST(0 AS BIT)
    END
GO

CREATE OR ALTER PROCEDURE core.Empleado_spObtenerPorCargoId
(
    @EmpleadoCargoId INT
)
AS
BEGIN
    SET NOCOUNT ON;
    SELECT 
        E.EmpleadoId,				
        U.NombreUsuario,	
        S.Descripcion AS Sede,			
        TD.Descripcion AS TipoDocumento,
        C.Descripcion AS Cargo,		
        E.Paterno,				
        E.Materno,				
        E.Nombres,				
        E.NumeroDocumento,		
        E.Correo,				
        E.Telefono,				
        E.Sexo,				
        E.FechaNacimiento,		
        E.Direccion,				
        CO.Descripcion AS Estado		
        FROM core.Empleado AS E
        INNER JOIN seguridad.Usuario AS U ON E.EmpleadoUsuarioId = U.UsuarioId
        INNER JOIN core.Sede AS S ON E.EmpleadoSedeId = S.SedeId
        INNER JOIN compartido.TipoDocumento AS TD ON E.EmpleadoTipoDocumentoId = TD.TipoDocumentoId
        INNER JOIN Cargo AS C ON E.EmpleadoCargoId = C.CargoId
        INNER JOIN compartido.Constante AS CO ON E.EstadoConstanteId = CO.ConstanteId
WHERE EmpleadoCargoId = @EmpleadoCargoId AND E.IsDeleted = 0
END
GO
CREATE OR ALTER PROCEDURE core.Empleado_spExisteCorreo
(
    @Correo NVARCHAR (100)
)
AS
    BEGIN   
        SET NOCOUNT ON;
        IF EXISTS 
        (
            SELECT 1 
            FROM core.Empleado 
            WHERE Correo = @Correo  
                AND IsDeleted = 0
        )
            SELECT CAST(1 AS BIT);
        ELSE
            SELECT CAST(0 AS BIT)
    END
GO

/*
    EmpleadoId					INT,
	EmpleadoUsuarioId			INT,
	EmpleadoSedeId				INT,
	EmpleadoTipoDocumentoId		INT,
	EmpleadoCargoId				INT,
	Paterno						NVARCHAR (50),
	Materno						NVARCHAR (50),
	Nombres						NVARCHAR (50),
	NumeroDocumento				NVARCHAR (20),
	Correo						NVARCHAR (100), 
	Telefono					NVARCHAR (15) ,
	Sexo						NCHAR (1)
	FechaNacimiento				DATE,
	Direccion					NVARCHAR (200),
	EstadoConstanteId			INT,

	-- Auditoria
	CreatedAt		DATETIME2(0),
	CreatedBy		INT, 
	UpdatedAt		DATETIME2(0), 
	UpdatedBy		INT , 
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
ObtenerPorSedeId
ObtenerPorNumeroDocumento
ExisteUsuarioAsignadO
ObtenerPorCargoId
ExisteCorreo
*/
