using Microsoft.AspNetCore.DataProtection;

namespace PillMedTech.Models
{
  public class DBInitializer
  {

    public static void EnsurePopulated(IServiceProvider services, IDataProtectionProvider pro)
    {
      //protector = services.GetDataProtectionProvider().CreateProtector("CodeSec");
      var context = services.GetRequiredService<ApplicationDbContext>();
      IDataProtector protector = pro.CreateProtector("CodeSec");
      // Checklistan 1.1. Olika databaser som hanterar olika typer av data (ex. inloggningsuppgifter, loggar, datahanteringen etc).
      //Kollar om tabellen Employees är tom. Är den det fylls det på med data. 
      if (!context.Employees.Any())
      {
        context.Employees.AddRange(
          new Employee
          {
            EmployeeId = "EMP330", EmployeeName = protector.Protect("Ada Öqvist"),
            SecurityNo = protector.Protect("19890620-4443"), Adress = protector.Protect("Svartsjövägen 12"),
            Mail = protector.Protect("ada@pillmedtech.com"), Phone = protector.Protect("070-12345678")
          },
          new Employee
          {
            EmployeeId = "EMP430", EmployeeName = protector.Protect("Charlie Jansson"),
            SecurityNo = protector.Protect("19921114-4438"), Adress = protector.Protect("Storgatan 44"),
            Mail = protector.Protect("charlie@pillmedtech.com"), Phone = protector.Protect("070-12456789")
          },
          new Employee
          {
            EmployeeId = "EMP530", EmployeeName = protector.Protect("Bertil Gustavsson"),
            SecurityNo = protector.Protect("19780211-4475"), Adress = protector.Protect("Blåsjögatan 2"),
            Mail = protector.Protect("bertil@pillmedtech.com"), Phone = protector.Protect("070-12567890")
          },
          new Employee
          {
            EmployeeId = "HRS270", EmployeeName = protector.Protect("Amelia Gundersson"),
            SecurityNo = protector.Protect("19650404-4465"), Adress = protector.Protect("Lilla gränd 6"),
            Mail = protector.Protect("amelia@pillmedtech.com"), Phone = protector.Protect("070-12678901")
          },
          new Employee
          {
            EmployeeId = "ITS980", EmployeeName = protector.Protect("Tove Berg"),
            SecurityNo = protector.Protect("20000105-4442"), Adress = protector.Protect("Storsjövägen 78"),
            Mail = protector.Protect("tove@pillmedtech.com"), Phone = protector.Protect("070-12789012")
          }
        );
        context.SaveChanges();
      }

      //Kollar om tabellen Children är tom. Är den det fylls det på med data. 
      if (!context.Childrens.Any())
      {
        context.Childrens.AddRange(
          new Children
          {
            ChildName = "Alice", SecurityNo = protector.Protect("20140620-4482"),
            EmployeeId = "EMP330"
          },
          new Children
          {
            ChildName = "Maj", SecurityNo = protector.Protect("20160413-4421"),
            EmployeeId = "EMP330"
          },
          new Children
          {
            ChildName = "Noah", SecurityNo = protector.Protect("20181010-4471"),
            EmployeeId = "EMP330"
          },
          new Children
          {
            ChildName = "William", SecurityNo = protector.Protect("20171202-4492"),
            EmployeeId = "EMP430"
          }
        );
        context.SaveChanges();
      }

      //Kollar om tabellen SickErrands är tom. Är den det fylls det på med data. 
      if (!context.SickErrands.Any())
      {
        context.SickErrands.AddRange(
          new SickErrand
          {
            EmployeeID = "EMP330", ChildName = "Alice", TypeOfAbsence = "VAB",
            HomeFrom = new DateTime(2021, 09, 16), HomeUntil = new DateTime(2021, 09, 17)
          },
          new SickErrand
          {
            EmployeeID = "EMP430", ChildName = "ej aktuellt", TypeOfAbsence = "Sjuk med intyg",
            HomeFrom = new DateTime(2021, 08, 10), HomeUntil = new DateTime(2021, 08, 20)
          },
          new SickErrand
          {
            EmployeeID = "EMP530", ChildName = "ej aktuellt", TypeOfAbsence = "Sjuk utan intyg",
            HomeFrom = new DateTime(2021, 07, 22), HomeUntil = new DateTime(2021, 07, 23)
          },
          new SickErrand
          {
            EmployeeID = "EMP430", ChildName = "William", TypeOfAbsence = "VAB",
            HomeFrom = new DateTime(2021, 09, 16), HomeUntil = new DateTime(2021, 09, 17)
          },
          new SickErrand
          {
            EmployeeID = "EMP330", ChildName = "Maj", TypeOfAbsence = "VAB", HomeFrom = new DateTime(2021, 06, 15),
            HomeUntil = new DateTime(2021, 06, 18)
          },
          new SickErrand
          {
            EmployeeID = "EMP530", ChildName = "ej aktuellt", TypeOfAbsence = "Sjuk utan intyg",
            HomeFrom = new DateTime(2021, 05, 12), HomeUntil = new DateTime(2021, 05, 13)
          }
        );
        context.SaveChanges();
      }
    }
  }
}
