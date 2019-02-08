using Microsoft.Extensions.Configuration;

namespace NerdDinner.Core
{
    public class Config
    {
        public static IConfiguration Current { get; private set; }

        static Config()
        {
            Current = new ConfigurationBuilder()
                .AddJsonFile("config/appsettings.json")
                .AddEnvironmentVariables()
                .Build();
        }
    }
}
