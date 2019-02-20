using Prometheus;

namespace ApiWithMetrics
{
    public static class PrometheusServer
    {
        private static IMetricServer _Server;

        public static void Start()
        {
            _Server = new MetricServer(50505);
            _Server.Start();
        }
    }
}