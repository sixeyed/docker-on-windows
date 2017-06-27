using AutoMapper;
using NATS.Client;
using NerdDinner.MessageHandlers.SaveDinner.ValueResolvers;
using NerdDinner.Messaging;
using NerdDinner.Messaging.Messages;
using NerdDinner.Models;
using System;
using System.Collections.Generic;
using System.Threading;
using entities = NerdDinner.Messaging.Entities;
using models = NerdDinner.Models;

namespace NerdDinner.MessageHandlers.SaveDinner
{
    class Program
    {
        private static ManualResetEvent _ResetEvent = new ManualResetEvent(false);
        private const string QUEUE_GROUP = "save-dinner-handler";

        static void Main(string[] args)
        {
            Mapper.Initialize(cfg =>
                    cfg.CreateMap<entities.Dinner, models.Dinner>()
                       .ForMember(dest => dest.Location, opt => opt.ResolveUsing<DbGeographyValueResolver>()));

            Console.WriteLine($"Connecting to message queue url: {Messaging.Env.MessageQueueUrl}");
            using (var connection = MessageQueue.CreateConnection())
            {
                var subscription = connection.SubscribeAsync(DinnerCreatedEvent.MessageSubject, QUEUE_GROUP);
                subscription.MessageHandler += SaveDinner;
                subscription.Start();
                Console.WriteLine($"Listening on subject: {DinnerCreatedEvent.MessageSubject}, queue: {QUEUE_GROUP}");

                _ResetEvent.WaitOne();
                connection.Close();
            }
        }

        private static void SaveDinner(object sender, MsgHandlerEventArgs e)
        {
            try
            {
                Console.WriteLine($"Received message, subject: {e.Message.Subject}");
                var eventMessage = MessageHelper.FromData<DinnerCreatedEvent>(e.Message.Data);
                Console.WriteLine($"Saving new dinner, created at: {eventMessage.CreatedAt}; event ID: {eventMessage.CorrelationId}");

                var dinner = Mapper.Map<models.Dinner>(eventMessage.Dinner);
                using (var db = new NerdDinnerContext())
                {
                    dinner.RSVPs = new List<RSVP>
                    {
                        new RSVP
                        {
                            AttendeeName = dinner.HostedBy
                        }
                    };

                    db.Dinners.Add(dinner);
                    db.SaveChanges();
                }

                Console.WriteLine($"Dinner saved. Dinner ID: {dinner.DinnerID}; event ID: {eventMessage.CorrelationId}");
            }
            catch (Exception ex)
            {
                Console.WriteLine($"Exception processing event: {ex}");
            }
        }
    }
}
