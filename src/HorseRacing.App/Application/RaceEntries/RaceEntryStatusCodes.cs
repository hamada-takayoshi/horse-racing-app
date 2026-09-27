using System.Collections.Frozen;

namespace HorseRacing.App.Application.RaceEntries;

public static class RaceEntryStatusCodes
{
    private static readonly FrozenSet<string> ValidEntryStatuses = new[]
    {
        "REGISTERED",
        "EXPECTED",
        "CONFIRMED",
        "SCRATCHED",
        "EXCLUDED"
    }.ToFrozenSet(StringComparer.Ordinal);

    private static readonly FrozenSet<string> ValidResultStatuses = new[]
    {
        "FINISHED",
        "DNF",
        "DISQUALIFIED",
        "DEMOTED"
    }.ToFrozenSet(StringComparer.Ordinal);

    public static bool IsValidEntryStatusCode(string? code) =>
        code is not null && ValidEntryStatuses.Contains(code);

    public static bool IsValidResultStatusCode(string? code) =>
        code is null || ValidResultStatuses.Contains(code);
}