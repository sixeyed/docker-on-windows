using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Logging;
using NerdDinner.DinnerApi.Repositories;
using NerdDinner.Core.Entities;
using System.Collections.Generic;

namespace NerdDinner.DinnerApi.Controllers
{
    [Produces("application/json")]
    [Route("api/dinners")]
    public class CountriesController : Controller
    {
        private readonly IRepository<Dinner> _repository;
        private readonly ILogger _logger;

        public CountriesController(IRepository<Dinner> repository, ILogger<CountriesController> logger)
        {
            _repository = repository;
            _logger = logger;
        }

        [HttpGet]
        public IEnumerable<Dinner> Get()
        {
            _logger.LogInformation("Received request: get");
            return _repository.GetAll();
        }
    }
}