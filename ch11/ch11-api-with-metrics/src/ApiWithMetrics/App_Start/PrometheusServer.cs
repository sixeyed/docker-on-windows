using Prometheus;
using Prometheus.Advanced;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace ApiWithMetrics
{
    public static class PrometheusServer
    {
        private static IMetricServer _Server;

        public static void Start()
        {
            _Server = new MetricServer(50505, new IOnDemandCollector[] { new DotNetStatsCollector(), new PerfCounterCollector() });
            _Server.Start();
        }
    }
}