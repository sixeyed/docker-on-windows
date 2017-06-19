using System;
using System.Collections.Generic;

namespace NerdDinner.Messaging
{
    public class Env
    {
        private static Dictionary<string, string> _Values = new Dictionary<string, string>();

        public static string MessageQueueUrl { get { return Get("MESSAGE_QUEUE_URL"); } }

        private static string Get(string variable)
        {
            if (!_Values.ContainsKey(variable))
            {
#if NET452
                var value = Environment.GetEnvironmentVariable(variable, EnvironmentVariableTarget.Machine);
                if (string.IsNullOrEmpty(value))
                {
                    value = Environment.GetEnvironmentVariable(variable, EnvironmentVariableTarget.Process);
                }
#else
                var value = Environment.GetEnvironmentVariable(variable);
#endif
                _Values[variable] = value;
            }
            return _Values[variable];
        }
    }
}
