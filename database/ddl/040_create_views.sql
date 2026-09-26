USE [$(DatabaseName)];
GO

SET ANSI_NULLS ON;
SET QUOTED_IDENTIFIER ON;
GO

CREATE OR ALTER VIEW dbo.FinalRaceOddsView
AS
SELECT
    ro.RaceOddsId,
    ro.RaceId,
    ro.BetTypeCode,
    bt.SelectionTypeCode,
    ro.SelectionKey,
    ro.OddsMin,
    ro.OddsMax,
    ro.Popularity,
    ro.RecordedAt,
    ro.DataSourceId
FROM dbo.RaceOdds AS ro
INNER JOIN dbo.BetType AS bt
    ON bt.BetTypeCode = ro.BetTypeCode
WHERE ro.IsFinal = 1;
GO

CREATE OR ALTER VIEW dbo.HorseAnalysisView
AS
SELECT
    h.HorseId,
    h.HorseName,
    h.BirthDate,
    h.BirthYear,
    h.SexCode,
    h.CountryCode,
    h.SireHorseId,
    sire.HorseName AS SireHorseName,
    h.DamHorseId,
    dam.HorseName AS DamHorseName,
    dam.SireHorseId AS DamSireHorseId,
    damsire.HorseName AS DamSireHorseName
FROM dbo.Horse AS h
LEFT JOIN dbo.Horse AS sire ON sire.HorseId = h.SireHorseId
LEFT JOIN dbo.Horse AS dam ON dam.HorseId = h.DamHorseId
LEFT JOIN dbo.Horse AS damsire ON damsire.HorseId = dam.SireHorseId;
GO
