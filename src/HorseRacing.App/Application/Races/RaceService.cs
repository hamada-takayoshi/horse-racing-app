namespace HorseRacing.App.Application.Races;

public sealed class RaceService(IRaceRepository raceRepository)
{
    public Task<IReadOnlyList<RaceListItem>> SearchAsync(
        RaceSearchCriteria criteria,
        CancellationToken cancellationToken = default)
    {
        if (criteria.FromDate is { } fromDate
            && criteria.ToDate is { } toDate
            && fromDate > toDate)
        {
            throw new ArgumentException("開始日は終了日以前の日付を指定してください。", nameof(criteria));
        }

        return raceRepository.SearchAsync(criteria, cancellationToken);
    }
}