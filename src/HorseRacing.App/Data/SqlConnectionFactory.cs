using Microsoft.Data.SqlClient;

namespace HorseRacing.App.Data;

public sealed class SqlConnectionFactory
{
    private readonly IConfiguration _configuration;

    public SqlConnectionFactory(IConfiguration configuration)
    {
        _configuration = configuration;
    }

    public SqlConnection CreateConnection()
    {
        var connectionString = _configuration.GetConnectionString("HorseRacing");
        if (string.IsNullOrWhiteSpace(connectionString))
        {
            throw new InvalidOperationException(
                "Connection string 'HorseRacing' is not configured.");
        }

        return new SqlConnection(connectionString);
    }
}