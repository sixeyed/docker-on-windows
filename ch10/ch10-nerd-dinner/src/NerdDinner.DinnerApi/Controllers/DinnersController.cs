using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Logging;
using NerdDinner.DinnerApi.Repositories;
using NerdDinner.Core.Entities;
using System.Collections.Generic;

namespace NerdDinner.DinnerApi.Controllers
{
    [Produces("application/json")]
    [Route("api/dinners")]
    public class DinnersController : Controller
    {
        private readonly IRepository<Dinner> _repository;
        private readonly ILogger _logger;

        public DinnersController(IRepository<Dinner> repository, ILogger<DinnersController> logger)
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