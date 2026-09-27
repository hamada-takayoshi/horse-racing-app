namespace HorseRacing.App.Application.Races;

public interface IRaceRepository
{
    Task<IReadOnlyList<RaceListItem>> SearchAsync(
        RaceSearchCriteria criteria,
        CancellationToken cancellationToken = default);
}