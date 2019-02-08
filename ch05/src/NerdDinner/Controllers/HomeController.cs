using NerdDinner.Core;
using System.IO;
using System.Net;
using System.Web.Mvc;

namespace NerdDinner.Controllers
{
    public class HomeController : Controller
    {
        private static string _NewHomePageHtml;

        static HomeController()
        {
            var request = WebRequest.Create(Config.Current["HomePage:Url"]);
            using (var response = request.GetResponse())
            using (var responseStream = new StreamReader(response.GetResponseStream()))
            {
                _NewHomePageHtml = responseStream.ReadToEnd();
            }
        }
        public string Index()
        {
            return _NewHomePageHtml;
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
