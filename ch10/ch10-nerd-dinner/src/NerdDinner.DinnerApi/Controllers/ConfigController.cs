using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Logging;
using NerdDinner.DinnerApi.Repositories;
using NerdDinner.Core.Entities;
using System.Collections.Generic;
using Microsoft.Extensions.Configuration;

namespace NerdDinner.DinnerApi.Controllers
{
    [Produces("application/json")]
    [Route("api/config")]
    public class ConfigController : Controller
    {
        private readonly IConfiguration _config;
        
        public ConfigController(IConfiguration config)
        {
            _config = config;
        }

        [HttpGet("{key}")]
        public string Get(string key)
        {
            return _config[key.Replace('-', ':')];
        }
    }
}