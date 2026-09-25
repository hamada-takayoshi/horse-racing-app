IF DB_ID(N'$(DatabaseName)') IS NULL
BEGIN
    DECLARE @CreateDatabase nvarchar(max) =
        N'CREATE DATABASE [' + REPLACE('$(DatabaseName)', ']', ']]') + N']';
    EXEC(@CreateDatabase);
END;
GO
