USE [$(DatabaseName)];
GO

IF OBJECT_ID(N'dbo.DataSource', N'U') IS NULL
BEGIN
    CREATE TABLE dbo.DataSource (
        DataSourceId INT IDENTITY(1,1) NOT NULL,
        SourceName NVARCHAR(100) NOT NULL,
        SourceTypeCode VARCHAR(20) NOT NULL,
        Priority SMALLINT NOT NULL,
        AuthorityLevelCode VARCHAR(20) NOT NULL,
        BaseUrl NVARCHAR(500) NULL,
        IsPaid BIT NOT NULL,
        Description NVARCHAR(500) NULL,
        CreatedAt DATETIME2 NOT NULL CONSTRAINT DF_DataSource_CreatedAt DEFAULT SYSUTCDATETIME(),
        UpdatedAt DATETIME2 NOT NULL CONSTRAINT DF_DataSource_UpdatedAt DEFAULT SYSUTCDATETIME()
    );
END;
GO

IF OBJECT_ID(N'dbo.RacingCategory', N'U') IS NULL
BEGIN
    CREATE TABLE dbo.RacingCategory (
        RacingCategoryCode VARCHAR(20) NOT NULL,
        RacingCategoryName NVARCHAR(50) NOT NULL,
        SortOrder SMALLINT NOT NULL,
        IsActive BIT NOT NULL
    );
END;
GO

IF OBJECT_ID(N'dbo.Organizer', N'U') IS NULL
BEGIN
    CREATE TABLE dbo.Organizer (
        OrganizerId INT IDENTITY(1,1) NOT NULL,
        OrganizerCode VARCHAR(30) NOT NULL,
        OrganizerName NVARCHAR(100) NOT NULL,
        CreatedAt DATETIME2 NOT NULL CONSTRAINT DF_Organizer_CreatedAt DEFAULT SYSUTCDATETIME(),
        UpdatedAt DATETIME2 NOT NULL CONSTRAINT DF_Organizer_UpdatedAt DEFAULT SYSUTCDATETIME()
    );
END;
GO

IF OBJECT_ID(N'dbo.Racecourse', N'U') IS NULL
BEGIN
    CREATE TABLE dbo.Racecourse (
        RacecourseId INT IDENTITY(1,1) NOT NULL,
        RacingCategoryCode VARCHAR(20) NOT NULL,
        OrganizerId INT NOT NULL,
        RacecourseCode VARCHAR(20) NOT NULL,
        RacecourseName NVARCHAR(100) NOT NULL,
        CountryCode CHAR(2) NOT NULL,
        CreatedAt DATETIME2 NOT NULL CONSTRAINT DF_Racecourse_CreatedAt DEFAULT SYSUTCDATETIME(),
        UpdatedAt DATETIME2 NOT NULL CONSTRAINT DF_Racecourse_UpdatedAt DEFAULT SYSUTCDATETIME()
    );
END;
GO

IF OBJECT_ID(N'dbo.BetType', N'U') IS NULL
BEGIN
    CREATE TABLE dbo.BetType (
        BetTypeCode VARCHAR(30) NOT NULL,
        BetTypeName NVARCHAR(100) NOT NULL,
        SelectionTypeCode VARCHAR(10) NOT NULL,
        SortOrder SMALLINT NOT NULL,
        IsActive BIT NOT NULL
    );
END;
GO

IF OBJECT_ID(N'dbo.RaceGrade', N'U') IS NULL
BEGIN
    CREATE TABLE dbo.RaceGrade (
        RaceGradeCode VARCHAR(30) NOT NULL,
        RaceGradeName NVARCHAR(100) NOT NULL,
        SortOrder SMALLINT NOT NULL,
        IsActive BIT NOT NULL
    );
END;
GO

IF OBJECT_ID(N'dbo.Weather', N'U') IS NULL
BEGIN
    CREATE TABLE dbo.Weather (
        WeatherCode VARCHAR(30) NOT NULL,
        WeatherName NVARCHAR(100) NOT NULL,
        SortOrder SMALLINT NOT NULL,
        IsActive BIT NOT NULL
    );
END;
GO

IF OBJECT_ID(N'dbo.TrackCondition', N'U') IS NULL
BEGIN
    CREATE TABLE dbo.TrackCondition (
        TrackConditionCode VARCHAR(30) NOT NULL,
        TrackConditionName NVARCHAR(100) NOT NULL,
        SortOrder SMALLINT NOT NULL,
        IsActive BIT NOT NULL
    );
END;
GO

IF OBJECT_ID(N'dbo.RaceClass', N'U') IS NULL
BEGIN
    CREATE TABLE dbo.RaceClass (
        RaceClassCode VARCHAR(30) NOT NULL,
        RaceClassName NVARCHAR(100) NOT NULL,
        SortOrder SMALLINT NOT NULL,
        IsActive BIT NOT NULL
    );
END;
GO

IF OBJECT_ID(N'dbo.AgeCondition', N'U') IS NULL
BEGIN
    CREATE TABLE dbo.AgeCondition (
        AgeConditionCode VARCHAR(30) NOT NULL,
        AgeConditionName NVARCHAR(100) NOT NULL,
        SortOrder SMALLINT NOT NULL,
        IsActive BIT NOT NULL
    );
END;
GO

IF OBJECT_ID(N'dbo.SexCondition', N'U') IS NULL
BEGIN
    CREATE TABLE dbo.SexCondition (
        SexConditionCode VARCHAR(30) NOT NULL,
        SexConditionName NVARCHAR(100) NOT NULL,
        SortOrder SMALLINT NOT NULL,
        IsActive BIT NOT NULL
    );
END;
GO

IF OBJECT_ID(N'dbo.WeightCondition', N'U') IS NULL
BEGIN
    CREATE TABLE dbo.WeightCondition (
        WeightConditionCode VARCHAR(30) NOT NULL,
        WeightConditionName NVARCHAR(100) NOT NULL,
        SortOrder SMALLINT NOT NULL,
        IsActive BIT NOT NULL
    );
END;
GO

IF OBJECT_ID(N'dbo.MetricType', N'U') IS NULL
BEGIN
    CREATE TABLE dbo.MetricType (
        MetricTypeCode VARCHAR(30) NOT NULL,
        MetricTypeName NVARCHAR(100) NOT NULL,
        SortOrder SMALLINT NOT NULL,
        IsActive BIT NOT NULL
    );
END;
GO

IF OBJECT_ID(N'dbo.EvaluationType', N'U') IS NULL
BEGIN
    CREATE TABLE dbo.EvaluationType (
        EvaluationTypeCode VARCHAR(30) NOT NULL,
        EvaluationTypeName NVARCHAR(100) NOT NULL,
        SortOrder SMALLINT NOT NULL,
        IsActive BIT NOT NULL
    );
END;
GO

IF OBJECT_ID(N'dbo.Unit', N'U') IS NULL
BEGIN
    CREATE TABLE dbo.Unit (
        UnitCode VARCHAR(30) NOT NULL,
        UnitName NVARCHAR(100) NOT NULL,
        SortOrder SMALLINT NOT NULL,
        IsActive BIT NOT NULL
    );
END;
GO

IF OBJECT_ID(N'dbo.DataType', N'U') IS NULL
BEGIN
    CREATE TABLE dbo.DataType (
        DataTypeCode VARCHAR(30) NOT NULL,
        DataTypeName NVARCHAR(100) NOT NULL,
        SortOrder SMALLINT NOT NULL,
        IsActive BIT NOT NULL
    );
END;
GO

IF OBJECT_ID(N'dbo.Race', N'U') IS NULL
BEGIN
    CREATE TABLE dbo.Race (
        RaceId BIGINT IDENTITY(1,1) NOT NULL,
        RaceDate DATE NOT NULL,
        RacecourseId INT NOT NULL,
        RaceNumber TINYINT NOT NULL,
        RaceName NVARCHAR(200) NOT NULL,
        StartTime TIME NULL,
        MeetingNumber TINYINT NULL,
        MeetingDay TINYINT NULL,
        MeetingLabel NVARCHAR(50) NULL,
        RaceTypeCode VARCHAR(10) NOT NULL,
        SurfaceTypeCode VARCHAR(10) NOT NULL,
        Distance INT NOT NULL,
        CourseDirectionCode VARCHAR(10) NULL,
        CourseDetail NVARCHAR(50) NULL,
        WeatherCode VARCHAR(30) NULL,
        WeatherText NVARCHAR(50) NULL,
        TrackConditionCode VARCHAR(30) NULL,
        TrackConditionText NVARCHAR(50) NULL,
        RaceClassCode VARCHAR(30) NULL,
        RaceClassText NVARCHAR(100) NULL,
        RaceGradeCode VARCHAR(30) NULL,
        AgeConditionCode VARCHAR(30) NULL,
        AgeConditionText NVARCHAR(100) NULL,
        SexConditionCode VARCHAR(30) NULL,
        SexConditionText NVARCHAR(100) NULL,
        WeightConditionCode VARCHAR(30) NULL,
        WeightConditionText NVARCHAR(100) NULL,
        NumberOfEntries TINYINT NULL,
        NumberOfStarters TINYINT NULL,
        CreatedAt DATETIME2 NOT NULL CONSTRAINT DF_Race_CreatedAt DEFAULT SYSUTCDATETIME(),
        UpdatedAt DATETIME2 NOT NULL CONSTRAINT DF_Race_UpdatedAt DEFAULT SYSUTCDATETIME()
    );
END;
GO

IF OBJECT_ID(N'dbo.Horse', N'U') IS NULL
BEGIN
    CREATE TABLE dbo.Horse (
        HorseId BIGINT IDENTITY(1,1) NOT NULL,
        HorseName NVARCHAR(100) NOT NULL,
        BirthDate DATE NULL,
        BirthYear SMALLINT NULL,
        SexCode VARCHAR(10) NULL,
        CountryCode CHAR(2) NULL,
        SireHorseId BIGINT NULL,
        DamHorseId BIGINT NULL,
        Breeder NVARCHAR(200) NULL,
        CurrentOwner NVARCHAR(200) NULL,
        CreatedAt DATETIME2 NOT NULL CONSTRAINT DF_Horse_CreatedAt DEFAULT SYSUTCDATETIME(),
        UpdatedAt DATETIME2 NOT NULL CONSTRAINT DF_Horse_UpdatedAt DEFAULT SYSUTCDATETIME()
    );
END;
GO

IF OBJECT_ID(N'dbo.Jockey', N'U') IS NULL
BEGIN
    CREATE TABLE dbo.Jockey (
        JockeyId INT IDENTITY(1,1) NOT NULL,
        JockeyName NVARCHAR(100) NOT NULL,
        BirthDate DATE NULL,
        CurrentAffiliation NVARCHAR(100) NULL,
        CreatedAt DATETIME2 NOT NULL CONSTRAINT DF_Jockey_CreatedAt DEFAULT SYSUTCDATETIME(),
        UpdatedAt DATETIME2 NOT NULL CONSTRAINT DF_Jockey_UpdatedAt DEFAULT SYSUTCDATETIME()
    );
END;
GO

IF OBJECT_ID(N'dbo.Trainer', N'U') IS NULL
BEGIN
    CREATE TABLE dbo.Trainer (
        TrainerId INT IDENTITY(1,1) NOT NULL,
        TrainerName NVARCHAR(100) NOT NULL,
        CurrentAffiliation NVARCHAR(100) NULL,
        CreatedAt DATETIME2 NOT NULL CONSTRAINT DF_Trainer_CreatedAt DEFAULT SYSUTCDATETIME(),
        UpdatedAt DATETIME2 NOT NULL CONSTRAINT DF_Trainer_UpdatedAt DEFAULT SYSUTCDATETIME()
    );
END;
GO

IF OBJECT_ID(N'dbo.RaceEntry', N'U') IS NULL
BEGIN
    CREATE TABLE dbo.RaceEntry (
        RaceEntryId BIGINT IDENTITY(1,1) NOT NULL,
        RaceId BIGINT NOT NULL,
        HorseId BIGINT NOT NULL,
        FrameNumber TINYINT NULL,
        HorseNumber TINYINT NULL,
        JockeyId INT NULL,
        TrainerId INT NULL,
        HorseAge TINYINT NULL,
        HorseSexCode VARCHAR(10) NULL,
        AssignedWeight DECIMAL(4,1) NULL,
        HorseWeight SMALLINT NULL,
        HorseWeightChange SMALLINT NULL,
        JockeyAllowanceMark NCHAR(1) NULL,
        JockeyAllowanceWeight DECIMAL(3,1) NULL,
        JockeyAffiliationAtRace NVARCHAR(100) NULL,
        TrainerAffiliationAtRace NVARCHAR(100) NULL,
        OwnerAtRace NVARCHAR(200) NULL,
        FinishPosition TINYINT NULL,
        FinishTimeText NVARCHAR(20) NULL,
        FinishTimeSeconds DECIMAL(8,3) NULL,
        FinishDifference NVARCHAR(30) NULL,
        Final3F DECIMAL(5,2) NULL,
        EntryStatusCode VARCHAR(20) NOT NULL,
        EntryStatusDetail NVARCHAR(200) NULL,
        ResultStatusCode VARCHAR(20) NULL,
        ResultStatusDetail NVARCHAR(200) NULL,
        CreatedAt DATETIME2 NOT NULL CONSTRAINT DF_RaceEntry_CreatedAt DEFAULT SYSUTCDATETIME(),
        UpdatedAt DATETIME2 NOT NULL CONSTRAINT DF_RaceEntry_UpdatedAt DEFAULT SYSUTCDATETIME()
    );
END;
GO

IF OBJECT_ID(N'dbo.RaceCorner', N'U') IS NULL
BEGIN
    CREATE TABLE dbo.RaceCorner (
        RaceCornerId BIGINT IDENTITY(1,1) NOT NULL,
        RaceEntryId BIGINT NOT NULL,
        CornerNumber TINYINT NOT NULL,
        Position TINYINT NULL,
        CreatedAt DATETIME2 NOT NULL CONSTRAINT DF_RaceCorner_CreatedAt DEFAULT SYSUTCDATETIME(),
        UpdatedAt DATETIME2 NOT NULL CONSTRAINT DF_RaceCorner_UpdatedAt DEFAULT SYSUTCDATETIME()
    );
END;
GO

IF OBJECT_ID(N'dbo.RaceLap', N'U') IS NULL
BEGIN
    CREATE TABLE dbo.RaceLap (
        RaceLapId BIGINT IDENTITY(1,1) NOT NULL,
        RaceId BIGINT NOT NULL,
        SectionNumber TINYINT NOT NULL,
        DistanceFrom INT NULL,
        DistanceTo INT NULL,
        LapTime DECIMAL(5,2) NOT NULL,
        CreatedAt DATETIME2 NOT NULL CONSTRAINT DF_RaceLap_CreatedAt DEFAULT SYSUTCDATETIME(),
        UpdatedAt DATETIME2 NOT NULL CONSTRAINT DF_RaceLap_UpdatedAt DEFAULT SYSUTCDATETIME()
    );
END;
GO

IF OBJECT_ID(N'dbo.RaceOdds', N'U') IS NULL
BEGIN
    CREATE TABLE dbo.RaceOdds (
        RaceOddsId BIGINT IDENTITY(1,1) NOT NULL,
        RaceId BIGINT NOT NULL,
        BetTypeCode VARCHAR(30) NOT NULL,
        SelectionKey VARCHAR(50) NOT NULL,
        OddsMin DECIMAL(12,4) NOT NULL,
        OddsMax DECIMAL(12,4) NOT NULL,
        Popularity TINYINT NULL,
        RecordedAt DATETIME2 NOT NULL,
        IsFinal BIT NOT NULL,
        DataSourceId INT NOT NULL,
        CreatedAt DATETIME2 NOT NULL CONSTRAINT DF_RaceOdds_CreatedAt DEFAULT SYSUTCDATETIME(),
        UpdatedAt DATETIME2 NOT NULL CONSTRAINT DF_RaceOdds_UpdatedAt DEFAULT SYSUTCDATETIME()
    );
END;
GO

IF OBJECT_ID(N'dbo.RaceOddsSelection', N'U') IS NULL
BEGIN
    CREATE TABLE dbo.RaceOddsSelection (
        RaceOddsId BIGINT NOT NULL,
        SelectionOrder TINYINT NOT NULL,
        SelectionNumber TINYINT NOT NULL
    );
END;
GO

IF OBJECT_ID(N'dbo.RacePayout', N'U') IS NULL
BEGIN
    CREATE TABLE dbo.RacePayout (
        RacePayoutId BIGINT IDENTITY(1,1) NOT NULL,
        RaceId BIGINT NOT NULL,
        BetTypeCode VARCHAR(30) NOT NULL,
        SelectionKey VARCHAR(50) NOT NULL,
        PayoutAmount INT NOT NULL,
        Popularity TINYINT NULL,
        DataSourceId INT NOT NULL,
        CreatedAt DATETIME2 NOT NULL CONSTRAINT DF_RacePayout_CreatedAt DEFAULT SYSUTCDATETIME(),
        UpdatedAt DATETIME2 NOT NULL CONSTRAINT DF_RacePayout_UpdatedAt DEFAULT SYSUTCDATETIME()
    );
END;
GO

IF OBJECT_ID(N'dbo.RacePayoutSelection', N'U') IS NULL
BEGIN
    CREATE TABLE dbo.RacePayoutSelection (
        RacePayoutId BIGINT NOT NULL,
        SelectionOrder TINYINT NOT NULL,
        SelectionNumber TINYINT NOT NULL
    );
END;
GO

IF OBJECT_ID(N'dbo.RacePrize', N'U') IS NULL
BEGIN
    CREATE TABLE dbo.RacePrize (
        RacePrizeId BIGINT IDENTITY(1,1) NOT NULL,
        RaceId BIGINT NOT NULL,
        PrizeTypeCode VARCHAR(20) NOT NULL,
        FinishPosition TINYINT NOT NULL,
        PrizeAmount BIGINT NOT NULL,
        DataSourceId INT NOT NULL,
        CreatedAt DATETIME2 NOT NULL CONSTRAINT DF_RacePrize_CreatedAt DEFAULT SYSUTCDATETIME(),
        UpdatedAt DATETIME2 NOT NULL CONSTRAINT DF_RacePrize_UpdatedAt DEFAULT SYSUTCDATETIME()
    );
END;
GO

IF OBJECT_ID(N'dbo.RaceEntryMetric', N'U') IS NULL
BEGIN
    CREATE TABLE dbo.RaceEntryMetric (
        RaceEntryMetricId BIGINT IDENTITY(1,1) NOT NULL,
        RaceEntryId BIGINT NOT NULL,
        MetricTypeCode VARCHAR(30) NOT NULL,
        MetricValue DECIMAL(18,6) NOT NULL,
        UnitCode VARCHAR(30) NULL,
        DataSourceId INT NOT NULL,
        CalculatedAt DATETIME2 NOT NULL,
        CreatedAt DATETIME2 NOT NULL CONSTRAINT DF_RaceEntryMetric_CreatedAt DEFAULT SYSUTCDATETIME(),
        UpdatedAt DATETIME2 NOT NULL CONSTRAINT DF_RaceEntryMetric_UpdatedAt DEFAULT SYSUTCDATETIME()
    );
END;
GO

IF OBJECT_ID(N'dbo.RaceEntryEvaluation', N'U') IS NULL
BEGIN
    CREATE TABLE dbo.RaceEntryEvaluation (
        RaceEntryEvaluationId BIGINT IDENTITY(1,1) NOT NULL,
        RaceEntryId BIGINT NOT NULL,
        EvaluationTypeCode VARCHAR(30) NOT NULL,
        EvaluationValue NVARCHAR(100) NOT NULL,
        DataSourceId INT NOT NULL,
        EvaluatedAt DATETIME2 NOT NULL,
        CreatedAt DATETIME2 NOT NULL CONSTRAINT DF_RaceEntryEvaluation_CreatedAt DEFAULT SYSUTCDATETIME(),
        UpdatedAt DATETIME2 NOT NULL CONSTRAINT DF_RaceEntryEvaluation_UpdatedAt DEFAULT SYSUTCDATETIME()
    );
END;
GO

IF OBJECT_ID(N'dbo.RawContent', N'U') IS NULL
BEGIN
    CREATE TABLE dbo.RawContent (
        RawContentId BIGINT IDENTITY(1,1) NOT NULL,
        ContentHash CHAR(64) NOT NULL,
        StorageTypeCode VARCHAR(20) NOT NULL,
        RawBinary VARBINARY(MAX) NULL,
        StoragePath NVARCHAR(1000) NULL,
        ContentEncoding VARCHAR(50) NULL,
        ContentLength BIGINT NOT NULL,
        CreatedAt DATETIME2 NOT NULL CONSTRAINT DF_RawContent_CreatedAt DEFAULT SYSUTCDATETIME(),
        UpdatedAt DATETIME2 NOT NULL CONSTRAINT DF_RawContent_UpdatedAt DEFAULT SYSUTCDATETIME()
    );
END;
GO

IF OBJECT_ID(N'dbo.RawFetch', N'U') IS NULL
BEGIN
    CREATE TABLE dbo.RawFetch (
        RawFetchId BIGINT IDENTITY(1,1) NOT NULL,
        RawContentId BIGINT NOT NULL,
        DataSourceId INT NOT NULL,
        DataTypeCode VARCHAR(30) NOT NULL,
        SourceUrl NVARCHAR(1000) NULL,
        ExternalId NVARCHAR(200) NULL,
        RetrievedAt DATETIME2 NOT NULL,
        HttpStatusCode SMALLINT NULL,
        CreatedAt DATETIME2 NOT NULL CONSTRAINT DF_RawFetch_CreatedAt DEFAULT SYSUTCDATETIME(),
        UpdatedAt DATETIME2 NOT NULL CONSTRAINT DF_RawFetch_UpdatedAt DEFAULT SYSUTCDATETIME()
    );
END;
GO

IF OBJECT_ID(N'dbo.RaceSourceMapping', N'U') IS NULL
BEGIN
    CREATE TABLE dbo.RaceSourceMapping (
        RaceId BIGINT NOT NULL,
        DataSourceId INT NOT NULL,
        ExternalId NVARCHAR(200) NOT NULL,
        ExternalUrl NVARCHAR(1000) NULL,
        CreatedAt DATETIME2 NOT NULL CONSTRAINT DF_RaceSourceMapping_CreatedAt DEFAULT SYSUTCDATETIME(),
        UpdatedAt DATETIME2 NOT NULL CONSTRAINT DF_RaceSourceMapping_UpdatedAt DEFAULT SYSUTCDATETIME()
    );
END;
GO

IF OBJECT_ID(N'dbo.HorseSourceMapping', N'U') IS NULL
BEGIN
    CREATE TABLE dbo.HorseSourceMapping (
        HorseId BIGINT NOT NULL,
        DataSourceId INT NOT NULL,
        ExternalId NVARCHAR(200) NOT NULL,
        ExternalUrl NVARCHAR(1000) NULL,
        CreatedAt DATETIME2 NOT NULL CONSTRAINT DF_HorseSourceMapping_CreatedAt DEFAULT SYSUTCDATETIME(),
        UpdatedAt DATETIME2 NOT NULL CONSTRAINT DF_HorseSourceMapping_UpdatedAt DEFAULT SYSUTCDATETIME()
    );
END;
GO

IF OBJECT_ID(N'dbo.JockeySourceMapping', N'U') IS NULL
BEGIN
    CREATE TABLE dbo.JockeySourceMapping (
        JockeyId INT NOT NULL,
        DataSourceId INT NOT NULL,
        ExternalId NVARCHAR(200) NOT NULL,
        ExternalUrl NVARCHAR(1000) NULL,
        CreatedAt DATETIME2 NOT NULL CONSTRAINT DF_JockeySourceMapping_CreatedAt DEFAULT SYSUTCDATETIME(),
        UpdatedAt DATETIME2 NOT NULL CONSTRAINT DF_JockeySourceMapping_UpdatedAt DEFAULT SYSUTCDATETIME()
    );
END;
GO

IF OBJECT_ID(N'dbo.TrainerSourceMapping', N'U') IS NULL
BEGIN
    CREATE TABLE dbo.TrainerSourceMapping (
        TrainerId INT NOT NULL,
        DataSourceId INT NOT NULL,
        ExternalId NVARCHAR(200) NOT NULL,
        ExternalUrl NVARCHAR(1000) NULL,
        CreatedAt DATETIME2 NOT NULL CONSTRAINT DF_TrainerSourceMapping_CreatedAt DEFAULT SYSUTCDATETIME(),
        UpdatedAt DATETIME2 NOT NULL CONSTRAINT DF_TrainerSourceMapping_UpdatedAt DEFAULT SYSUTCDATETIME()
    );
END;
GO

IF OBJECT_ID(N'dbo.RacecourseSourceMapping', N'U') IS NULL
BEGIN
    CREATE TABLE dbo.RacecourseSourceMapping (
        RacecourseId INT NOT NULL,
        DataSourceId INT NOT NULL,
        ExternalId NVARCHAR(200) NOT NULL,
        ExternalUrl NVARCHAR(1000) NULL,
        CreatedAt DATETIME2 NOT NULL CONSTRAINT DF_RacecourseSourceMapping_CreatedAt DEFAULT SYSUTCDATETIME(),
        UpdatedAt DATETIME2 NOT NULL CONSTRAINT DF_RacecourseSourceMapping_UpdatedAt DEFAULT SYSUTCDATETIME()
    );
END;
GO

IF OBJECT_ID(N'dbo.RaceRawFetchLink', N'U') IS NULL
BEGIN
    CREATE TABLE dbo.RaceRawFetchLink (
        RaceId BIGINT NOT NULL,
        RawFetchId BIGINT NOT NULL,
        CreatedAt DATETIME2 NOT NULL CONSTRAINT DF_RaceRawFetchLink_CreatedAt DEFAULT SYSUTCDATETIME()
    );
END;
GO

IF OBJECT_ID(N'dbo.RaceEntryRawFetchLink', N'U') IS NULL
BEGIN
    CREATE TABLE dbo.RaceEntryRawFetchLink (
        RaceEntryId BIGINT NOT NULL,
        RawFetchId BIGINT NOT NULL,
        CreatedAt DATETIME2 NOT NULL CONSTRAINT DF_RaceEntryRawFetchLink_CreatedAt DEFAULT SYSUTCDATETIME()
    );
END;
GO
