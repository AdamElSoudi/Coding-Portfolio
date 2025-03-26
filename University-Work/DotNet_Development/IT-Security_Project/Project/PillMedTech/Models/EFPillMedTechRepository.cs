using System.Security.Cryptography;
using Microsoft.AspNetCore.DataProtection;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;

namespace PillMedTech.Models
{
  public class EFPillMedTechRepository : IPillMedTechRepository
  {
    private ApplicationDbContext appContext;
    private IHttpContextAccessor contextAcc;
    private LoggDbContext loggContext;
    private IDataProtector protector;

    public EFPillMedTechRepository(ApplicationDbContext ctx, IHttpContextAccessor cont, LoggDbContext logg,
      IDataProtectionProvider protect)
    {
      appContext = ctx;
      contextAcc = cont;
      loggContext = logg;
      protector = protect.CreateProtector("CodeSec");
    }

    // 1.1. Olika databaser som hanterar olika typer av data (ex. inloggningsuppgifter,loggar, datahanteringen etc).
    public IQueryable<Employee> Employees => appContext.Employees.Include(e => e.Childrens);
    public IQueryable<SickErrand> SickErrands => appContext.SickErrands;
    public IQueryable<Logger> Logging => loggContext.Loggers;
    public IQueryable<Children> Childrens => appContext.Childrens;

    // 2.1. Använda formulärkontroller där användaren väljer istället för att skriva (så långt det är möjligt)
    //Hämtar en lista med barn tillhörande en specifik anställd
    public IQueryable<Children> GetChildrenList()
    {
      var userName = contextAcc.HttpContext.User.Identity.Name;

      var childrenList = Childrens.Where(ch => ch.EmployeeId == userName);
      return childrenList;
    }

    // 2.1. Använda formulärkontroller där användaren väljer istället för att skriva (så långt det är möjligt)
    //Går igenom listan för att hitta ärenden gällande en specifik anställd
    public List<SickErrand> SortedErrands(string employeeId)
    {
      var currentEmp = SickErrands.Where(emp => emp.EmployeeID.Equals(employeeId)).FirstOrDefault();

      List<SickErrand> errands = new List<SickErrand>();

      foreach (SickErrand err in SickErrands)
      {
        if (err.EmployeeID.Equals(employeeId))
        {
          errands.Add(err);
        }
      }

      return errands;
    }

    public void ReportVAB(SickErrand errand)
    {
      if (!errand.Equals(null))
      {
        if (errand.SickErrandID.Equals(0))
        {
          DateTime endDate = errand.HomeFrom.AddDays(1);
          errand.HomeUntil = endDate;
          errand.TypeOfAbsence = "VAB";
          appContext.SickErrands.Add(errand);
        }
      }
      appContext.SaveChanges();

    }

    public void ReportSickDay()
    {
      var user = contextAcc.HttpContext.User.Identity.Name;
      SickErrand errand = new SickErrand
        { EmployeeID = user, ChildName = "ej aktuellt", HomeFrom = DateTime.Today, TypeOfAbsence = "Sjuk utan intyg" };
          DateTime endDate = errand.HomeFrom.AddDays(1);
      errand.HomeUntil = endDate;

      appContext.SickErrands.Add(errand);

      appContext.SaveChanges();
    }

    public void ReportSick(SickErrand errand)
    {
      // 2.1. Använda formulärkontroller där användaren väljer istället för att skriva (så långt det är möjligt)
      // 2.2. 2.2. Validera input med data annotations (som läggs på dataklasserna s.k poco-klasser) – vilket tvingar användaren att ge oss rätt data
      if (!errand.Equals(null))
      {
        if (errand.SickErrandID.Equals(0))
        {
          errand.ChildName = "ej aktuellt";
          errand.TypeOfAbsence = "Sjuk med intyg";
          appContext.SickErrands.Add(errand);
        }
      }

      appContext.SaveChanges();
    }

    // Checklistan 6.1. Logga viktiga saker
    // Checklistan 6.2. Inkludera tid, ip-adress, vem och vad som gjordes
    public void Log(DateTime createdAt, string IPAdress, string user, string action)
    {

      Logger logger = new Logger();

      // Checklistan 1.3. Kryptera känslig data (välj rätt typ av kryptering)
      // Checklistan Krypterar IPAdress och EmployeeId i loggarna.
      // Checklistan 6.2. Inkludera tid, ip-adress, vem och vad som gjordes
      // Checklistan 6.3. Kryptera loggningarna (dekryptering för att kunna läsa loggarna)
      logger.Time = createdAt;
      logger.Ip = protector.Protect(IPAdress);
      logger.EmployeeId = protector.Protect(user);
      logger.Action = action;

      loggContext.Loggers.Add(logger);

      // Checklistan 1.1. Olika databaser som hanterar olika typer av data (ex. inloggningsuppgifter, loggar, datahanteringen etc).
      // Checklistan 6.4. Förvara loggningarna i annan databas
      loggContext.SaveChanges();
    }

    public IQueryable<Logger> ViewLog()
    {
      // Checklistan 1.2.2 Förhindra injection
      // Checklistan 6.3. Kryptera loggningarna (dekryptering för att kunna läsa loggarna)
      var decryptedLogData =
        from log in Logging
        select new Logger
        {
          Time = log.Time,
          Ip = protector.Unprotect(log.Ip),
          EmployeeId = protector.Unprotect(log.EmployeeId),
          Action = log.Action
        };
      return decryptedLogData;

      
      // Checklistan 7.1. Kommentera vad som ska bort eller förändras innan driftsättningen
      
      /*foreach (var log in loggList)
{
  try
  {
    // Decrypt the strings using the Unprotect method
      log.Time = log.Time;
      log.Ip = protector.Unprotect(log.Ip);
      log.EmployeeId = protector.Unprotect(log.EmployeeId);
      log.Action = log.Action;
    
  }
  catch (FormatException)
  {
    // If the input strings are not valid base64-encoded strings, do not attempt to decrypt them
  }
  catch (CryptographicException)
  {
    // If an error occurred during the decryption process, handle it as appropriate (e.g. log the error)
  }
}
// Return the decrypted log data
return loggList;*/

      /*var decryptedLogData = 
        from log in loggList
        select new Logger
        {
          Time = log.Time,
          EmployeeId = IsBase64String(log.EmployeeId) ? protector.Unprotect(Convert.FromBase64String(log.EmployeeId)).ToString() : log.EmployeeId,
          Ip = IsBase64String(log.Ip) ? protector.Unprotect(Convert.FromBase64String(log.Ip)).ToString() : log.Ip,
          Action = log.Action
        };

      return decryptedLogData;*/
    }
  }
}

