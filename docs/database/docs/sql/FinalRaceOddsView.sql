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
