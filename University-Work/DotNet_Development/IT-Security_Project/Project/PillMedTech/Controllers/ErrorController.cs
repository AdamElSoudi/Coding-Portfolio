using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;

namespace PillMedTech.Controllers
{
  public class ErrorController : Controller
  {
    
    //Checklistan 5. Felhantering

    [AllowAnonymous]
    public IActionResult CustomerError()
    {
      return View();
    }
  }
}
