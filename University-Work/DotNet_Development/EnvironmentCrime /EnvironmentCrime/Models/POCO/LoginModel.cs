using System;
using System.ComponentModel.DataAnnotations;
using System.Xml.Linq;

namespace EnvironmentCrime.Models
{
	public class LoginModel
	{
        [Required(ErrorMessage = "Vänligen fyll i användarnamn")]

        public string UserName { get; set; }

        [Required(ErrorMessage = "Vänligen fyll i Lösenord")]
        [Display(Name = "Lösenord")]
        [DataType(DataType.Password)]

        public string Password { get; set; }
        public string ReturnLink { get; set; }
    }
}

