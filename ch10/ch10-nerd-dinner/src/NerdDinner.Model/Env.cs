using System;
using System.Collections.Generic;

namespace NerdDinner.Models
{
    public class Env
    {
        private static Dictionary<string, string> _Values = new Dictionary<string, string>();

        public static string AuthDbConnectionString { get { return Get("AUTH_DB_CONNECTION_STRING"); } }

        public static string AppDbConnectionString { get { return Get("APP_DB_CONNECTION_STRING"); } }

        private static string Get(string variable)
        {
            if (!_Values.ContainsKey(variable))
            {
                var value = Environment.GetEnvironmentVariable(variable, EnvironmentVariableTarget.Machine);
                if (string.IsNullOrEmpty(value))
                {
                    value = Environment.GetEnvironmentVariable(variable, EnvironmentVariableTarget.Process);
                }
                _Values[variable] = value;
            }
            return _Values[variable];
        }
    }
}