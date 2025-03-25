using EnvironmentCrime.Models;
using Microsoft.EntityFrameworkCore;
using static System.Formats.Asn1.AsnWriter;
using Microsoft.AspNetCore.Identity;

var builder = WebApplication.CreateBuilder(args);

// Add services to the container.
builder.Services.AddControllersWithViews();
builder.Services.AddTransient<IRepository, EFRepository>();
builder.Services.AddSession();

builder.Services.AddDbContext<ApplicationDbContext>(options =>
options.UseSqlServer(builder.Configuration.GetConnectionString("DefaultConnection")));

builder.Services.AddDbContext<AppIdentityDBContext>(options =>
options.UseSqlServer(builder.Configuration.GetConnectionString("IdentityConnection")));

builder.Services.AddIdentity<IdentityUser, IdentityRole>().AddEntityFrameworkStores<AppIdentityDBContext>();

builder.Services.ConfigureApplicationCookie(options =>
    {
        options.LoginPath = "/Account/Login";
    });

var app = builder.Build();
using (var scope = app.Services.CreateScope())
{
    var services = scope.ServiceProvider;
    DBInitializer.EnsurePopulated(services);
    IndentityInitializer.EnsurePopulated(services).Wait();
}

// Configure the HTTP request pipeline.
if (!app.Environment.IsDevelopment())
{
    app.UseExceptionHandler("/Home/Error");
}
app.UseStaticFiles();

app.UseRouting();

app.UseSession();

app.UseAuthentication();

app.UseAuthorization();

app.MapControllerRoute(
    name: "default",
    pattern: "{controller=Home}/{action=Index}/{id?}");

app.Run();

