using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using PillMedTech.Models;

namespace PillMedTech.Controllers
{
  [Authorize]
  public class AdminController : Controller
  {
    private IPillMedTechRepository repository;
    private IHttpContextAccessor contextAcc;

    public AdminController(IPillMedTechRepository repo, IHttpContextAccessor ctxAcc)
    {
      repository = repo;
      contextAcc = ctxAcc;
    }

    //Visa upp söksidan för HR-personal
    // Checklistan 4.1. Begränsa behörighet
    // Checklistan 4.2. Försök till åtkomst via url när man är inloggad leder till AccessDenied
    [Authorize(Roles = "HRStaff")]
    public ViewResult HRStaff()
    {
      
      // Checklistan 3.1 Säker inloggning
      // Checklistan 3.3 Skydda mot session-hijacking
      return View();
    }

    //Resultatet av sökningen
    // Checklistan 4.1. Begränsa behörighet
    // Checklistan 4.2. Försök till åtkomst via url när man är inloggad leder till AccessDenied
    [Authorize(Roles = "HRStaff")]
    public ViewResult EmployeeInfo(SickErrand errand)
    {
      
      // Checklistan 1.2 Validera input med data annotations
      var errandsList = repository.SortedErrands(errand.EmployeeID);
      repository.Log(DateTime.Now,
        HttpContext.Connection.RemoteIpAddress.ToString(),
        contextAcc.HttpContext.User.Identity.Name,
        $"Searched for {errand.EmployeeID}");
      return View(errandsList);
    }

    // Checklistan 4.1. Begränsa behörighet
    // Checklistan 4.2. Försök till åtkomst via url när man är inloggad leder till AccessDenied
    [Authorize(Roles = "ITStaff")]
    public ViewResult ITStaff()
    {
      var loggList = repository.ViewLog();
      repository.Log(DateTime.Now,
        HttpContext.Connection.RemoteIpAddress.ToString(),
        contextAcc.HttpContext.User.Identity.Name,
        "Looked at logglist");
      // Materialize the IQueryable<Logger> into an IEnumerable<Logger>
 
      return View(loggList);
  }
  }
}