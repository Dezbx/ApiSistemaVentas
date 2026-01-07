IF NOT EXISTS (SELECT * FROM sys.types WHERE name = 'IdListType' AND schema_id = SCHEMA_ID('compartido'))
BEGIN
    CREATE TYPE compartido.IdListType AS TABLE 
    (
        Id INT
    );
END
GO