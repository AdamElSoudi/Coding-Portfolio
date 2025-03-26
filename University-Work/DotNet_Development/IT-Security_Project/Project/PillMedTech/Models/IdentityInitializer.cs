using Microsoft.AspNetCore.Identity;


namespace PillMedTech.Models
{
  public class IdentityInitializer
  {
    public static async Task EnsurePopulated(IServiceProvider service)
    {
      // Checklistan 1. Datalagring: Hämta UserManager och RoleManager tjänster för att hantera användare och roller i databasen.
      var userManager = service.GetRequiredService<UserManager<IdentityUser>>();
      var roleManager = service.GetRequiredService<RoleManager<IdentityRole>>();

      await CreateRoles(roleManager);
      await CreateUsers(userManager);
    }

    // Checklistan 3.1. Var noga med att auktorisera användaren (vilka har tillgång till vilken data, vilka rättigheter?)
    private static async Task CreateRoles(RoleManager<IdentityRole> rManager)
    {
      if (!await rManager.RoleExistsAsync("Employee"))
      {
        await rManager.CreateAsync(new IdentityRole("Employee"));
      }

      if (!await rManager.RoleExistsAsync("HRStaff"))
      {
        await rManager.CreateAsync(new IdentityRole("HRStaff"));
      }

      if (!await rManager.RoleExistsAsync("ITStaff"))
      {
        await rManager.CreateAsync(new IdentityRole("ITStaff"));
      }
    }


    private static async Task CreateUsers(UserManager<IdentityUser> userManager)
    {
      // Checklistan 2. Datainhämtning: Skapa användare med unika användarnamn och lösenord
      IdentityUser EMP330 = new IdentityUser("EMP330");
      IdentityUser EMP430 = new IdentityUser("EMP430");
      IdentityUser EMP530 = new IdentityUser("EMP530");
      IdentityUser HRS270 = new IdentityUser("HRS270");
      IdentityUser ITS980 = new IdentityUser("ITS980");

      // Checklistan 3.5. Lösenordet ska vara hashad (kryptering)
      await userManager.CreateAsync(EMP330, "P@ssw0rd1234");
      await userManager.CreateAsync(EMP430, "G00dP@ssw0rd");
      await userManager.CreateAsync(EMP530, "Str0ngP@ssw0rd");
      await userManager.CreateAsync(HRS270, "S3cureP@ssw0rd");
      await userManager.CreateAsync(ITS980, "C0mpl3xP@ssw0rd");
      
      
      // Checklistan 3.1. Var noga med att auktorisera användaren (vilka har tillgång till vilken data, vilka rättigheter?)
      await userManager.AddToRoleAsync(EMP330, "Employee");
      await userManager.AddToRoleAsync(EMP430, "Employee");
      await userManager.AddToRoleAsync(EMP530, "Employee");
      await userManager.AddToRoleAsync(HRS270, "HRStaff");
      await userManager.AddToRoleAsync(ITS980, "ITStaff");
    }
  }
}
