using Microsoft.Extensions.Configuration;

namespace NerdDinner.Core
{
    public class Config
    {
        public static IConfiguration Current { get; private set; }

        static Config()
        {
            var config = new ConfigurationBuilder();
            AddProviders(config);
            Current = config.Build();
        }

        public static IConfigurationBuilder AddProviders(IConfigurationBuilder config)
        {
            return config.AddJsonFile("config/appsettings.json")
                         .AddEnvironmentVariables()
                         .AddJsonFile("config/config.json", optional: true)
                         .AddJsonFile("config/secrets.json", optional: true);
        }
    }
}
