using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;


namespace PillMedTech.Controllers
{
  public class HomeController : Controller
  {
    [AllowAnonymous]
    public ViewResult Index()
    {
      return View("Index");
    }
  }
}