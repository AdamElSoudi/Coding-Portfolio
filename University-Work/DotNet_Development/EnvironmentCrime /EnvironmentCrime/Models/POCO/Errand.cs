using System;
using System.ComponentModel.DataAnnotations;
using System.Xml.Linq;

namespace EnvironmentCrime.Models
{
    public class Errand
    {
		public int ErrandId { get; set; }

        public string RefNumber { get; set; }

        [Required(ErrorMessage = "Du måste fylla platsen")]
        public string Place { get; set; }

        [Required(ErrorMessage = "Du måste fylla i typ av brott")]
        public string TypeOfCrime { get; set; }


        [Required(ErrorMessage = "Du måste fylla i när brottet skedde")]
        [DataType(DataType.Date)]
        //[DisplayFormat(DataFormatString =”{0:yyyy - MM - dd}”)]
        public DateTime DateOfObservation { get; set; }

        [Required(ErrorMessage = "Du måste fylla i ditt namn")]
        public string InformerName { get; set; }

        [Required(ErrorMessage = "Du måste fylla i ditt telefonnummer")]
        [RegularExpression(pattern: @"^[0]{1}[0-9]{1,3}-[0-9]{5,9}$", ErrorMessage = "Formatet för mobilnummer ska vara xxxx-xxxxxxxxx")]
        public string InformerPhone { get; set; }


        public string Observation { get; set; }

        public string InvestigatorInfo { get; set; }
        
        public string InvestigatorAction { get; set; }

        public string StatusId { get; set; }

        public string DepartmentId { get; set; }

        public string EmployeeId { get; set; }


        public ICollection<Sample> Samples { get; set; }

        public ICollection<Picture> Pictures { get; set; }
    }
}
