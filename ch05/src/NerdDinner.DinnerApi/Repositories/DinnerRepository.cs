using Dapper;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.Logging;
using NerdDinner.Core.Entities;
using System.Collections.Generic;
using System.Data;

namespace NerdDinner.DinnerApi.Repositories
{
    public class DinnerRepository : RepositoryBase<Dinner>
    {
        public DinnerRepository(IConfiguration configuration, ILogger<DinnerRepository> logger) : base(configuration, logger)
        {
        }

        protected override string GetAllSqlQuery => "SELECT *, DinnerID as Id, DinnerID as LocationId, Location.Lat as Latitude,  Location.Long as Longitude FROM Dinners";

        public override IEnumerable<Dinner> GetAll()
        {
            _logger.LogDebug("GetAll - executing SQL query: '{0}'", GetAllSqlQuery);
            using (IDbConnection dbConnection = Connection)
            {
                dbConnection.Open();
                return dbConnection.Query<Dinner, Coordinates, Dinner>(
                    GetAllSqlQuery, 
                    (dinner,coordinates) => {
                        dinner.Coordinates = coordinates;
                        return dinner;
                    },
                    splitOn: "LocationId"); //fake ID to give Dapper something to split on
            }
        }
    }
}
