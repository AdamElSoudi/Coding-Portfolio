using Microsoft.AspNetCore.DataProtection;
using PillMedTech.Models;
using Microsoft.EntityFrameworkCore;
using Microsoft.AspNetCore.Identity;

var builder = WebApplication.CreateBuilder(args);

// Add services to the container.
builder.Services.AddControllersWithViews();
builder.Services.AddTransient<IPillMedTechRepository, EFPillMedTechRepository>();

builder.Services.AddDbContext<ApplicationDbContext>(options =>
        options.UseSqlServer(builder.Configuration.GetConnectionString("DefaultConnection")));

builder.Services.AddDbContext<AppIdentityDbContext>(options =>
  options.UseSqlServer(builder.Configuration.GetConnectionString("IdentityConnection")));

builder.Services.AddDbContext<LoggDbContext>(options =>
   options.UseSqlServer(builder.Configuration.GetConnectionString("LoggsConnection")));

builder.Services.AddIdentity<IdentityUser, IdentityRole>(options => { 
// Password settings

/*
   Lösenordet ska vara minst 10 tecken
   Lösenordet ska ha minst ett tecken
   Lösenordet ska ha minst en stor bokstav
   Lösenordet ska ha minst en liten bokstav
   Lösenordet ska ha minst ett nummer
   Ett lösenord går inte att skapa om det inte möter alla dem övre kriterierna.
 */

// Checklist 1.2. Förhindra injection
// Checklistan 3.6. Implementera lösenordspolicy (längd och komplexitet)
  options.Password.RequireDigit = true; 
  options.Password.RequiredLength = 10;
  options.Password.RequireNonAlphanumeric = true; 
  options.Password.RequireUppercase = true; 
  options.Password.RequireLowercase = true; 
  options.Password.RequiredUniqueChars = 1; 
}) .AddEntityFrameworkStores<AppIdentityDbContext>();


var app = builder.Build();

using (var scope = app.Services.CreateScope())
{
  var services = scope.ServiceProvider;
  IDataProtectionProvider protector = services.GetDataProtectionProvider().CreateProtector("CodeSec");
  DBInitializer.EnsurePopulated(services, protector);
  IdentityInitializer.EnsurePopulated(services).Wait();
}

// Configure the HTTP request pipeline.
if (!app.Environment.IsDevelopment())
{
  app.UseExceptionHandler("/Home/Error");
}
app.UseStaticFiles();

app.UseRouting();

app.UseAuthentication();
app.UseAuthorization();

app.MapControllerRoute(
    name: "default",
    pattern: "{controller=Home}/{action=Index}/{id?}");

app.Run();
