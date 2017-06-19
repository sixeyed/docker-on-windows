using System.Web.Http;

namespace ApiWithMetrics
{
    public class WebApiApplication : System.Web.HttpApplication
    {
        protected void Application_Start()
        {
            GlobalConfiguration.Configure(WebApiConfig.Register);
            PrometheusServer.Start();
        }
    }
}
