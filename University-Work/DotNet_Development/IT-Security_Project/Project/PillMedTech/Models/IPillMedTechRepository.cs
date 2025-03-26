namespace PillMedTech.Models
{
  public interface IPillMedTechRepository
  {
    // Checklistan 1. Datalagring - Tabeller i databasen
    //Tabeller i databasen
    IQueryable<Employee> Employees { get; }
    IQueryable<SickErrand> SickErrands { get; }
    IQueryable<Children> Childrens { get; }


    IQueryable<Children> GetChildrenList();
    
    //Sökning av anställds sjukskrivning
    List<SickErrand> SortedErrands(string employeeId);

    
    //Sjukskrivningar
    void ReportVAB(SickErrand errand);
    void ReportSickDay();
    void ReportSick(SickErrand errand);

    // Checklistan 6. Loggning
    void Log(DateTime createdAt, string IPAdress, string user, string action);
    IQueryable<Logger> ViewLog();
  }
}
