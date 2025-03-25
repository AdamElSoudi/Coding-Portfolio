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
    //Ensures that the users who can reach the pages/views in the manager map have the role manager.
    [Authorize(Roles = "Manager")]
    public class ManagerController : Controller
    {
        private IHttpContextAccessor httpContext;
        private readonly IRepository repository;

        public ManagerController(IRepository repo, IHttpContextAccessor httpCtx)
        {
            repository = repo;
            httpContext = httpCtx;
        }

        // GET: /<controller>/
        public ViewResult CrimeManager(int id)
        {
            var userName = httpContext.HttpContext.User.Identity.Name;

            ViewBag.ID = id;
            ViewBag.EmployeeList = repository.GetDepartmentEmployees(userName);
            TempData["Id"] = id;
            return View();
        }

        public ViewResult StartManager()
        {
            var userName = httpContext.HttpContext.User.Identity.Name;

            ViewBag.ErrandStatus = repository.ErrandStatuses;
            ViewBag.RoleView = repository.GetLoginRole();
            ViewBag.Employee = repository.GetDepartmentEmployees(userName);
            return View(repository.ErrandListManager());
        }

        public IActionResult SaveEmployee(Employee employee, bool noAction, string reason)
        {
            int id = int.Parse(TempData["Id"].ToString());

            //If the manager decides on "Ingen åtgärd" the errand status is set to "S_B" as well as the reason.
            if(noAction == true)
            {
                repository.UpdateStatus("S_B", id);
                repository.UpdateInfo(reason, id);
            }

            //If the manager didn't click the "Ingen åtgärd" checkbox, he/she chooses an employee for that errand. When this is complete the user is sent back to the view StartManager.
            else
            {
                repository.UpdateEmployee(employee.EmployeeId, id);
            }
            return RedirectToAction("StartManager");
        }
    }
}