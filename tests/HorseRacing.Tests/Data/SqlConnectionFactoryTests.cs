using HorseRacing.App.Data;
using Microsoft.Extensions.Configuration;

namespace HorseRacing.Tests.Data;

public class SqlConnectionFactoryTests
{
    [Fact]
    public void CreateConnection_ThrowsWhenConnectionStringIsMissing()
    {
        var configuration = new ConfigurationBuilder().Build();
        var factory = new SqlConnectionFactory(configuration);

        var exception = Assert.Throws<InvalidOperationException>(() => factory.CreateConnection());

        Assert.Contains("HorseRacing", exception.Message, StringComparison.Ordinal);
    }
}