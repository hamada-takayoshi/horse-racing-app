using HorseRacing.App.Application.Races;

namespace HorseRacing.Tests.Application.Races;

public class RaceServiceTests
{
    [Fact]
    public async Task SearchAsync_ForwardsCriteriaAndReturnsRepositoryResults()
    {
        var race = new RaceListItem(
            42,
            new DateTime(2025, 5, 4),
            3,
            "サンプルステークス",
            "東京",
            "TURF",
            1600,
            16);
        var repository = new FakeRaceRepository { Results = [race] };
        var service = new RaceService(repository);
        var criteria = new RaceSearchCriteria(new DateOnly(2025, 5, 1), new DateOnly(2025, 5, 31));

        var results = await service.SearchAsync(criteria);

        Assert.Same(criteria, repository.LastCriteria);
        Assert.Equal([race], results);
        Assert.Equal(1, repository.CallCount);
    }

    [Fact]
    public async Task SearchAsync_RejectsReversedDateRangeWithoutQueryingRepository()
    {
        var repository = new FakeRaceRepository();
        var service = new RaceService(repository);
        var criteria = new RaceSearchCriteria(new DateOnly(2025, 6, 1), new DateOnly(2025, 5, 1));

        var exception = await Assert.ThrowsAsync<ArgumentException>(
            () => service.SearchAsync(criteria));

        Assert.Equal("criteria", exception.ParamName);
        Assert.Equal(0, repository.CallCount);
    }

    [Fact]
    public async Task SearchAsync_AllowsOpenEndedDateRange()
    {
        var repository = new FakeRaceRepository();
        var service = new RaceService(repository);
        var criteria = new RaceSearchCriteria(new DateOnly(2025, 1, 1), null);

        await service.SearchAsync(criteria);

        Assert.Same(criteria, repository.LastCriteria);
        Assert.Equal(1, repository.CallCount);
    }

    private sealed class FakeRaceRepository : IRaceRepository
    {
        public IReadOnlyList<RaceListItem> Results { get; init; } = [];
        public RaceSearchCriteria? LastCriteria { get; private set; }
        public int CallCount { get; private set; }

        public Task<IReadOnlyList<RaceListItem>> SearchAsync(
            RaceSearchCriteria criteria,
            CancellationToken cancellationToken = default)
        {
            LastCriteria = criteria;
            CallCount++;
            return Task.FromResult(Results);
        }
    }
}