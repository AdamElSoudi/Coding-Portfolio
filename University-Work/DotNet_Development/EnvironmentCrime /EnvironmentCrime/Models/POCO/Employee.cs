using System;
using System.ComponentModel.DataAnnotations;

namespace EnvironmentCrime.Models
{
	public class Employee
	{
		public string EmployeeId { get; set; }

        public string EmployeeName { get; set; }

        public string RoleTitle { get; set; }

        public string DepartmentId { get; set; }

    }
}