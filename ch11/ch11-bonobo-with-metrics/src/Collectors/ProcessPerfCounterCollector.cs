using Prometheus;
using Prometheus.Advanced;
using System;
using System.Collections.Generic;
using System.Diagnostics;
using static System.Console;

namespace DotNetExporter.Console.Collectors
{
    /// <summary>
    /// Collects metrics on standard Performance Counters for a remote machine and process
    /// </summary>
    public class ProcessPerfCounterCollector : IOnDemandCollector
    {
        private const string MemCat = ".NET CLR Memory";
        private const string ProcCat = "Process";
        
        private static readonly string[] StandardPerfCounters =
        {
            MemCat, "Gen 0 heap size",
            MemCat, "Gen 1 heap size",
            MemCat, "Gen 2 heap size",
            MemCat, "Large Object Heap size",
            MemCat, "% Time in GC",
            ProcCat, "% Processor Time",
            ProcCat, "Private Bytes",
            ProcCat, "Working Set",
            ProcCat, "Virtual Bytes",
        };

        private readonly string _processName;

        readonly List<Tuple<Gauge, PerformanceCounter>> _collectors = new List<Tuple<Gauge, PerformanceCounter>>();
        private Counter _perfErrors;

        public ProcessPerfCounterCollector(string processName)
        {
            _processName = processName;
        }

        private void RegisterPerfCounter(string category, string name)
        {
            Gauge gauge = Metrics.CreateGauge(GetName(category, name), GetHelp(name), "process");
            _collectors.Add(Tuple.Create(gauge, new PerformanceCounter(category, name, _processName)));
        }

        private string GetHelp(string name)
        {
            return name + " Perf Counter";
        }

        private string GetName(string category, string name)
        {
            return ToPromName(category) + "_" + ToPromName(name);
        }

        private string ToPromName(string name)
        {
            return name.Replace("%", "pct").Replace(" ", "_").Replace(".", "dot").ToLowerInvariant();
        }

        public void RegisterMetrics()
        {
            for (int i = 0; i < StandardPerfCounters.Length; i += 2)
            {
                var category = StandardPerfCounters[i];
                var name = StandardPerfCounters[i + 1];

                RegisterPerfCounter(category, name);
            }

            _perfErrors = Metrics.CreateCounter("performance_counter_errors_total",
                "Total number of errors that occured during performance counter collections", "process");
        }

        public void UpdateMetrics()
        {
            foreach (var collector in _collectors)
            {
                try
                {
                    collector.Item1.Labels(_processName).Set(collector.Item2.NextValue());
                }
                catch (Exception ex)
                {
                    _perfErrors.Labels(_processName).Inc();
                    WriteLine($"* Error reading counter. Process: {_processName}, ex: {ex}");
                }
            }
        }
    }
}