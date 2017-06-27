using AutoMapper;
using NATS.Client;
using NerdDinner.MessageHandlers.IndexDinner.ValueResolvers;
using NerdDinner.Messaging;
using NerdDinner.Messaging.Messages;
using Nest;
using System;
using System.Threading;
using documents = NerdDinner.MessageHandlers.IndexDinner.Documents;
using entities = NerdDinner.Messaging.Entities;

namespace NerdDinner.MessageHandlers.IndexDinner
{
    public class Program
    {
        private static ManualResetEvent _ResetEvent = new ManualResetEvent(false);
        private const string QUEUE_GROUP = "index-dinner-handler";

        static void Main(string[] args)
        {
            Mapper.Initialize(cfg =>
                    cfg.CreateMap<entities.Dinner, documents.Dinner>()
                       .ForMember(dest => dest.Location, opt => opt.ResolveUsing<GeoLocationValueResolver>()));

            Index.Setup();

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
                Console.WriteLine($"Indexing new dinner, created at: {eventMessage.CreatedAt}; event ID: {eventMessage.CorrelationId}");

                var dinner = Mapper.Map<documents.Dinner>(eventMessage.Dinner);
                var node = new Uri(Env.ElasticsearchUrl);
                var client = new ElasticClient(node);
                client.Index(dinner, idx => idx.Index("dinners"));
            }
            catch (Exception ex)
            {
                Console.WriteLine($"Exception processing event: {ex}");
            }
        }
    }
}
