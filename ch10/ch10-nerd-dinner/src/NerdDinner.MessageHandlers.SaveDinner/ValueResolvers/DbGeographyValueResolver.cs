using AutoMapper;
using System.Data.Spatial;
using entities = NerdDinner.Core.Entities;
using models = NerdDinner.Models;

namespace NerdDinner.MessageHandlers.SaveDinner.ValueResolvers
{
    public class DbGeographyValueResolver : IValueResolver<entities.Dinner, models.Dinner, DbGeography>
    {
        public DbGeography Resolve(entities.Dinner source, models.Dinner destination, DbGeography member, ResolutionContext context)
        {
            return DbGeography.FromText($"POINT({source.Coordinates.Longitude} {source.Coordinates.Latitude})", 4326);
        }        
    }
}