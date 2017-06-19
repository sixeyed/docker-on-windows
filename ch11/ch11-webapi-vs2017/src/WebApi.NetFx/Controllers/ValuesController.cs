using System.Net;
using System.Web.Http;

namespace WebApi.NetFx.Controllers
{
    public class ValuesController : ApiController
    {       
        public IHttpActionResult Get()
        {
            return Ok(new string[] { "value1", "value2" });
        }
        
        public IHttpActionResult Get(int id)
        {
            return Ok($"value: {id}, yeah!");
        }
    }
}
