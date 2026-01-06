USE SistemaVentasBD
GO

CREATE OR ALTER PROCEDURE auditoria.AuditLog_spObtenerPorId
(
   @AuditLogId	BIGINT 
)
AS
    BEGIN
        SET NOCOUNT ON;
        SELECT
        AL.AuditLogId,
        AL.TableName, 
        AL.RecordId,  
        AL.Action,    
        AL.OldValues, 
        AL.NewValues, 
        AL.ChangedAt, 
        AL.ChangedBy, 
        AL.IpAddress 
        FROM auditoria.AuditLog AS AL
        WHERE AL.AuditLogId = @AuditLogId 
    END
GO

CREATE OR ALTER PROCEDURE auditoria.AuditLog_spObtenerTodos
AS
    BEGIN
        SET NOCOUNT ON;
        SELECT
        AL.AuditLogId,
        AL.TableName, 
        AL.RecordId,  
        AL.Action,    
        AL.OldValues, 
        AL.NewValues, 
        AL.ChangedAt, 
        AL.ChangedBy, 
        AL.IpAddress 
        FROM auditoria.AuditLog AS AL
    END
GO

CREATE OR ALTER PROCEDURE auditoria.AuditLog_spAgregar
(
    @TableName   SYSNAME, 
    @RecordId    VARCHAR(50),  
    @Action      VARCHAR(10),  
    @OldValues   NVARCHAR(MAX),
    @NewValues   NVARCHAR(MAX),
    @ChangedAt   DATETIME2(0), 
    @ChangedBy   INT,          
    @IpAddress   VARCHAR(45)  
)
AS
    BEGIN
        SET NOCOUNT ON;
        INSERT INTO auditoria.AuditLog (TableName, RecordId, Action, OldValues, NewValues, 
        ChangedAt, ChangedBy, IpAddress)
        VALUES (@TableName, @RecordId, @Action, @OldValues, @NewValues, 
        @ChangedAt, @ChangedBy, @IpAddress)

        SELECT CAST(SCOPE_IDENTITY() AS INT);
    END
GO

CREATE OR ALTER PROCEDURE auditoria.AuditLog_spActualizar
(
    @AuditLogId  BIGINT,
    @TableName   SYSNAME, 
    @RecordId    VARCHAR(50),  
    @Action      VARCHAR(10),  
    @OldValues   NVARCHAR(MAX),
    @NewValues   NVARCHAR(MAX),
    @ChangedAt   DATETIME2(0), 
    @ChangedBy   INT,          
    @IpAddress   VARCHAR(45)
)
AS
BEGIN
    SET NOCOUNT ON;
    -- Opción A: Lanzar un error explícito
    RAISERROR ('Los registros de auditoría son inmutables y no pueden ser actualizados.', 16, 1);
    
    -- Opción B: Simplemente no hacer nada y retornar falso
    -- SELECT CAST(0 AS BIT); 
END
GO

CREATE OR ALTER PROCEDURE auditoria.AuditLog_spExistePorId
(
    @AuditLogId BIGINT
)
AS
    BEGIN
        SET NOCOUNT ON;
        IF EXISTS 
        (
            SELECT 1
            FROM auditoria.AuditLog AS AL
            WHERE AL.AuditLogId = @AuditLogId
        )
            SELECT CAST (1 AS BIT)
        ELSE
            SELECT CAST (0 AS BIT)
    END
GO

CREATE OR ALTER PROCEDURE auditoria.AuditLog_spContarTotal
(
    @AuditLogId BIGINT
)
AS
    BEGIN
        SET NOCOUNT ON;
        SELECT
        COUNT (AL.AuditLogId) AS TotalLogs
        FROM auditoria.AuditLog AS AL
    END
GO

-- Necesario para la creacion de varios registros
-- Creamos un tipo de tabla para el esquema compartido
IF NOT EXISTS (SELECT * FROM sys.types WHERE name = 'AuditLogType' AND schema_id = SCHEMA_ID('auditoria'))
BEGIN
    CREATE TYPE auditoria.AuditLogType AS TABLE
    (
        AuditLogId	BIGINT,
        TableName   SYSNAME,  
        RecordId    VARCHAR(50), 
        Action      VARCHAR(10),  
        OldValues   NVARCHAR(MAX),
        NewValues   NVARCHAR(MAX), 
        ChangedAt   DATETIME2(0),
        ChangedBy   INT,        
        IpAddress   VARCHAR(45)
    );
END
GO

CREATE OR ALTER PROCEDURE auditoria.AuditLog_spAgregarVarios
(
    @AuditLogType auditoria.AuditLogType READONLY
)
AS
    BEGIN
        SET NOCOUNT ON;
        SET NOCOUNT ON;
		INSERT INTO auditoria.AuditLog (TableName, RecordId, Action, OldValues, NewValues, 
        ChangedAt, ChangedBy, IpAddress)
		SELECT TableName, RecordId, Action, OldValues, NewValues, 
        ChangedAt, ChangedBy, IpAddress
		FROM @AuditLogType

		-- Retorna la cantidad de registros insertados
		SELECT @@ROWCOUNT;
    END
GO

CREATE OR ALTER PROCEDURE auditoria.AuditLog_spActualizarVarios
(
    @AuditLogType auditoria.AuditLogType READONLY
   
)
AS
    BEGIN
        SET NOCOUNT ON;
        RAISERROR ('Los registros de auditoría son inmutables y no pueden ser actualizados.', 16, 1);

    END
GO

CREATE OR ALTER PROCEDURE auditoria.AuditLog_spDesactivarVarios
(
    @AuditLogType auditoria.AuditLogType READONLY
)
AS
    BEGIN
        SET NOCOUNT ON;
        RAISERROR ('Los registros de auditoría son inmutables y no pueden ser actualizados.', 16, 1);

    END
GO

CREATE OR ALTER PROCEDURE auditoria.AuditLog_spActivarVarios
(
    @AuditLogType auditoria.AuditLogType READONLY

)
AS
    BEGIN
        SET NOCOUNT ON;
        RAISERROR ('Los registros de auditoría son inmutables y no pueden ser actualizados.', 16, 1);
    END
GO

CREATE OR ALTER PROCEDURE auditoria.AuditLog_spObtenerEliminados
AS
    BEGIN
        SET NOCOUNT ON;
        RAISERROR ('Los registros de auditoría son inmutables y no pueden ser actualizados.', 16, 1);
    END
GO

CREATE OR ALTER PROCEDURE auditoria.AuditLog_spEliminarLogico
AS
    BEGIN
        SET NOCOUNT ON;
        RAISERROR ('Los registros de auditoría son inmutables y no pueden ser actualizados.', 16, 1);
    END
GO

/*
    AuditLogId	BIGINT
    TableName   SYSNAME  
    RecordId    VARCHAR(50)  
    Action      VARCHAR(10)  
    OldValues   NVARCHAR(MAX) 
    NewValues   NVARCHAR(MAX) 
    ChangedAt   DATETIME2(0) 
    ChangedBy   INT          
    IpAddress   VARCHAR(45)  

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
ObtenerEliminados
*/