:setvar DatabaseName "HorseRacing"

IF DB_ID(N'$(DatabaseName)') IS NULL
BEGIN
    EXEC(N'CREATE DATABASE [' + REPLACE('$(DatabaseName)', ']', ']]') + N']');
END;
GO
