using DockerOnWindows.ResourceCheck.Console.Math;
using System.Diagnostics;
using System.Linq;
using static System.Console;

namespace DockerOnWindows.ResourceCheck.Console.ResourceHogs
{
    public class CpuResourceHog : IResourceHog
    {
        private int _dp;

        public CpuResourceHog(int piDpToCompute)
        {
            _dp = piDpToCompute;
        }

        public void Go()
        {
            var stopwatch = Stopwatch.StartNew();
            HighPrecision.Precision = _dp;
            HighPrecision first = 4 * Atan.Calculate(5);
            HighPrecision second = Atan.Calculate(239);

            var pi = 4 * (first - second);
            stopwatch.Stop();

            WriteLine($"I calculated Pi to {_dp} decimal places in {stopwatch.ElapsedMilliseconds}ms. The last digit is {pi.ToString().Last()}.");            
        }
    }
}
