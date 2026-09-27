namespace HorseRacing.App.Application.Races;

public sealed record RaceListItem(
    long RaceId,
    DateTime RaceDate,
    byte RaceNumber,
    string RaceName,
    string RacecourseName,
    string SurfaceTypeCode,
    int Distance,
    byte? NumberOfStarters);