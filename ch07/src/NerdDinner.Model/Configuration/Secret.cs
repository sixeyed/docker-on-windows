using System;
using System.Configuration;
using System.IO;

namespace NerdDinner.Models
{
    public class Secret
    {
        private const string SECRET_ROOT_PATH = @"C:\ProgramData\Docker\secrets";

        public static string DbConnectionString { get { return Get("nerd-dinner.connectionstring"); } }

        private static string Get(string name)
        {
            var path = Path.Combine(SECRET_ROOT_PATH, name);
            if (!File.Exists(path))
            {
                throw new ConfigurationException($"Secret not found, name: {name}");
            }
            return File.ReadAllText(path);
        }
    }
}