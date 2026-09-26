USE [$(DatabaseName)];
GO

SET ANSI_NULLS ON;
SET QUOTED_IDENTIFIER ON;
SET ANSI_PADDING ON;
SET ANSI_WARNINGS ON;
SET ARITHABORT ON;
SET CONCAT_NULL_YIELDS_NULL ON;
SET NUMERIC_ROUNDABORT OFF;
GO

IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE object_id = OBJECT_ID(N'dbo.DataSource') AND name = N'UX_DataSource_SourceName')
    CREATE UNIQUE INDEX UX_DataSource_SourceName ON dbo.DataSource(SourceName);
GO

IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE object_id = OBJECT_ID(N'dbo.Race') AND name = N'IX_Race_Date')
    CREATE INDEX IX_Race_Date ON dbo.Race(RaceDate);
GO

IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE object_id = OBJECT_ID(N'dbo.Race') AND name = N'IX_Race_CourseDate')
    CREATE INDEX IX_Race_CourseDate ON dbo.Race(RacecourseId, RaceDate);
GO

IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE object_id = OBJECT_ID(N'dbo.Horse') AND name = N'IX_Horse_NameBirthYear')
    CREATE INDEX IX_Horse_NameBirthYear ON dbo.Horse(HorseName, BirthYear);
GO

IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE object_id = OBJECT_ID(N'dbo.RaceEntry') AND name = N'UX_RaceEntry_RaceHorseNumber')
    CREATE UNIQUE INDEX UX_RaceEntry_RaceHorseNumber
        ON dbo.RaceEntry(RaceId, HorseNumber)
        WHERE HorseNumber IS NOT NULL;
GO

IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE object_id = OBJECT_ID(N'dbo.RaceEntry') AND name = N'IX_RaceEntry_Horse')
    CREATE INDEX IX_RaceEntry_Horse ON dbo.RaceEntry(HorseId, RaceId);
GO

IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE object_id = OBJECT_ID(N'dbo.RaceOdds') AND name = N'UX_RaceOdds_Final')
    CREATE UNIQUE INDEX UX_RaceOdds_Final
        ON dbo.RaceOdds(RaceId, BetTypeCode, SelectionKey, DataSourceId)
        WHERE IsFinal = 1;
GO

IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE object_id = OBJECT_ID(N'dbo.RaceOdds') AND name = N'IX_RaceOdds_FinalLookup')
    CREATE INDEX IX_RaceOdds_FinalLookup
        ON dbo.RaceOdds(RaceId, BetTypeCode, IsFinal)
        INCLUDE (SelectionKey, OddsMin, OddsMax, Popularity, DataSourceId);
GO

IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE object_id = OBJECT_ID(N'dbo.RawFetch') AND name = N'IX_RawFetch_SourceTime')
    CREATE INDEX IX_RawFetch_SourceTime ON dbo.RawFetch(DataSourceId, RetrievedAt);
GO
