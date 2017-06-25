using Nest;
using System;

namespace NerdDinner.MessageHandlers.IndexDinner.Documents
{
    [ElasticsearchType(Name = "dinner")]
    public class Dinner
    {
        [Text]
        public string Title { get; set; }

        [Date]
        public DateTime EventDate { get; set; }
        
        [Keyword]
        public string Country { get; set; }

        [GeoPoint]
        public GeoLocation Location { get; set; }
    }                
} 