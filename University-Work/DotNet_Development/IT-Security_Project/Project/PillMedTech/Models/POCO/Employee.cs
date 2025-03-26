namespace PillMedTech.Models
{
  public class Employee
  {
    // Checklistan 2.2. Validera input med data annotations
    //Anställningsnummer, unikt (används vid inloggning)
    public string EmployeeId { get; set; }

    public string EmployeeName { get; set; }

    //Anställds personnummer
    public string SecurityNo { get; set; }

    public string Adress { get; set; }
    public string Phone { get; set; }
    public string Mail { get; set; }

    //Den anställdes barn - om den har någon/några
    public ICollection<Children> Childrens { get; set; }

  }
}
