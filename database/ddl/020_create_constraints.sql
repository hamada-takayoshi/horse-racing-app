USE [$(DatabaseName)];
GO

DECLARE @ConstraintDefinitions TABLE (
    ConstraintName SYSNAME NOT NULL,
    Definition NVARCHAR(MAX) NOT NULL
);

INSERT INTO @ConstraintDefinitions (ConstraintName, Definition)
VALUES
    (N'PK_DataSource', N'ALTER TABLE dbo.DataSource ADD CONSTRAINT PK_DataSource PRIMARY KEY (DataSourceId);'),
    (N'PK_RacingCategory', N'ALTER TABLE dbo.RacingCategory ADD CONSTRAINT PK_RacingCategory PRIMARY KEY (RacingCategoryCode);'),
    (N'PK_Organizer', N'ALTER TABLE dbo.Organizer ADD CONSTRAINT PK_Organizer PRIMARY KEY (OrganizerId);'),
    (N'PK_Racecourse', N'ALTER TABLE dbo.Racecourse ADD CONSTRAINT PK_Racecourse PRIMARY KEY (RacecourseId);'),
    (N'PK_BetType', N'ALTER TABLE dbo.BetType ADD CONSTRAINT PK_BetType PRIMARY KEY (BetTypeCode);'),
    (N'PK_RaceGrade', N'ALTER TABLE dbo.RaceGrade ADD CONSTRAINT PK_RaceGrade PRIMARY KEY (RaceGradeCode);'),
    (N'PK_Weather', N'ALTER TABLE dbo.Weather ADD CONSTRAINT PK_Weather PRIMARY KEY (WeatherCode);'),
    (N'PK_TrackCondition', N'ALTER TABLE dbo.TrackCondition ADD CONSTRAINT PK_TrackCondition PRIMARY KEY (TrackConditionCode);'),
    (N'PK_RaceClass', N'ALTER TABLE dbo.RaceClass ADD CONSTRAINT PK_RaceClass PRIMARY KEY (RaceClassCode);'),
    (N'PK_AgeCondition', N'ALTER TABLE dbo.AgeCondition ADD CONSTRAINT PK_AgeCondition PRIMARY KEY (AgeConditionCode);'),
    (N'PK_SexCondition', N'ALTER TABLE dbo.SexCondition ADD CONSTRAINT PK_SexCondition PRIMARY KEY (SexConditionCode);'),
    (N'PK_WeightCondition', N'ALTER TABLE dbo.WeightCondition ADD CONSTRAINT PK_WeightCondition PRIMARY KEY (WeightConditionCode);'),
    (N'PK_MetricType', N'ALTER TABLE dbo.MetricType ADD CONSTRAINT PK_MetricType PRIMARY KEY (MetricTypeCode);'),
    (N'PK_EvaluationType', N'ALTER TABLE dbo.EvaluationType ADD CONSTRAINT PK_EvaluationType PRIMARY KEY (EvaluationTypeCode);'),
    (N'PK_Unit', N'ALTER TABLE dbo.Unit ADD CONSTRAINT PK_Unit PRIMARY KEY (UnitCode);'),
    (N'PK_DataType', N'ALTER TABLE dbo.DataType ADD CONSTRAINT PK_DataType PRIMARY KEY (DataTypeCode);'),
    (N'PK_Race', N'ALTER TABLE dbo.Race ADD CONSTRAINT PK_Race PRIMARY KEY (RaceId);'),
    (N'PK_Horse', N'ALTER TABLE dbo.Horse ADD CONSTRAINT PK_Horse PRIMARY KEY (HorseId);'),
    (N'PK_Jockey', N'ALTER TABLE dbo.Jockey ADD CONSTRAINT PK_Jockey PRIMARY KEY (JockeyId);'),
    (N'PK_Trainer', N'ALTER TABLE dbo.Trainer ADD CONSTRAINT PK_Trainer PRIMARY KEY (TrainerId);'),
    (N'PK_RaceEntry', N'ALTER TABLE dbo.RaceEntry ADD CONSTRAINT PK_RaceEntry PRIMARY KEY (RaceEntryId);'),
    (N'PK_RaceCorner', N'ALTER TABLE dbo.RaceCorner ADD CONSTRAINT PK_RaceCorner PRIMARY KEY (RaceCornerId);'),
    (N'PK_RaceLap', N'ALTER TABLE dbo.RaceLap ADD CONSTRAINT PK_RaceLap PRIMARY KEY (RaceLapId);'),
    (N'PK_RaceOdds', N'ALTER TABLE dbo.RaceOdds ADD CONSTRAINT PK_RaceOdds PRIMARY KEY (RaceOddsId);'),
    (N'PK_RaceOddsSelection', N'ALTER TABLE dbo.RaceOddsSelection ADD CONSTRAINT PK_RaceOddsSelection PRIMARY KEY (RaceOddsId, SelectionOrder);'),
    (N'PK_RacePayout', N'ALTER TABLE dbo.RacePayout ADD CONSTRAINT PK_RacePayout PRIMARY KEY (RacePayoutId);'),
    (N'PK_RacePayoutSelection', N'ALTER TABLE dbo.RacePayoutSelection ADD CONSTRAINT PK_RacePayoutSelection PRIMARY KEY (RacePayoutId, SelectionOrder);'),
    (N'PK_RacePrize', N'ALTER TABLE dbo.RacePrize ADD CONSTRAINT PK_RacePrize PRIMARY KEY (RacePrizeId);'),
    (N'PK_RaceEntryMetric', N'ALTER TABLE dbo.RaceEntryMetric ADD CONSTRAINT PK_RaceEntryMetric PRIMARY KEY (RaceEntryMetricId);'),
    (N'PK_RaceEntryEvaluation', N'ALTER TABLE dbo.RaceEntryEvaluation ADD CONSTRAINT PK_RaceEntryEvaluation PRIMARY KEY (RaceEntryEvaluationId);'),
    (N'PK_RawContent', N'ALTER TABLE dbo.RawContent ADD CONSTRAINT PK_RawContent PRIMARY KEY (RawContentId);'),
    (N'PK_RawFetch', N'ALTER TABLE dbo.RawFetch ADD CONSTRAINT PK_RawFetch PRIMARY KEY (RawFetchId);'),
    (N'PK_RaceSourceMapping', N'ALTER TABLE dbo.RaceSourceMapping ADD CONSTRAINT PK_RaceSourceMapping PRIMARY KEY (RaceId, DataSourceId);'),
    (N'PK_HorseSourceMapping', N'ALTER TABLE dbo.HorseSourceMapping ADD CONSTRAINT PK_HorseSourceMapping PRIMARY KEY (HorseId, DataSourceId);'),
    (N'PK_JockeySourceMapping', N'ALTER TABLE dbo.JockeySourceMapping ADD CONSTRAINT PK_JockeySourceMapping PRIMARY KEY (JockeyId, DataSourceId);'),
    (N'PK_TrainerSourceMapping', N'ALTER TABLE dbo.TrainerSourceMapping ADD CONSTRAINT PK_TrainerSourceMapping PRIMARY KEY (TrainerId, DataSourceId);'),
    (N'PK_RacecourseSourceMapping', N'ALTER TABLE dbo.RacecourseSourceMapping ADD CONSTRAINT PK_RacecourseSourceMapping PRIMARY KEY (RacecourseId, DataSourceId);'),
    (N'PK_RaceRawFetchLink', N'ALTER TABLE dbo.RaceRawFetchLink ADD CONSTRAINT PK_RaceRawFetchLink PRIMARY KEY (RaceId, RawFetchId);'),
    (N'PK_RaceEntryRawFetchLink', N'ALTER TABLE dbo.RaceEntryRawFetchLink ADD CONSTRAINT PK_RaceEntryRawFetchLink PRIMARY KEY (RaceEntryId, RawFetchId);'),

    (N'UQ_Organizer_Code', N'ALTER TABLE dbo.Organizer ADD CONSTRAINT UQ_Organizer_Code UNIQUE (OrganizerCode);'),
    (N'UQ_Racecourse_Code', N'ALTER TABLE dbo.Racecourse ADD CONSTRAINT UQ_Racecourse_Code UNIQUE (RacingCategoryCode, RacecourseCode);'),
    (N'UQ_Race_DateCourseNumber', N'ALTER TABLE dbo.Race ADD CONSTRAINT UQ_Race_DateCourseNumber UNIQUE (RaceDate, RacecourseId, RaceNumber);'),
    (N'UQ_RaceEntry_RaceHorse', N'ALTER TABLE dbo.RaceEntry ADD CONSTRAINT UQ_RaceEntry_RaceHorse UNIQUE (RaceId, HorseId);'),
    (N'UQ_RaceCorner', N'ALTER TABLE dbo.RaceCorner ADD CONSTRAINT UQ_RaceCorner UNIQUE (RaceEntryId, CornerNumber);'),
    (N'UQ_RaceLap', N'ALTER TABLE dbo.RaceLap ADD CONSTRAINT UQ_RaceLap UNIQUE (RaceId, SectionNumber);'),
    (N'UQ_RaceOdds', N'ALTER TABLE dbo.RaceOdds ADD CONSTRAINT UQ_RaceOdds UNIQUE (RaceId, BetTypeCode, SelectionKey, RecordedAt, DataSourceId);'),
    (N'UQ_RaceOddsSelection_Number', N'ALTER TABLE dbo.RaceOddsSelection ADD CONSTRAINT UQ_RaceOddsSelection_Number UNIQUE (RaceOddsId, SelectionNumber);'),
    (N'UQ_RacePayout', N'ALTER TABLE dbo.RacePayout ADD CONSTRAINT UQ_RacePayout UNIQUE (RaceId, BetTypeCode, SelectionKey);'),
    (N'UQ_RacePayoutSelection_Number', N'ALTER TABLE dbo.RacePayoutSelection ADD CONSTRAINT UQ_RacePayoutSelection_Number UNIQUE (RacePayoutId, SelectionNumber);'),
    (N'UQ_RacePrize', N'ALTER TABLE dbo.RacePrize ADD CONSTRAINT UQ_RacePrize UNIQUE (RaceId, PrizeTypeCode, FinishPosition);'),
    (N'UQ_RaceEntryMetric', N'ALTER TABLE dbo.RaceEntryMetric ADD CONSTRAINT UQ_RaceEntryMetric UNIQUE (RaceEntryId, MetricTypeCode, DataSourceId, CalculatedAt);'),
    (N'UQ_RaceEntryEvaluation', N'ALTER TABLE dbo.RaceEntryEvaluation ADD CONSTRAINT UQ_RaceEntryEvaluation UNIQUE (RaceEntryId, EvaluationTypeCode, DataSourceId, EvaluatedAt);'),
    (N'UQ_RawContent_Hash', N'ALTER TABLE dbo.RawContent ADD CONSTRAINT UQ_RawContent_Hash UNIQUE (ContentHash);'),
    (N'UQ_RaceSourceMapping_External', N'ALTER TABLE dbo.RaceSourceMapping ADD CONSTRAINT UQ_RaceSourceMapping_External UNIQUE (DataSourceId, ExternalId);'),
    (N'UQ_HorseSourceMapping_External', N'ALTER TABLE dbo.HorseSourceMapping ADD CONSTRAINT UQ_HorseSourceMapping_External UNIQUE (DataSourceId, ExternalId);'),
    (N'UQ_JockeySourceMapping_External', N'ALTER TABLE dbo.JockeySourceMapping ADD CONSTRAINT UQ_JockeySourceMapping_External UNIQUE (DataSourceId, ExternalId);'),
    (N'UQ_TrainerSourceMapping_External', N'ALTER TABLE dbo.TrainerSourceMapping ADD CONSTRAINT UQ_TrainerSourceMapping_External UNIQUE (DataSourceId, ExternalId);'),
    (N'UQ_RacecourseSourceMapping_External', N'ALTER TABLE dbo.RacecourseSourceMapping ADD CONSTRAINT UQ_RacecourseSourceMapping_External UNIQUE (DataSourceId, ExternalId);'),

    (N'CK_DataSource_SourceType', N'ALTER TABLE dbo.DataSource ADD CONSTRAINT CK_DataSource_SourceType CHECK (SourceTypeCode IN (''WEB'',''API'',''FILE''));'),
    (N'CK_DataSource_Authority', N'ALTER TABLE dbo.DataSource ADD CONSTRAINT CK_DataSource_Authority CHECK (AuthorityLevelCode IN (''OFFICIAL'',''OFFICIAL_PROVIDER'',''PAID'',''EXTERNAL''));'),
    (N'CK_BetType_SelectionType', N'ALTER TABLE dbo.BetType ADD CONSTRAINT CK_BetType_SelectionType CHECK (SelectionTypeCode IN (''HORSE'',''FRAME''));'),
    (N'CK_Race_RaceType', N'ALTER TABLE dbo.Race ADD CONSTRAINT CK_Race_RaceType CHECK (RaceTypeCode IN (''FLAT'',''JUMP''));'),
    (N'CK_Race_SurfaceType', N'ALTER TABLE dbo.Race ADD CONSTRAINT CK_Race_SurfaceType CHECK (SurfaceTypeCode IN (''TURF'',''DIRT''));'),
    (N'CK_Race_CourseDirection', N'ALTER TABLE dbo.Race ADD CONSTRAINT CK_Race_CourseDirection CHECK (CourseDirectionCode IS NULL OR CourseDirectionCode IN (''LEFT'',''RIGHT'',''STRAIGHT''));'),
    (N'CK_Horse_BirthYear', N'ALTER TABLE dbo.Horse ADD CONSTRAINT CK_Horse_BirthYear CHECK (BirthDate IS NULL OR BirthYear = YEAR(BirthDate));'),
    (N'CK_Horse_SexCode', N'ALTER TABLE dbo.Horse ADD CONSTRAINT CK_Horse_SexCode CHECK (SexCode IS NULL OR SexCode IN (''MALE'',''FEMALE'',''GELDING''));'),
    (N'CK_RaceEntry_HorseSexCode', N'ALTER TABLE dbo.RaceEntry ADD CONSTRAINT CK_RaceEntry_HorseSexCode CHECK (HorseSexCode IS NULL OR HorseSexCode IN (''MALE'',''FEMALE'',''GELDING''));'),
    (N'CK_RaceEntry_EntryStatus', N'ALTER TABLE dbo.RaceEntry ADD CONSTRAINT CK_RaceEntry_EntryStatus CHECK (EntryStatusCode IN (''REGISTERED'',''EXPECTED'',''CONFIRMED'',''SCRATCHED'',''EXCLUDED''));'),
    (N'CK_RaceEntry_ResultStatus', N'ALTER TABLE dbo.RaceEntry ADD CONSTRAINT CK_RaceEntry_ResultStatus CHECK (ResultStatusCode IS NULL OR ResultStatusCode IN (''FINISHED'',''DNF'',''DISQUALIFIED'',''DEMOTED''));'),
    (N'CK_RaceOdds_Range', N'ALTER TABLE dbo.RaceOdds ADD CONSTRAINT CK_RaceOdds_Range CHECK (OddsMin <= OddsMax);'),
    (N'CK_RawContent_StorageType', N'ALTER TABLE dbo.RawContent ADD CONSTRAINT CK_RawContent_StorageType CHECK (StorageTypeCode IN (''DATABASE'',''FILE'',''COMPRESSED_FILE''));'),
    (N'CK_RawContent_Storage', N'ALTER TABLE dbo.RawContent ADD CONSTRAINT CK_RawContent_Storage CHECK ((StorageTypeCode = ''DATABASE'' AND RawBinary IS NOT NULL) OR (StorageTypeCode IN (''FILE'',''COMPRESSED_FILE'') AND StoragePath IS NOT NULL));'),

    (N'FK_Racecourse_RacingCategory', N'ALTER TABLE dbo.Racecourse WITH CHECK ADD CONSTRAINT FK_Racecourse_RacingCategory FOREIGN KEY (RacingCategoryCode) REFERENCES dbo.RacingCategory(RacingCategoryCode);'),
    (N'FK_Racecourse_Organizer', N'ALTER TABLE dbo.Racecourse WITH CHECK ADD CONSTRAINT FK_Racecourse_Organizer FOREIGN KEY (OrganizerId) REFERENCES dbo.Organizer(OrganizerId);'),
    (N'FK_Race_Racecourse', N'ALTER TABLE dbo.Race WITH CHECK ADD CONSTRAINT FK_Race_Racecourse FOREIGN KEY (RacecourseId) REFERENCES dbo.Racecourse(RacecourseId);'),
    (N'FK_Race_Weather', N'ALTER TABLE dbo.Race WITH CHECK ADD CONSTRAINT FK_Race_Weather FOREIGN KEY (WeatherCode) REFERENCES dbo.Weather(WeatherCode);'),
    (N'FK_Race_TrackCondition', N'ALTER TABLE dbo.Race WITH CHECK ADD CONSTRAINT FK_Race_TrackCondition FOREIGN KEY (TrackConditionCode) REFERENCES dbo.TrackCondition(TrackConditionCode);'),
    (N'FK_Race_RaceClass', N'ALTER TABLE dbo.Race WITH CHECK ADD CONSTRAINT FK_Race_RaceClass FOREIGN KEY (RaceClassCode) REFERENCES dbo.RaceClass(RaceClassCode);'),
    (N'FK_Race_RaceGrade', N'ALTER TABLE dbo.Race WITH CHECK ADD CONSTRAINT FK_Race_RaceGrade FOREIGN KEY (RaceGradeCode) REFERENCES dbo.RaceGrade(RaceGradeCode);'),
    (N'FK_Race_AgeCondition', N'ALTER TABLE dbo.Race WITH CHECK ADD CONSTRAINT FK_Race_AgeCondition FOREIGN KEY (AgeConditionCode) REFERENCES dbo.AgeCondition(AgeConditionCode);'),
    (N'FK_Race_SexCondition', N'ALTER TABLE dbo.Race WITH CHECK ADD CONSTRAINT FK_Race_SexCondition FOREIGN KEY (SexConditionCode) REFERENCES dbo.SexCondition(SexConditionCode);'),
    (N'FK_Race_WeightCondition', N'ALTER TABLE dbo.Race WITH CHECK ADD CONSTRAINT FK_Race_WeightCondition FOREIGN KEY (WeightConditionCode) REFERENCES dbo.WeightCondition(WeightConditionCode);'),
    (N'FK_Horse_SireHorse', N'ALTER TABLE dbo.Horse WITH CHECK ADD CONSTRAINT FK_Horse_SireHorse FOREIGN KEY (SireHorseId) REFERENCES dbo.Horse(HorseId);'),
    (N'FK_Horse_DamHorse', N'ALTER TABLE dbo.Horse WITH CHECK ADD CONSTRAINT FK_Horse_DamHorse FOREIGN KEY (DamHorseId) REFERENCES dbo.Horse(HorseId);'),
    (N'FK_RaceEntry_Race', N'ALTER TABLE dbo.RaceEntry WITH CHECK ADD CONSTRAINT FK_RaceEntry_Race FOREIGN KEY (RaceId) REFERENCES dbo.Race(RaceId);'),
    (N'FK_RaceEntry_Horse', N'ALTER TABLE dbo.RaceEntry WITH CHECK ADD CONSTRAINT FK_RaceEntry_Horse FOREIGN KEY (HorseId) REFERENCES dbo.Horse(HorseId);'),
    (N'FK_RaceEntry_Jockey', N'ALTER TABLE dbo.RaceEntry WITH CHECK ADD CONSTRAINT FK_RaceEntry_Jockey FOREIGN KEY (JockeyId) REFERENCES dbo.Jockey(JockeyId);'),
    (N'FK_RaceEntry_Trainer', N'ALTER TABLE dbo.RaceEntry WITH CHECK ADD CONSTRAINT FK_RaceEntry_Trainer FOREIGN KEY (TrainerId) REFERENCES dbo.Trainer(TrainerId);'),
    (N'FK_RaceCorner_RaceEntry', N'ALTER TABLE dbo.RaceCorner WITH CHECK ADD CONSTRAINT FK_RaceCorner_RaceEntry FOREIGN KEY (RaceEntryId) REFERENCES dbo.RaceEntry(RaceEntryId);'),
    (N'FK_RaceLap_Race', N'ALTER TABLE dbo.RaceLap WITH CHECK ADD CONSTRAINT FK_RaceLap_Race FOREIGN KEY (RaceId) REFERENCES dbo.Race(RaceId);'),
    (N'FK_RaceOdds_Race', N'ALTER TABLE dbo.RaceOdds WITH CHECK ADD CONSTRAINT FK_RaceOdds_Race FOREIGN KEY (RaceId) REFERENCES dbo.Race(RaceId);'),
    (N'FK_RaceOdds_BetType', N'ALTER TABLE dbo.RaceOdds WITH CHECK ADD CONSTRAINT FK_RaceOdds_BetType FOREIGN KEY (BetTypeCode) REFERENCES dbo.BetType(BetTypeCode);'),
    (N'FK_RaceOdds_DataSource', N'ALTER TABLE dbo.RaceOdds WITH CHECK ADD CONSTRAINT FK_RaceOdds_DataSource FOREIGN KEY (DataSourceId) REFERENCES dbo.DataSource(DataSourceId);'),
    (N'FK_RaceOddsSelection_RaceOdds', N'ALTER TABLE dbo.RaceOddsSelection WITH CHECK ADD CONSTRAINT FK_RaceOddsSelection_RaceOdds FOREIGN KEY (RaceOddsId) REFERENCES dbo.RaceOdds(RaceOddsId);'),
    (N'FK_RacePayout_Race', N'ALTER TABLE dbo.RacePayout WITH CHECK ADD CONSTRAINT FK_RacePayout_Race FOREIGN KEY (RaceId) REFERENCES dbo.Race(RaceId);'),
    (N'FK_RacePayout_BetType', N'ALTER TABLE dbo.RacePayout WITH CHECK ADD CONSTRAINT FK_RacePayout_BetType FOREIGN KEY (BetTypeCode) REFERENCES dbo.BetType(BetTypeCode);'),
    (N'FK_RacePayout_DataSource', N'ALTER TABLE dbo.RacePayout WITH CHECK ADD CONSTRAINT FK_RacePayout_DataSource FOREIGN KEY (DataSourceId) REFERENCES dbo.DataSource(DataSourceId);'),
    (N'FK_RacePayoutSelection_RacePayout', N'ALTER TABLE dbo.RacePayoutSelection WITH CHECK ADD CONSTRAINT FK_RacePayoutSelection_RacePayout FOREIGN KEY (RacePayoutId) REFERENCES dbo.RacePayout(RacePayoutId);'),
    (N'FK_RacePrize_Race', N'ALTER TABLE dbo.RacePrize WITH CHECK ADD CONSTRAINT FK_RacePrize_Race FOREIGN KEY (RaceId) REFERENCES dbo.Race(RaceId);'),
    (N'FK_RacePrize_DataSource', N'ALTER TABLE dbo.RacePrize WITH CHECK ADD CONSTRAINT FK_RacePrize_DataSource FOREIGN KEY (DataSourceId) REFERENCES dbo.DataSource(DataSourceId);'),
    (N'FK_RaceEntryMetric_RaceEntry', N'ALTER TABLE dbo.RaceEntryMetric WITH CHECK ADD CONSTRAINT FK_RaceEntryMetric_RaceEntry FOREIGN KEY (RaceEntryId) REFERENCES dbo.RaceEntry(RaceEntryId);'),
    (N'FK_RaceEntryMetric_MetricType', N'ALTER TABLE dbo.RaceEntryMetric WITH CHECK ADD CONSTRAINT FK_RaceEntryMetric_MetricType FOREIGN KEY (MetricTypeCode) REFERENCES dbo.MetricType(MetricTypeCode);'),
    (N'FK_RaceEntryMetric_Unit', N'ALTER TABLE dbo.RaceEntryMetric WITH CHECK ADD CONSTRAINT FK_RaceEntryMetric_Unit FOREIGN KEY (UnitCode) REFERENCES dbo.Unit(UnitCode);'),
    (N'FK_RaceEntryMetric_DataSource', N'ALTER TABLE dbo.RaceEntryMetric WITH CHECK ADD CONSTRAINT FK_RaceEntryMetric_DataSource FOREIGN KEY (DataSourceId) REFERENCES dbo.DataSource(DataSourceId);'),
    (N'FK_RaceEntryEvaluation_RaceEntry', N'ALTER TABLE dbo.RaceEntryEvaluation WITH CHECK ADD CONSTRAINT FK_RaceEntryEvaluation_RaceEntry FOREIGN KEY (RaceEntryId) REFERENCES dbo.RaceEntry(RaceEntryId);'),
    (N'FK_RaceEntryEvaluation_EvaluationType', N'ALTER TABLE dbo.RaceEntryEvaluation WITH CHECK ADD CONSTRAINT FK_RaceEntryEvaluation_EvaluationType FOREIGN KEY (EvaluationTypeCode) REFERENCES dbo.EvaluationType(EvaluationTypeCode);'),
    (N'FK_RaceEntryEvaluation_DataSource', N'ALTER TABLE dbo.RaceEntryEvaluation WITH CHECK ADD CONSTRAINT FK_RaceEntryEvaluation_DataSource FOREIGN KEY (DataSourceId) REFERENCES dbo.DataSource(DataSourceId);'),
    (N'FK_RawFetch_RawContent', N'ALTER TABLE dbo.RawFetch WITH CHECK ADD CONSTRAINT FK_RawFetch_RawContent FOREIGN KEY (RawContentId) REFERENCES dbo.RawContent(RawContentId);'),
    (N'FK_RawFetch_DataSource', N'ALTER TABLE dbo.RawFetch WITH CHECK ADD CONSTRAINT FK_RawFetch_DataSource FOREIGN KEY (DataSourceId) REFERENCES dbo.DataSource(DataSourceId);'),
    (N'FK_RawFetch_DataType', N'ALTER TABLE dbo.RawFetch WITH CHECK ADD CONSTRAINT FK_RawFetch_DataType FOREIGN KEY (DataTypeCode) REFERENCES dbo.DataType(DataTypeCode);'),
    (N'FK_RaceSourceMapping_Race', N'ALTER TABLE dbo.RaceSourceMapping WITH CHECK ADD CONSTRAINT FK_RaceSourceMapping_Race FOREIGN KEY (RaceId) REFERENCES dbo.Race(RaceId);'),
    (N'FK_RaceSourceMapping_DataSource', N'ALTER TABLE dbo.RaceSourceMapping WITH CHECK ADD CONSTRAINT FK_RaceSourceMapping_DataSource FOREIGN KEY (DataSourceId) REFERENCES dbo.DataSource(DataSourceId);'),
    (N'FK_HorseSourceMapping_Horse', N'ALTER TABLE dbo.HorseSourceMapping WITH CHECK ADD CONSTRAINT FK_HorseSourceMapping_Horse FOREIGN KEY (HorseId) REFERENCES dbo.Horse(HorseId);'),
    (N'FK_HorseSourceMapping_DataSource', N'ALTER TABLE dbo.HorseSourceMapping WITH CHECK ADD CONSTRAINT FK_HorseSourceMapping_DataSource FOREIGN KEY (DataSourceId) REFERENCES dbo.DataSource(DataSourceId);'),
    (N'FK_JockeySourceMapping_Jockey', N'ALTER TABLE dbo.JockeySourceMapping WITH CHECK ADD CONSTRAINT FK_JockeySourceMapping_Jockey FOREIGN KEY (JockeyId) REFERENCES dbo.Jockey(JockeyId);'),
    (N'FK_JockeySourceMapping_DataSource', N'ALTER TABLE dbo.JockeySourceMapping WITH CHECK ADD CONSTRAINT FK_JockeySourceMapping_DataSource FOREIGN KEY (DataSourceId) REFERENCES dbo.DataSource(DataSourceId);'),
    (N'FK_TrainerSourceMapping_Trainer', N'ALTER TABLE dbo.TrainerSourceMapping WITH CHECK ADD CONSTRAINT FK_TrainerSourceMapping_Trainer FOREIGN KEY (TrainerId) REFERENCES dbo.Trainer(TrainerId);'),
    (N'FK_TrainerSourceMapping_DataSource', N'ALTER TABLE dbo.TrainerSourceMapping WITH CHECK ADD CONSTRAINT FK_TrainerSourceMapping_DataSource FOREIGN KEY (DataSourceId) REFERENCES dbo.DataSource(DataSourceId);'),
    (N'FK_RacecourseSourceMapping_Racecourse', N'ALTER TABLE dbo.RacecourseSourceMapping WITH CHECK ADD CONSTRAINT FK_RacecourseSourceMapping_Racecourse FOREIGN KEY (RacecourseId) REFERENCES dbo.Racecourse(RacecourseId);'),
    (N'FK_RacecourseSourceMapping_DataSource', N'ALTER TABLE dbo.RacecourseSourceMapping WITH CHECK ADD CONSTRAINT FK_RacecourseSourceMapping_DataSource FOREIGN KEY (DataSourceId) REFERENCES dbo.DataSource(DataSourceId);'),
    (N'FK_RaceRawFetchLink_Race', N'ALTER TABLE dbo.RaceRawFetchLink WITH CHECK ADD CONSTRAINT FK_RaceRawFetchLink_Race FOREIGN KEY (RaceId) REFERENCES dbo.Race(RaceId);'),
    (N'FK_RaceRawFetchLink_RawFetch', N'ALTER TABLE dbo.RaceRawFetchLink WITH CHECK ADD CONSTRAINT FK_RaceRawFetchLink_RawFetch FOREIGN KEY (RawFetchId) REFERENCES dbo.RawFetch(RawFetchId);'),
    (N'FK_RaceEntryRawFetchLink_RaceEntry', N'ALTER TABLE dbo.RaceEntryRawFetchLink WITH CHECK ADD CONSTRAINT FK_RaceEntryRawFetchLink_RaceEntry FOREIGN KEY (RaceEntryId) REFERENCES dbo.RaceEntry(RaceEntryId);'),
    (N'FK_RaceEntryRawFetchLink_RawFetch', N'ALTER TABLE dbo.RaceEntryRawFetchLink WITH CHECK ADD CONSTRAINT FK_RaceEntryRawFetchLink_RawFetch FOREIGN KEY (RawFetchId) REFERENCES dbo.RawFetch(RawFetchId);');

DECLARE @ConstraintName SYSNAME;
DECLARE @Definition NVARCHAR(MAX);

DECLARE constraint_cursor CURSOR LOCAL FAST_FORWARD FOR
    SELECT ConstraintName, Definition
    FROM @ConstraintDefinitions
    ORDER BY
        CASE
            WHEN ConstraintName LIKE N'PK[_]%' THEN 1
            WHEN ConstraintName LIKE N'UQ[_]%' THEN 2
            WHEN ConstraintName LIKE N'CK[_]%' THEN 3
            WHEN ConstraintName LIKE N'FK[_]%' THEN 4
            ELSE 5
        END,
        ConstraintName;

OPEN constraint_cursor;
FETCH NEXT FROM constraint_cursor INTO @ConstraintName, @Definition;

WHILE @@FETCH_STATUS = 0
BEGIN
    IF NOT EXISTS (
        SELECT 1
        FROM sys.objects
        WHERE name = @ConstraintName
          AND schema_id = SCHEMA_ID(N'dbo')
    )
    BEGIN
        EXEC sys.sp_executesql @Definition;
    END;

    FETCH NEXT FROM constraint_cursor INTO @ConstraintName, @Definition;
END;

CLOSE constraint_cursor;
DEALLOCATE constraint_cursor;
GO
