CREATE OR ALTER VIEW dbo.HorseAnalysisView AS
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
FROM dbo.Horse h
LEFT JOIN dbo.Horse sire ON sire.HorseId = h.SireHorseId
LEFT JOIN dbo.Horse dam ON dam.HorseId = h.DamHorseId
LEFT JOIN dbo.Horse damsire ON damsire.HorseId = dam.SireHorseId;
