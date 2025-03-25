using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using EnvironmentCrime.Models;
using Microsoft.AspNetCore.Mvc;
using SessionTest.Infrastructure;
using Microsoft.AspNetCore.Authorization;

// For more information on enabling MVC for empty projects, visit https://go.microsoft.com/fwlink/?LinkID=397860

namespace EnvironmentCrime.Controllers
{
    //Checks that the role of the user that has logged in has the role coordinator.
    [Authorize(Roles = "Coordinator")]
    public class CoordinatorController : Controller
    {
        private readonly IRepository repository;

        public CoordinatorController(IRepository repo)
        {
            repository = repo;
        }


        // GET: /<controller>/

        //Returns the data from departments from the repository/database in a viewbag.
        public ViewResult CrimeCoordinator(int id)
        {
            ViewBag.ID = id;
            TempData["Id"] = id;
            ViewBag.DepartmentList = repository.Departments;
            return View();
        }

        public ViewResult ReportCoordinator()
        {
            var myErrand = HttpContext.Session.Get<Errand>("NewErrand");
            if (myErrand == null)
            {
                return View();
            }
            else
            {
                return View(myErrand);
            }
        }

        public ViewResult StartCoordinator()
        {
            ViewBag.ErrandStatus = repository.ErrandStatuses;
            ViewBag.Department = repository.Departments;
            ViewBag.RoleView = repository.GetLoginRole();

            return View(repository.ErrandList());
        }

        public ViewResult Thanks()
        {
            var NewErrand = HttpContext.Session.Get<Errand>("NewErrand");
            HttpContext.Session.Remove("NewErrand");
            repository.SaveErrand(NewErrand);
            ViewBag.Errand = NewErrand.RefNumber;

            return View();
        }

        [HttpPost]
        public ViewResult Validate(Errand errand)
        {
            HttpContext.Session.Set<Errand>("NewErrand", errand);
            return View(errand);
        }

        public IActionResult SaveDepartment(Department department)
        {
            int id = int.Parse(TempData["Id"].ToString());
            repository.UpdateDepartment(department.DepartmentId, id);
            return RedirectToAction("StartCoordinator");
        }
    }
}