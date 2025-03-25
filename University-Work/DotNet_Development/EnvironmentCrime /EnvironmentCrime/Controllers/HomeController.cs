using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using EnvironmentCrime.Models;
using SessionTest.Infrastructure;

// For more information on enabling MVC for empty projects, visit https://go.microsoft.com/fwlink/?LinkID=397860

namespace EnvironmentCrime.Controllers
{
    public class HomeController : Controller
    {

        private readonly IRepository repository;

        public HomeController(IRepository repo)
        {
            repository = repo;
        }

        // GET: /<controller>/
        public ViewResult Index()
        {
            var myErrand = HttpContext.Session.Get<Errand>("LatestErrand");
            if (myErrand == null)
            {
                return View();
            }
            else
            {
                return View(myErrand);
            }
        }

        public ViewResult Login()
        {
            return View("~/Views/Account/Login.cshtml");
        }
    }
}

