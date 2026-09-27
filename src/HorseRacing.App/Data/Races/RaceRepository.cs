using Dapper;
using HorseRacing.App.Application.Races;

namespace HorseRacing.App.Data.Races;

public sealed class RaceRepository(SqlConnectionFactory connectionFactory) : IRaceRepository
{
    private const string SearchSql = """
        SELECT TOP (100)
            r.RaceId,
            r.RaceDate,
            r.RaceNumber,
            r.RaceName,
            rc.RacecourseName,
            r.SurfaceTypeCode,
            r.Distance,
            r.NumberOfStarters
        FROM dbo.Race AS r
        INNER JOIN dbo.Racecourse AS rc
            ON rc.RacecourseId = r.RacecourseId
        WHERE (@FromDate IS NULL OR r.RaceDate >= @FromDate)
          AND (@ToDateExclusive IS NULL OR r.RaceDate < @ToDateExclusive)
        ORDER BY r.RaceDate DESC, r.RacecourseId, r.RaceNumber;
        """;

    public async Task<IReadOnlyList<RaceListItem>> SearchAsync(
        RaceSearchCriteria criteria,
        CancellationToken cancellationToken = default)
    {
        await using var connection = connectionFactory.CreateConnection();
        await connection.OpenAsync(cancellationToken);

        var parameters = new
        {
            FromDate = criteria.FromDate?.ToDateTime(TimeOnly.MinValue),
            ToDateExclusive = criteria.ToDate?.AddDays(1).ToDateTime(TimeOnly.MinValue)
        };

        var rows = await connection.QueryAsync<RaceListItem>(
            new CommandDefinition(SearchSql, parameters, cancellationToken: cancellationToken));

        return rows.AsList();
    }
}