using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;

namespace razor.Pages
{
    public class IndexModel : PageModel
    {
        private static string _NerdDinnerUrl;

        static IndexModel()
        {
            _NerdDinnerUrl = Environment.GetEnvironmentVariable("NERD_DINNER_URL");
        }

        public string NerdDinnerUrl { get; set; }

        public void OnGet()
        {
            NerdDinnerUrl = _NerdDinnerUrl;
        }
    }
}
