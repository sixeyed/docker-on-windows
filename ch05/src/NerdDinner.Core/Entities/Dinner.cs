using System;

namespace NerdDinner.Core.Entities
{
    public class Dinner
    {
        public string Title { get; set; }

        public DateTime EventDate { get; set; }

        public string Description { get; set; }

        public string HostedBy { get; set; }

        public string ContactPhone { get; set; }

        public string Address { get; set; }

        public string Country { get; set; }

        public Coordinates Coordinates { get; set; }
    }                
}