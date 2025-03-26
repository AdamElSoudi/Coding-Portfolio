using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using PillMedTech.Models;

namespace PillMedTech.Controllers
{
  //Checklistan 4.2. Försök till åtkomst via url när man är inloggad leder till AccessDenied
  [Authorize (Roles = "Employee")]
  public class EmployeeController : Controller
  {
    private IPillMedTechRepository repository;
    private IHttpContextAccessor contextAcc;
    
    //Konstruktor
    public EmployeeController(IPillMedTechRepository repo, IHttpContextAccessor ctxAcc)
    {
      repository = repo;
      contextAcc = ctxAcc;
    }

    //Visar upp sidor där något kan göras:
    public ViewResult StartEmployee()
    {
      return View();
    }

    //Sida för att rapportera in VAB
    public ViewResult ReportSickChild()
    {
      ViewBag.Children = repository.GetChildrenList();
      return View();
    }

    //Sida för att rapportera in sjukskrivning med intyg
    public ViewResult ReportSick()
    {
      return View();
    }

    //Tack-sidan när rapporteringen sparats 
    public ViewResult ThankYou()
    {
      return View();
    }


    //Hantering av sjukskrivning

    //Hantera VAB
    //Checklist 2.4: Razor View (@variabelnamn = automatisk html encode för output, samt inbyggt skydd mot XSS)
    //Checklist 2.5: skydd mot CSRF
    //Checklist 2.5.2: [ValidateAntiForgeryToken] på action-method (som anropas av formuläret)
    //Checklistan 4.1.1. Jobba med Authorize och Roles, samt AllowAnonymus
    [HttpPost]
    [ValidateAntiForgeryToken]
    public ViewResult ReportSickChild(SickErrand errand)
    {
      repository.ReportVAB(errand);
      repository.Log(DateTime.Now,
        HttpContext.Connection.RemoteIpAddress.ToString(),
        contextAcc.HttpContext.User.Identity.Name,
        "Reported VAB");
      return View("ThankYou");
    }

    //Hantera sjukskrivning en dag
    public IActionResult ReportSickDay()
    {
      repository.ReportSickDay();
      repository.Log(DateTime.Now,
        HttpContext.Connection.RemoteIpAddress.ToString(),
        contextAcc.HttpContext.User.Identity.Name,
        "Reported Sickday");
      return View("ThankYou");
    }

    //Hantera sjukskrivning med intyg
    [HttpPost]
    public ViewResult ReportSick(SickErrand errand)
    {
      repository.ReportSick(errand);
      repository.Log(DateTime.Now,
        HttpContext.Connection.RemoteIpAddress.ToString(),
        contextAcc.HttpContext.User.Identity.Name,
        "Reported Sick (doctor)");
      return View("ThankYou");
    }
  }
}
