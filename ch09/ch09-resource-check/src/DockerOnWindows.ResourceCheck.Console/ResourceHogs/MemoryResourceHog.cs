using System.Runtime.InteropServices;
using static System.Console;

namespace DockerOnWindows.ResourceCheck.Console.ResourceHogs
{
    public class MemoryResourceHog : IResourceHog
    {
        private int _mbToAllocate;

        public MemoryResourceHog(int mbToAllocate)
        {
            _mbToAllocate = mbToAllocate;
        }

        public void Go()
        {
            Marshal.AllocHGlobal(1024 * 1024 * _mbToAllocate);
            WriteLine($"I allocated {_mbToAllocate}MB of memory, and now I'm done.");
        }
    }
}
