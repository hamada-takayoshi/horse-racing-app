using HorseRacing.App.Application.RaceEntries;

namespace HorseRacing.Tests.Application.RaceEntries;

public class RaceEntryStatusCodesTests
{
    [Theory]
    [InlineData("REGISTERED")]
    [InlineData("EXPECTED")]
    [InlineData("CONFIRMED")]
    [InlineData("SCRATCHED")]
    [InlineData("EXCLUDED")]
    public void IsValidEntryStatusCode_AcceptsDefinedCodes(string code)
    {
        Assert.True(RaceEntryStatusCodes.IsValidEntryStatusCode(code));
    }

    [Theory]
    [InlineData(null)]
    [InlineData("")]
    [InlineData("registered")]
    [InlineData("UNKNOWN")]
    public void IsValidEntryStatusCode_RejectsUndefinedCodes(string? code)
    {
        Assert.False(RaceEntryStatusCodes.IsValidEntryStatusCode(code));
    }

    [Theory]
    [InlineData("FINISHED")]
    [InlineData("DNF")]
    [InlineData("DISQUALIFIED")]
    [InlineData("DEMOTED")]
    public void IsValidResultStatusCode_AcceptsDefinedCodes(string code)
    {
        Assert.True(RaceEntryStatusCodes.IsValidResultStatusCode(code));
    }

    [Fact]
    public void IsValidResultStatusCode_AllowsUnknownResult()
    {
        Assert.True(RaceEntryStatusCodes.IsValidResultStatusCode(null));
    }

    [Theory]
    [InlineData("")]
    [InlineData("finished")]
    [InlineData("UNKNOWN")]
    public void IsValidResultStatusCode_RejectsUndefinedCodes(string code)
    {
        Assert.False(RaceEntryStatusCodes.IsValidResultStatusCode(code));
    }
}