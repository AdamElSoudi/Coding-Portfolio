﻿using System;
using Microsoft.EntityFrameworkCore.Metadata.Internal;

namespace EnvironmentCrime.Models
{
	public class DBInitializer
	{
		public static void EnsurePopulated(IServiceProvider services)
		{
			var context = services.GetRequiredService<ApplicationDbContext>();

            //Check if table Errands is empty and if so fill with data
            if (!context.Departments.Any())
            {
                //Giving the departments their specific id and name and saving it in a database called sqlUniversity.
                context.Departments.AddRange(
                  new Department { DepartmentId = "D00", DepartmentName = "Småstads kommun" },
                  new Department { DepartmentId = "D01", DepartmentName = "Tekniska Avloppshanteringen" },
                  new Department { DepartmentId = "D02", DepartmentName = "Klimat och Energi" },
                  new Department { DepartmentId = "D03", DepartmentName = "Miljö och Hälsoskydd" },
                  new Department { DepartmentId = "D04", DepartmentName = "Natur och Skogsvård" },
                  new Department { DepartmentId = "D05", DepartmentName = "Renhållning och Avfall" }
                );
                context.SaveChanges(); //spara tabellen
            }

            if (!context.ErrandStatuses.Any())
            {
                //Using a status id and name to know the status of the errand and saving it in the database.
                context.ErrandStatuses.AddRange(
                  new ErrandStatus { StatusId = "S_A", StatusName = "Inrapporterad" },
                  new ErrandStatus { StatusId = "S_B", StatusName = "Ingen åtgärd" },
                  new ErrandStatus { StatusId = "S_C", StatusName = "Påbörjad" },
                  new ErrandStatus { StatusId = "S_D", StatusName = "Klar" }
                );
                context.SaveChanges();
            }

            if (!context.Sequences.Any())
            {
                context.Sequences.Add(
                  new Sequence { CurrentValue = 200 }
                  );
                context.SaveChanges();
            }

            if (!context.Employees.Any())
            {
                //Here the employees are being identified through their id, name, role title, and department id which is used as a foreign key in the database. 
                context.Employees.AddRange(
                  new Employee { EmployeeId = "E001", EmployeeName = "Sten Frling", RoleTitle = "Coordinator", DepartmentId = "D00" },
                  new Employee { EmployeeId = "E100", EmployeeName = "Anna Kerman", RoleTitle = "Manager", DepartmentId = "D01" },
                  new Employee { EmployeeId = "E101", EmployeeName = "Fredrik Roos", RoleTitle = "Investigator", DepartmentId = "D01" },
                  new Employee { EmployeeId = "E102", EmployeeName = "Gösta Qvist", RoleTitle = "Investigator", DepartmentId = "D01" },
                  new Employee { EmployeeId = "E103", EmployeeName = "Hilda Persson", RoleTitle = "Investigator", DepartmentId = "D01" },
                  new Employee { EmployeeId = "E200", EmployeeName = "Bengt Viik", RoleTitle = "Manager", DepartmentId = "D02" },
                  new Employee { EmployeeId = "E201", EmployeeName = "Ivar Oscarsson", RoleTitle = "Investigator", DepartmentId = "D02" },
                  new Employee { EmployeeId = "E202", EmployeeName = "Jenny Nordström", RoleTitle = "Investigator", DepartmentId = "D02" },
                  new Employee { EmployeeId = "E203", EmployeeName = "Kurt Mild", RoleTitle = "Investigator", DepartmentId = "D02" },
                  new Employee { EmployeeId = "E300", EmployeeName = "Cecilia Unosson", RoleTitle = "Manager", DepartmentId = "D03" },
                  new Employee { EmployeeId = "E301", EmployeeName = "Lena Larsson", RoleTitle = "Investigator", DepartmentId = "D03" },
                  new Employee { EmployeeId = "E302", EmployeeName = "Martin Kvist", RoleTitle = "Investigator", DepartmentId = "D03" },
                  new Employee { EmployeeId = "E303", EmployeeName = "Nina Jansson", RoleTitle = "Investigator", DepartmentId = "D03" },
                  new Employee { EmployeeId = "E400", EmployeeName = "David Trastlund", RoleTitle = "Manager", DepartmentId = "D04" },
                  new Employee { EmployeeId = "E401", EmployeeName = "Oskar Ivarsson", RoleTitle = "Investigator", DepartmentId = "D04" },
                  new Employee { EmployeeId = "E402", EmployeeName = "Petra Hermansdotter", RoleTitle = "Investigator", DepartmentId = "D04" },
                  new Employee { EmployeeId = "E403", EmployeeName = "Rolf Gunnarsson", RoleTitle = "Investigator", DepartmentId = "D04" },
                  new Employee { EmployeeId = "E500", EmployeeName = "Emma Svanberg", RoleTitle = "Manager", DepartmentId = "D05" },
                  new Employee { EmployeeId = "E501", EmployeeName = "Susanne Fred", RoleTitle = "Investigator", DepartmentId = "D05" },
                  new Employee { EmployeeId = "E502", EmployeeName = "Torsten Embjörn", RoleTitle = "Investigator", DepartmentId = "D05" },
                  new Employee { EmployeeId = "E503", EmployeeName = "Ulla Davidsson", RoleTitle = "Investigator", DepartmentId = "D05" }
                );
                context.SaveChanges();
            }

            if (!context.Errands.Any())
            {
                //Here the errands with the hardcoded data is and includes a refrence number, place, type of crime, date of observation, observation, investigator information, investigator action, informer name, informer phone, status id (), department id, and employee id (same status id, department id, and employee id as previously in the code). This data is also stored in the database.
                context.Errands.AddRange(
                  new Errand { RefNumber = "2020-45-195", Place = "Skogslunden vid Jensens gård", TypeOfCrime = "Sopor", DateOfObservation = new DateTime(2020, 04, 24), Observation = "Anmälaren var på promeand i skogslunden när hon upptäckte soporna", InvestigatorInfo = "Undersˆkning har gjorts och bland soporna hittades bl.a ett brev till Gˆsta Olsson", InvestigatorAction = "Brev har skickats till Gösta Olsson om soporna och anmälan har gjorts till polisen 2020-05-01", InformerName = "Ada Bengtsson", InformerPhone = "0432-5545522", StatusId = "S_D", DepartmentId = "D05", EmployeeId = "E501" },

                  new Errand { RefNumber = "2020-45-196", Place = "Småstadsjön", TypeOfCrime = "Oljeutsläpp", DateOfObservation = new DateTime(2020, 04, 29), Observation = "Jag såg en oljefläck pÂ vattnet när jag var där för att fiska", InvestigatorInfo = "Undersökning har gjorts på plats, ingen fläck har hittas", InvestigatorAction = "", InformerName = "Bengt Svensson", InformerPhone = "0432-5152255", StatusId = "S_B", DepartmentId = "D04", EmployeeId = "E401" },

                  new Errand { RefNumber = "2020-45-197", Place = "Ödehuset", TypeOfCrime = "Skrot", DateOfObservation = new DateTime(2020, 05, 02), Observation = "Anmälaren körde förbi Ödehuset och upptäcker ett antal bilar och annat skrot", InvestigatorInfo = "Undersökning har gjorts och bilder har tagits", InvestigatorAction = "", InformerName = "Olle Pettersson", InformerPhone = "0432-5255522", StatusId = "S_C", DepartmentId = "D03", EmployeeId = "E301" },

                  new Errand { RefNumber = "2020-45-198", Place = "Restaurang Krögaren", TypeOfCrime = "Buller", DateOfObservation = new DateTime(2020, 06, 04), Observation = "Restaurangen hade för högt ljud på så man inte kunde sova", InvestigatorInfo = "Bullermätning har gjorts. Man håller sig inom riktvården", InvestigatorAction = "Meddelat restaurangen att tänka pÂ ljudet i fortsättning", InformerName = "Roland Jönsson", InformerPhone = "0432-5322255", StatusId = "S_D", DepartmentId = "D03", EmployeeId = "E302" },

                  new Errand { RefNumber = "2020-45-199", Place = "Torget", TypeOfCrime = "Klotter", DateOfObservation = new DateTime(2020, 07, 10), Observation = "Samtliga skräpkorgar och bänkar är nedklottrade", InvestigatorInfo = "", InvestigatorAction = "", InformerName = "Peter Svensson", InformerPhone = "0432-5322555", StatusId = "S_A" }
                );
                context.SaveChanges();
            }

        }
    }
}

