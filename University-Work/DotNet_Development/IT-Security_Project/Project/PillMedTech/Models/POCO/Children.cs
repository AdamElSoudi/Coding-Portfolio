namespace PillMedTech.Models
{
  public class Children
  {
    // Checklistan 2.2. Validera input med data annotations
    public int ChildrenId { get; set; }
    public string ChildName { get; set; }
    //Barnets personnummer
    public string SecurityNo { get; set; }
    public string EmployeeId { get; set; }
  }
}
