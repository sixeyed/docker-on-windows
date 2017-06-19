using System;

namespace Healthcheck.WebApi.Models
{
    public class DiagnosticsModel
    {
        public string ApplicationName { get; set; }

        public string ApplicationEnvironment { get; set; }

        public string ApplicationVersionNumber { get; set; }

        public int HealthCheckCode { get; set; }

        public string Status { get; set; }    

        public string MachineName { get; set; }

        public DateTime MachineDate { get; set; }

        public string MachineCulture { get; set; }

        public string MachineTimeZone { get; set; }
    }
}