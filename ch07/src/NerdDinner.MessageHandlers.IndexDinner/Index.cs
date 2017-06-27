using NerdDinner.MessageHandlers.IndexDinner.Documents;
using Nest;
using System;

namespace NerdDinner.MessageHandlers.IndexDinner
{
    public class Index
    {
        public static void Setup()
        {
            var node = new Uri(Env.ElasticsearchUrl);
            var settings = new ConnectionSettings(node);
            var client = new ElasticClient(settings);

            var descriptor = new CreateIndexDescriptor("dinners")
                                    .Mappings(ms => ms.Map<Dinner>(m => m.AutoMap()));

            client.CreateIndex(descriptor);            
        }
    }
}