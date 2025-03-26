using System;
using System.ComponentModel.DataAnnotations;

namespace PillMedTech.Models
{
	public class Logger
	{
		// Checklistan 2.2. Validera input med data annotations
		[Key]
		public int Id { get; set; }
		public String EmployeeId { get; set; }
		public DateTime Time { get; set; }
		public string Ip { get; set; }
		public String Action{ get; set; }
	}
}