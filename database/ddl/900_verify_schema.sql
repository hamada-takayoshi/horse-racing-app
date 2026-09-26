USE [$(DatabaseName)];
GO

DECLARE @TableCount INT = (
    SELECT COUNT(*)
    FROM sys.tables
    WHERE schema_id = SCHEMA_ID(N'dbo')
);

IF @TableCount <> 39
    THROW 51000, 'Expected 39 dbo tables.', 1;

DECLARE @ViewCount INT = (
    SELECT COUNT(*)
    FROM sys.views
    WHERE schema_id = SCHEMA_ID(N'dbo')
      AND name IN (N'FinalRaceOddsView', N'HorseAnalysisView')
);

IF @ViewCount <> 2
    THROW 51001, 'Expected two required dbo views.', 1;

IF NOT EXISTS (
    SELECT 1
    FROM sys.columns
    WHERE object_id = OBJECT_ID(N'dbo.HorseAnalysisView')
      AND name = N'SexCode'
)
    THROW 51011, 'HorseAnalysisView.SexCode is missing.', 1;

DECLARE @PrimaryKeyCount INT = (
    SELECT COUNT(*)
    FROM sys.key_constraints
    WHERE schema_id = SCHEMA_ID(N'dbo')
      AND type = 'PK'
);

IF @PrimaryKeyCount <> 39
    THROW 51006, 'Expected 39 primary keys.', 1;

DECLARE @UniqueConstraintCount INT = (
    SELECT COUNT(*)
    FROM sys.key_constraints
    WHERE schema_id = SCHEMA_ID(N'dbo')
      AND type = 'UQ'
);

IF @UniqueConstraintCount <> 19
    THROW 51007, 'Expected 19 unique constraints.', 1;

DECLARE @ForeignKeyCount INT = (
    SELECT COUNT(*)
    FROM sys.foreign_keys
    WHERE schema_id = SCHEMA_ID(N'dbo')
);

IF @ForeignKeyCount <> 52
    THROW 51008, 'Expected 52 foreign keys.', 1;

DECLARE @CheckConstraintCount INT = (
    SELECT COUNT(*)
    FROM sys.check_constraints
    WHERE schema_id = SCHEMA_ID(N'dbo')
);

IF @CheckConstraintCount <> 14
    THROW 51009, 'Expected 14 check constraints.', 1;

DECLARE @RequiredIndexCount INT = (
    SELECT COUNT(*)
    FROM sys.indexes
    WHERE name IN (
        N'UX_DataSource_SourceName', N'IX_Race_Date', N'IX_Race_CourseDate',
        N'IX_Horse_NameBirthYear', N'UX_RaceEntry_RaceHorseNumber',
        N'IX_RaceEntry_Horse', N'UX_RaceOdds_Final',
        N'IX_RaceOdds_FinalLookup', N'IX_RawFetch_SourceTime'
    )
);

IF @RequiredIndexCount <> 9
    THROW 51010, 'A required index is missing.', 1;

IF (SELECT COUNT(*) FROM dbo.RacingCategory WHERE RacingCategoryCode IN ('CENTRAL', 'LOCAL')) <> 2
    THROW 51002, 'RacingCategory seed data is incomplete.', 1;

IF (SELECT COUNT(*) FROM dbo.BetType WHERE BetTypeCode IN (
    'WIN', 'PLACE', 'BRACKET_QUINELLA', 'BRACKET_EXACTA',
    'QUINELLA', 'WIDE', 'EXACTA', 'TRIO', 'TRIFECTA'
)) <> 9
    THROW 51003, 'BetType seed data is incomplete.', 1;

IF EXISTS (SELECT 1 FROM dbo.RacingCategory WHERE RacingCategoryCode = 'VERIFY_WRITE')
    THROW 51012, 'Temporary write-verification data remains.', 1;

IF NOT EXISTS (
    SELECT 1
    FROM sys.indexes
    WHERE object_id = OBJECT_ID(N'dbo.RaceOdds')
      AND name = N'UX_RaceOdds_Final'
      AND has_filter = 1
)
    THROW 51004, 'Filtered final-odds index is missing.', 1;

IF EXISTS (
    SELECT 1
    FROM sys.foreign_keys
    WHERE schema_id <> SCHEMA_ID(N'dbo')
       OR is_disabled = 1
       OR is_not_trusted = 1
)
    THROW 51005, 'A foreign key is disabled or untrusted.', 1;

SELECT
    @TableCount AS TableCount,
    @ViewCount AS RequiredViewCount,
    @PrimaryKeyCount AS PrimaryKeyCount,
    @UniqueConstraintCount AS UniqueConstraintCount,
    @ForeignKeyCount AS ForeignKeyCount,
    @CheckConstraintCount AS CheckConstraintCount,
    @RequiredIndexCount AS RequiredIndexCount,
    (SELECT COUNT(*) FROM dbo.RacingCategory) AS RacingCategoryCount,
    (SELECT COUNT(*) FROM dbo.BetType) AS BetTypeCount;
GO
