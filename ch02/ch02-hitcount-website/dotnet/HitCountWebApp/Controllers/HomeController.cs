using io =System.IO;
using HitCountWebApp.Models;
using Microsoft.AspNetCore.Mvc;

namespace HitCountWebApp.Controllers
{
    public class HomeController : Controller
    {
        private const string COUNT_FILE_NAME = "app-state\\hit-count.txt";

        public IActionResult Index()
        {
            var count = GetCurrentHitCount()+1;
            SaveHitCount(count);

            var model = new HomeModel
            {
                HitCount = count
            };
            return View(model);
        }

        private int GetCurrentHitCount()
        {
            var count = 0;
            if (io.File.Exists(COUNT_FILE_NAME))
            {
                var text = io.File.ReadAllText(COUNT_FILE_NAME);
                int.TryParse(text, out count);
            }
            return count;
        }

        private void SaveHitCount(int count)
        {
            io.File.WriteAllText(COUNT_FILE_NAME, count.ToString());
        }
    }
}