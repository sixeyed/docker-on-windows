using AutoMapper;
using Nest;
using documents = NerdDinner.MessageHandlers.IndexDinner.Documents;
using entities = NerdDinner.Core.Entities;

namespace NerdDinner.MessageHandlers.IndexDinner.ValueResolvers
{
    public class GeoLocationValueResolver : IValueResolver<entities.Dinner, documents.Dinner, GeoLocation>
    {
        public GeoLocation Resolve(entities.Dinner source, documents.Dinner destination, GeoLocation member, ResolutionContext context)
        {
            return new GeoLocation(source.Coordinates.Latitude, source.Coordinates.Longitude);
        }        
    }
}