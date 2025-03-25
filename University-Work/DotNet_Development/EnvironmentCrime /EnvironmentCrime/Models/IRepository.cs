using System;
using System.Threading.Tasks;
using EnvironmentCrime.Models;

namespace EnvironmentCrime.Models
{
    public interface IRepository
    {
        //Create
        void SaveErrand(Errand errand);



        //Read
        IQueryable<Errand> Errands { get; }
        IQueryable<Department> Departments { get; }
        IQueryable<ErrandStatus> ErrandStatuses { get; }
        IQueryable<Employee> Employees { get; }
        IQueryable<Picture> Pictures { get; }
        IQueryable<Sample> Samples { get; }
        IQueryable<Sequence> Sequences { get; }

        Task<Errand> GetErrandDetail(int id);


        //Update
        void UpdateDepartment(String departmentId, int errandId);
        void UpdateErrandStatus(String statusId, int errandId);
        void UpdateEmployee(String employeeId, int errandId);

        void UpdateAction(string events, int errandId);
        void UpdateInfo(string information, int errandId);
        void UpdateStatus(string statusId, int errandId);

        void SaveSampleToDB(int id, string sampleName);
        void SaveImageToDB(int id, string imageName);

        string GetLoginRole();

        IEnumerable<MyErrand> ErrandList();
        IEnumerable<MyErrand> ErrandListInvestigator();
        IEnumerable<MyErrand> ErrandListManager();
        public IEnumerable<Employee> GetDepartmentEmployees(string id);

        //Delete
        Errand DeleteErrand(int errandId);
    }
}

