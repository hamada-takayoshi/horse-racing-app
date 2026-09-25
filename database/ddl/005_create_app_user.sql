:setvar DatabaseName "HorseRacing"
:setvar AppLogin "HorseRacingAppUser"
:setvar AppPassword "CHANGE_ME_APP_PASSWORD"

USE [master];
GO

IF NOT EXISTS (SELECT 1 FROM sys.server_principals WHERE name = N'$(AppLogin)')
BEGIN
    DECLARE @CreateLogin nvarchar(max) =
        N'CREATE LOGIN [' + REPLACE('$(AppLogin)', ']', ']]') +
        N'] WITH PASSWORD = N''' + REPLACE('$(AppPassword)', '''', '''''') +
        N''', CHECK_POLICY = ON, CHECK_EXPIRATION = OFF;';
    EXEC(@CreateLogin);
END;
GO

USE [$(DatabaseName)];
GO

IF NOT EXISTS (SELECT 1 FROM sys.database_principals WHERE name = N'$(AppLogin)')
BEGIN
    DECLARE @CreateUser nvarchar(max) =
        N'CREATE USER [' + REPLACE('$(AppLogin)', ']', ']]') +
        N'] FOR LOGIN [' + REPLACE('$(AppLogin)', ']', ']]') + N'];';
    EXEC(@CreateUser);
END;
GO

ALTER ROLE db_datareader ADD MEMBER [$(AppLogin)];
ALTER ROLE db_datawriter ADD MEMBER [$(AppLogin)];
GO
