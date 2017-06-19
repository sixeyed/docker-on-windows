using System;
using System.Collections.Generic;

namespace DotNetExporter.Console
{
    public class Config
    {
        private static Dictionary<string, string> _Values = new Dictionary<string, string>();

        // $env:METRICS_PORT="50504"
        public static int MetricsPort
        {
            get
            {
                if (!int.TryParse(Get("METRICS_PORT"), out int port))
                {
                    port = 50505;
                }
                return port;
            }
        }

        // $env:TARGETS="w3wp.exe,whatever.exe"
        public static IEnumerable<string> MetricsTargets
        {
            get
            {
                var targets = new List<string>();
                var setting = Get("METRICS_TARGETS");                
                if (!string.IsNullOrEmpty(setting))
                {
                    targets.AddRange(setting.Split(','));
                }
                return targets;
            }
        }

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
