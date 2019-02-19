using AutoMapper;
using entities = NerdDinner.Core.Entities;
using models = NerdDinner.Models;

namespace NerdDinner.ValueResolvers
{
    public class CoordinatesValueResolver : IValueResolver<models.Dinner, entities.Dinner, entities.Coordinates>
    {
        public entities.Coordinates Resolve(models.Dinner source, entities.Dinner destination, entities.Coordinates member, ResolutionContext context)
        {
            return new entities.Coordinates
            {
                Latitude = source.Location.Latitude.Value,
                Longitude = source.Location.Longitude.Value
            };
        }        
    }
}