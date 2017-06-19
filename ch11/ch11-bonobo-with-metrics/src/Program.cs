using DotNetExporter.Console.Collectors;
using Prometheus;
using Prometheus.Advanced;
using System.Collections.Generic;
using System.Linq;
using System.Threading;
using static System.Console;

namespace DotNetExporter.Console
{
    class Program
    {
        private static ManualResetEvent _ResetEvent = new ManualResetEvent(false);

        static void Main(string[] args)
        {
            if (!Config.MetricsTargets.Any())
            {
                WriteLine("No targets configured. Set $env:METRICS_TARGETS, format 'w3wp,process2");
                return;
            }

            var collectors = new List<IOnDemandCollector>();
            foreach (var process in Config.MetricsTargets)
            {
                WriteLine($"Adding collectors for process: {process}");
                collectors.Add(new ProcessPerfCounterCollector(process));
            }

            var server = new MetricServer(Config.MetricsPort, collectors);
            server.Start();
            WriteLine($"Metrics server listening on port: {Config.MetricsPort}");

            _ResetEvent.WaitOne();
        }
    }
}
