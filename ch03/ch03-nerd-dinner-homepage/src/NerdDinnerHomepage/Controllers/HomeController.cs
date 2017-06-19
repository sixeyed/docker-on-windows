using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;

namespace NerdDinnerHomepage.Controllers
{
    public class HomeController : Controller
    {
        public IActionResult Index()
        {
            ViewData["NerdDinnerUrl"] = Environment.GetEnvironmentVariable("NERD_DINNER_URL");
            return View();
        }
    }
}
