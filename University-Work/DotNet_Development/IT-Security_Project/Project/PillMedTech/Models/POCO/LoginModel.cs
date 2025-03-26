using System.ComponentModel.DataAnnotations;

namespace PillMedTech.Models
{
  public class LoginModel
  {
    // Checklistan 2.2. Validera input med data annotations
    // Checklistan 3.2. Generellt felmeddelande vid inlogggning
    [Required(ErrorMessage = "Vänligen fyll i användarnamn")]
    [Display(Name = "Användarnamn:")]
    public string UserName { get; set; }

    [Required(ErrorMessage = "Vänligen fyll i lösenord")]
    [DataType(DataType.Password)]
    [Display(Name = "Lösenord:")]
    public string Password { get; set; }
    public string ReturnUrl { get; set; }
  }
}
