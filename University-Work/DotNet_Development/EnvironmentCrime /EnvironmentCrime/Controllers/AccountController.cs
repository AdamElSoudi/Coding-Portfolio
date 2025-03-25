using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Identity;
using EnvironmentCrime.Models;

// For more information on enabling MVC for empty projects, visit https://go.microsoft.com/fwlink/?LinkID=397860

namespace EnvironmentCrime.Controllers
{
    [Authorize]
    public class AccountController : Controller
    {
        //Here two private variables are created. They are both implementations of IdentityUser which uses a string as the primary key.
        private UserManager<IdentityUser> userManager;
        private SignInManager<IdentityUser> signInManager;

        public AccountController(UserManager<IdentityUser> uManager, SignInManager<IdentityUser> sManager)
            {
                userManager = uManager;
                signInManager = sManager;
            }

        // GET: /<controller>/

        //Returnes the user to the view login page (LoginModel). The [AllowAnonymous] allows any user to be sent to the login page no matter their specified role.
        [AllowAnonymous]
        public ViewResult Login(string returnLink)
        {
            return View(new LoginModel
            {
                ReturnLink = returnLink
            });
        }

        //This part of the code controls that the username and password are correct and if so, checks the role for that user so that they end up on the correct page/view. There is also an error message incase either the username or password is incorrect.
        [HttpPost]
        [AllowAnonymous]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Login(LoginModel loginModel)
        {
            if (ModelState.IsValid)
            {
                IdentityUser user = await userManager.FindByNameAsync(loginModel.UserName);

                if (user != null)
                {
                    await signInManager.SignOutAsync();

                    if ((await signInManager.PasswordSignInAsync(user, loginModel.Password, false, false)).Succeeded)
                    {
                        if (await userManager.IsInRoleAsync(user, "Coordinator"))
                        {
                            return Redirect("/Coordinator/StartCoordinator");
                        }
                        if (await userManager.IsInRoleAsync(user, "Investigator"))
                        {
                            return Redirect("/Investigator/StartInvestigator");
                        }
                        if (await userManager.IsInRoleAsync(user, "Manager"))
                        {
                            return Redirect("/Manager/StartManager");
                        }
                    }
                }
                ModelState.AddModelError(" ", "Användarnamnet eller lösenordet är fel");
            }
            
            return View(loginModel);
        }
    }
}

