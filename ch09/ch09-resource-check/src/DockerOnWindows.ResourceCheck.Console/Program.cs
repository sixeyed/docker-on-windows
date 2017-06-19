using DockerOnWindows.ResourceCheck.Console.Models;
using DockerOnWindows.ResourceCheck.Console.ResourceHogs;

namespace DockerOnWindows.ResourceCheck.Console
{
    class Program
    {
        static void Main(string[] args)
        {
            var commandLine = Args.Configuration.Configure<CommandLine>().CreateAndBind(args);

            IResourceHog hog = null;
            switch (commandLine.Resource)
            {
                case Resource.Memory:                    
                    hog = new MemoryResourceHog(commandLine.Parameter);
                    break;

                case Resource.Cpu:
                    hog = new CpuResourceHog(commandLine.Parameter);
                    break;
            }
            hog.Go();
        }
    }
}
