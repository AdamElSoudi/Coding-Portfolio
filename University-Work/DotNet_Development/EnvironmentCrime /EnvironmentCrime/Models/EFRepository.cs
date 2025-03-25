using System;
using System.Threading.Channels;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Logging;

namespace EnvironmentCrime.Models
{
	public class EFRepository : IRepository
	{

		private readonly ApplicationDbContext context;

        private IHttpContextAccessor httpContext;

		public EFRepository(ApplicationDbContext ctx, IHttpContextAccessor hCtx)
		{
			context = ctx;
            httpContext = hCtx;

        }

		public IQueryable<Errand> Errands => context.Errands.Include(td => td.Samples).Include(td => td.Pictures);
		public IQueryable<Department> Departments => context.Departments;
		public IQueryable<ErrandStatus> ErrandStatuses => context.ErrandStatuses;
		public IQueryable<Employee> Employees => context.Employees;
		public IQueryable<Picture> Pictures => context.Pictures;
		public IQueryable<Sample> Samples => context.Samples;
		public IQueryable<Sequence> Sequences => context.Sequences;

        public Task<Errand> GetErrandDetail(int id)
        {
            return Task.Run(() =>
            {
                var errandDetail = Errands.Where(td => td.ErrandId == id).First();
                return errandDetail;
            }
                );
        }

        public void SaveErrand(Errand errand)
        {
            if (errand.ErrandId == 0)
            {
                var idChecker = context.Sequences.FirstOrDefault(idNummer => idNummer.Id == 1);
                errand.RefNumber = "2022-45-" + idChecker.CurrentValue;
                errand.StatusId = "S_A";
                idChecker.CurrentValue++;
                context.Errands.Add(errand);
            }
            context.SaveChanges(); //Saves the data to the database.
    }

        public Errand DeleteErrand(int id)
        {
            Errand dbEntry = context.Errands.FirstOrDefault(ed => ed.ErrandId == id);

            if (dbEntry != null)
            {
                context.Errands.Remove(dbEntry);
            }
            context.SaveChanges();
            return dbEntry;
        }

        //Updates the department the errand belongs to.
        public void UpdateDepartment(string departmentId, int errandId)
        {
            if(!departmentId.Contains("D00") && (!departmentId.Contains("Välj")))
            {
                Errand updateErrand = context.Errands.FirstOrDefault(er => er.ErrandId == errandId);
                updateErrand.DepartmentId = departmentId;
                context.SaveChanges();
            }
        }

        //Updates the status of the errand.
        public void UpdateErrandStatus(string statusId, int errandId)
        {
            if (!statusId.Contains("S_A") && (!statusId.Contains("Välj")))
            {
                Errand updateErrand = context.Errands.FirstOrDefault(er => er.ErrandId == errandId);
                updateErrand.StatusId = statusId;
                context.SaveChanges();
            }
        }

        //Updates which employee is taking care of the errand.
        public void UpdateEmployee(string employeeId, int errandId)
        {
            if (!employeeId.Contains("Välj"))
            {
                Errand updateErrand = context.Errands.FirstOrDefault(er => er.ErrandId == errandId);
                updateErrand.EmployeeId = employeeId;
                context.SaveChanges();
            }
        }

        public void UpdateAction(string events, int errandId)
        {
            Errand updateErrand = context.Errands.FirstOrDefault(er => er.ErrandId == errandId);
            updateErrand.InvestigatorAction = updateErrand.InvestigatorAction + " " + events;
            context.SaveChanges();
        }

        public void UpdateInfo(string information, int errandId)
        {
            Errand updateErrand = context.Errands.FirstOrDefault(er => er.ErrandId == errandId);
            updateErrand.InvestigatorInfo = updateErrand.InvestigatorInfo + " " + information;
            context.SaveChanges();
        }

        //Saves the uploaded file to the database.
        public void SaveSampleToDB(int id, string sampleName)
        {
            Sample saveSample = new()
            {
                errandId = id,
                sampleName = sampleName
            };
            context.Samples.Add(saveSample);
            context.SaveChanges();
        }

        //Saves the uploaded image to the database.
        public void SaveImageToDB(int id, string imageName)
        {
            Picture saveImage = new()
            {
                errandId = id,
                pictureName = imageName
            };
            context.Pictures.Add(saveImage);
            context.SaveChanges();
        }

        public void UpdateStatus(string statusId, int errandId)
        {
            if (!statusId.Contains("S_A") && (!statusId.Contains("Välj")))
            {
                Errand updateEr = context.Errands.FirstOrDefault(x => x.ErrandId == errandId);
                updateEr.StatusId = statusId;
                context.SaveChanges();
            }
        }

        public IEnumerable<MyErrand> ErrandList()
        {
            var errandList = from err in Errands
                             join stat in ErrandStatuses on err.StatusId equals stat.StatusId
                             join dep in Departments on err.DepartmentId equals dep.DepartmentId
                             into departmentErrand
                             from deptE in departmentErrand.DefaultIfEmpty()
                             join em in Employees on err.EmployeeId equals em.EmployeeId
                             into employeeErrand
                             from empE in employeeErrand.DefaultIfEmpty()
                             orderby err.RefNumber descending
                             select new MyErrand
                             {
                                 DateOfObservation = err.DateOfObservation,
                                 ErrandId = err.ErrandId,
                                 RefNumber = err.RefNumber,
                                 TypeOfCrime = err.TypeOfCrime,
                                 StatusName = stat.StatusName,
                                 DepartmentName = (err.DepartmentId == null ? "ej tillsatt" : deptE.DepartmentName),
                                 EmployeeName = (err.EmployeeId == null ? "ej tillsatt" : empE.EmployeeName)
                             };
            return errandList;
        }

        
        public string GetLoginRole()
        {
            var userName = httpContext.HttpContext.User.Identity.Name;
            var employeeRole = Employees.FirstOrDefault(td => td.EmployeeId == userName).RoleTitle;
            return employeeRole.ToString();
        }

        public IEnumerable<MyErrand> ErrandListInvestigator()
        {
            var errandList = ErrandList();
            var userName = httpContext.HttpContext.User.Identity.Name;
            var employeeName = Employees.FirstOrDefault(td => td.EmployeeId == userName).EmployeeName;
            return errandList.Where(td => td.EmployeeName == employeeName);
        }

        public IEnumerable<MyErrand> ErrandListManager()
        {
            var errandList = ErrandList();
            var userName = httpContext.HttpContext.User.Identity.Name;
            var employeeDepartment = Employees.FirstOrDefault(td => td.EmployeeId == userName).DepartmentId;
            var departmentName = Departments.FirstOrDefault(td => td.DepartmentId == employeeDepartment).DepartmentName;
            return errandList.Where(td => td.DepartmentName == departmentName);
        }

        public IEnumerable<Employee> GetDepartmentEmployees(string id)
        {
            var getDepartment = Employees.FirstOrDefault(td => td.EmployeeId == id).DepartmentId;
            var employeeList = Employees.Where(td => td.DepartmentId == getDepartment).AsEnumerable();
            return employeeList;
        }
    }
}

