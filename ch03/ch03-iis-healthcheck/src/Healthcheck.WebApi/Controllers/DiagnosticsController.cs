using Healthcheck.WebApi.Models;
using System;
using System.Globalization;
using System.Web.Http;

namespace Healthcheck.WebApi.Controllers
{
    public class DiagnosticsController : ApiController
    {
        [HttpGet]
        [Route("diagnostics")]
        public IHttpActionResult Get()
        {
            if (ToggleController.IsHealthy)
            {
                var diagnostics = new DiagnosticsModel();
                diagnostics.MachineDate = DateTime.Now;
                diagnostics.MachineName = Environment.MachineName;
                diagnostics.MachineCulture = string.Format("{0} - {1}", CultureInfo.CurrentCulture.DisplayName, CultureInfo.CurrentCulture.Name);
                diagnostics.MachineTimeZone = TimeZoneInfo.Local.IsDaylightSavingTime(diagnostics.MachineDate) ? TimeZoneInfo.Local.DaylightName : TimeZoneInfo.Local.StandardName;
                diagnostics.ApplicationName = "Healthcheck API";
                diagnostics.ApplicationEnvironment = Environment.GetEnvironmentVariable("APP_ENVIRONMENT");
                diagnostics.ApplicationVersionNumber = typeof(DiagnosticsController).Assembly.GetName().Version.ToString();
                diagnostics.HealthCheckCode = ToggleController.IsHealthy ? 0 : 1;
                diagnostics.Status = diagnostics.HealthCheckCode == 0 ? "GREEN" : "RED";
                return Ok(diagnostics);
            }
            else
            {
                return InternalServerError();
            }            
        }
    }
}
