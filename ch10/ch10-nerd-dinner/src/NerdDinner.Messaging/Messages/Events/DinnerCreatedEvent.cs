using NerdDinner.Core.Entities;
using System;

namespace NerdDinner.Messaging.Messages
{
    public class DinnerCreatedEvent : Message
    {
        public override string Subject { get { return MessageSubject; } }

        public DateTime CreatedAt { get; set; }

        public Dinner Dinner { get; set; }

        public static string MessageSubject = "events.dinner.created";
    }
}
