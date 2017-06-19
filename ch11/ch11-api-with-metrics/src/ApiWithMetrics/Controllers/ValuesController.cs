using Prometheus;
using System.Net;
using System.Web.Http;

namespace ApiWithMetrics.Controllers
{
    public class ValuesController : ApiController
    {
        private Counter _requestCounter = Metrics.CreateCounter("ValuesController_Requests", "Request count", "method", "url");
        private Counter _responseCounter = Metrics.CreateCounter("ValuesController_Responses", "Response count", "code", "url");

        public IHttpActionResult Get()
        {
            _requestCounter.Labels("GET", "/").Inc();
            _responseCounter.Labels("200", "/").Inc();
            return Ok(new string[] { "value1", "value2" });
        }
        
        public IHttpActionResult Get(int id)
        {
            _requestCounter.Labels("GET", $"/{id}").Inc();
            if (id==10)
            {
                _responseCounter.Labels("404", $"/{id}").Inc();
                return NotFound();
            }
            else if (id > 10)
            {
                _responseCounter.Labels("403", $"/{id}").Inc();
                return StatusCode(HttpStatusCode.Forbidden);
            }
            _responseCounter.Labels("200", $"/{id}").Inc();
            return Ok("value");
        }
    }
}
