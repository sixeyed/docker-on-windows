using System.ComponentModel;

namespace DockerOnWindows.ResourceCheck.Console.Models
{
    public class CommandLine
    {
        public Resource Resource { get; set; }

        [DefaultValue(1000)]
        public int Parameter { get; set; }
    }
}
