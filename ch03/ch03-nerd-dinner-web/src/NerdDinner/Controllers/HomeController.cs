using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.Mvc;

namespace NerdDinner.Controllers
{
    public class HomeController : Controller
    {
        /* v2 */
        private static string _NewHomePageHtml;
        private StreamWriter _Log;

        static HomeController()
        {
            System.IO.File.WriteAllText("C:\\nerd-dinner\\log.txt", "HomeController");
            var homepageUrl = Environment.GetEnvironmentVariable("HOMEPAGE_URL", EnvironmentVariableTarget.Process);
            System.IO.File.AppendAllText("C:\\nerd-dinner\\log.txt", $"HOMEPAGE_URL: {homepageUrl}");
            if (!string.IsNullOrEmpty(homepageUrl))
            {
                var request = WebRequest.Create(homepageUrl);
                using (var response = request.GetResponse())
                using (var responseStream = new StreamReader(response.GetResponseStream()))
                {
                    _NewHomePageHtml = responseStream.ReadToEnd();
                    System.IO.File.AppendAllText("C:\\nerd-dinner\\log.txt", $"_NewHomePageHtml: {_NewHomePageHtml}");
                }
            } 
        }
        
        public ActionResult Index()
        {
            System.IO.File.AppendAllText("C:\\nerd-dinner\\log.txt", "Index");
            if (!string.IsNullOrEmpty(_NewHomePageHtml))
            {
                System.IO.File.AppendAllText("C:\\nerd-dinner\\log.txt", "new");
                return Content(_NewHomePageHtml);
            }
            else
            {
                System.IO.File.AppendAllText("C:\\nerd-dinner\\log.txt", "find");
                return Find();
            }
        }

        public ActionResult Find()
        {
            ViewBag.Message = "Organizing the world's nerds and helping them eat in packs.";

            return View("Index");
        }

        public ActionResult About()
        {
            return View();
        }  
    }
}