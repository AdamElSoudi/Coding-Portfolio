using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Mvc;
using PillMedTech.Models;


namespace PillMedTech.Controllers
{
  // Checklistan 4.1.1. Jobba med Authorize och Roles, samt AllowAnonymus
  [Authorize]
  public class AccountController : Controller
  {
    private UserManager<IdentityUser> userManager;
    private SignInManager<IdentityUser> signInManager;
    private IPillMedTechRepository repository;
    private IHttpContextAccessor contextAcc;

    public AccountController(UserManager<IdentityUser> userMgr, SignInManager<IdentityUser> signInMgr, IPillMedTechRepository repo, IHttpContextAccessor ctxAcc)
    {
      userManager = userMgr;
      signInManager = signInMgr;
      repository = repo;
      contextAcc = ctxAcc;
    }
    
    // Checklistan 4.1.1. Jobba med Authorize och Roles, samt AllowAnonymus
    [AllowAnonymous]
    public ViewResult Login(string returnUrl)
    {
      return View(new LoginModel
      {
        ReturnUrl = returnUrl
      });
    }

    [HttpPost]
    
    // Checklistan 4.1.1. Jobba med Authorize och Roles, samt AllowAnonymus
    [AllowAnonymous]
    
    // Checklistan 2.5.2 [ValidateAntiForgeryToken] på action-method
    // Checklistan 4.1.1. Jobba med Authorize och Roles, samt AllowAnonymus
    [ValidateAntiForgeryToken]
    public async Task<IActionResult> Login(LoginModel loginModel)
    {
      if (ModelState.IsValid)
      {
        IdentityUser user = await userManager.FindByNameAsync(loginModel.UserName);

        if (user != null)
        {
          await signInManager.SignOutAsync();

          // Checklistan 2.2 Validera input med data annotations
          // Checklistan 3.2 Skydda mot brute force-attacker
          if ((await signInManager.PasswordSignInAsync(user,
                          loginModel.Password, false, false)).Succeeded)
          {
            // Checklistan 3.4 Auktorisera rättigheter
            // Checklistan 5.4.3. Logga stacktrace enligt beslut
            // Checklistan 6.1. Logga viktiga saker (inloggningar, vad som gör, felmeddelanden)
            if (await userManager.IsInRoleAsync(user, "Employee"))
            {
              repository.Log(DateTime.Now,
                            HttpContext.Connection.RemoteIpAddress.ToString(),
                            user.ToString(),
                            "Sucessfully logged in");
              return Redirect("/Employee/StartEmployee");
            }
            else if (await userManager.IsInRoleAsync(user, "HRStaff"))
            {
              repository.Log(DateTime.Now,
                           HttpContext.Connection.RemoteIpAddress.ToString(),
                           user.ToString(),
                           "Sucessfully logged in");
              return Redirect("/Admin/HRStaff");
            }
            else if (await userManager.IsInRoleAsync(user, "ITStaff"))
            {
              repository.Log(DateTime.Now,
                           HttpContext.Connection.RemoteIpAddress.ToString(),
                           user.ToString(),
                           "Sucessfully logged in");
              return Redirect("/Admin/ITStaff");
            }
            else
            {
              repository.Log(DateTime.Now,
                           HttpContext.Connection.RemoteIpAddress.ToString(),
                           user.ToString(),
                           "Tried to log in, unsuccessfully");
              return Redirect("/Home/Index");
            }
          }
        }
      }
      // Checklistan 5.2. Generella felmeddelanden vid fel inmatning i formulär
      ModelState.AddModelError("", "Felaktigt användarnamn eller lösenord");
      repository.Log(DateTime.Now,
                           HttpContext.Connection.RemoteIpAddress.ToString(),
                           loginModel.UserName,
                           "Tried to log in, unsuccessfully");
      //Checklistan 5.4.1. Vad ska hända – felmeddelande/defaultinställning 
      return View(loginModel);
    }

    [Authorize]
    public async Task<RedirectResult> Logout(string returnUrl = "/")
    {
      // Checklistan 3.3 Skydda mot session-hijacking
      var user = contextAcc.HttpContext.User.Identity.Name;
      await signInManager.SignOutAsync();

      repository.Log(DateTime.Now,
          HttpContext.Connection.RemoteIpAddress.ToString(),
          user.ToString(),
          "Successfully logged out");


      return Redirect(returnUrl);
    }

    // Checklistan 4.1.1. Jobba med Authorize och Roles, samt AllowAnonymus
    [AllowAnonymous]
    public ViewResult AccessDenied()
    {
      // Checklistan 3.4 Auktorisera rättigheter
      var user = contextAcc.HttpContext.User.Identity.Name;

      repository.Log(DateTime.Now,
          HttpContext.Connection.RemoteIpAddress.ToString(),
          user.ToString(),
          "Tried to reach unauthorized view");

      return View();
    }
  }
}
