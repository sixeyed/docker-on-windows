using System.Web.Http;

namespace Healthcheck.WebApi.Controllers
{
    public class ToggleController : ApiController
    {
        public static bool IsHealthy { get; private set; }

        static ToggleController()
        {
            IsHealthy = true;
        }

        [HttpPost]
        [Route("toggle/unhealthy")]
        public void Unhealthy()
        {
            IsHealthy = false;
        }

        [HttpPost]
        [Route("toggle/healthy")]
        public void Healthy()
        {
            IsHealthy = true;
        }
    }
}
