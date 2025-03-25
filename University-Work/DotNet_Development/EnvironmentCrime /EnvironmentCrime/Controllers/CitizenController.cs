using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using EnvironmentCrime.Models;
using Microsoft.AspNetCore.Mvc;
using SessionTest.Infrastructure;

// For more information on enabling MVC for empty projects, visit https://go.microsoft.com/fwlink/?LinkID=397860

namespace EnvironmentCrime.Controllers
{
    public class CitizenController : Controller
    {

        private readonly IRepository repository;

        public CitizenController(IRepository repo)
        {
            repository = repo;
        }


        // GET: /<controller>/
        public ViewResult Services()
        {
            return View();
        }

        public ViewResult Faq()
        {
            return View();
        }

        public ViewResult Contact()
        {
            return View();
        }

        public ViewResult Thanks()
        {
            var NewErrand = HttpContext.Session.Get<Errand>("LatestErrand");
            HttpContext.Session.Remove("LatestErrand");
            repository.SaveErrand(NewErrand);
            ViewBag.Errand = NewErrand.RefNumber;

            return View();
        }

        [HttpPost]
        public ViewResult Validate(Errand errand)
        {

            HttpContext.Session.Set<Errand>("LatestErrand", errand);
            return View(errand);
        }
    }
}

