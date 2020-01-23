using Microsoft.AspNetCore.Mvc;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace StreamCon.UI.Controllers
{
    public class AppController : Controller
    {
        public IActionResult Index()
        {
            ViewBag.Title = "Index";
            ViewBag.ApiEndpoint = "Not Configured";
            return View();
        }
    }
}
