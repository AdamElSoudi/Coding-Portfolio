using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using EnvironmentCrime.Models;
using SessionTest.Infrastructure;
using Microsoft.AspNetCore.Authorization;

// For more information on enabling MVC for empty projects, visit https://go.microsoft.com/fwlink/?LinkID=397860

namespace EnvironmentCrime.Controllers
{
    //The users role has to be an investigator in order to be able to move to any of the views in this controller.
    [Authorize(Roles = "Investigator")]
    public class InvestigatorController : Controller
    {
        private readonly IRepository repository;
        private IWebHostEnvironment environment;

        public InvestigatorController(IRepository repo, IWebHostEnvironment env)
        {
            repository = repo;
            environment = env;
        }


        // GET: /<controller>/
        public ViewResult CrimeInvestigator(int id)
        {
            ViewBag.ID = id;
            ViewBag.ErrandStatusList = repository.ErrandStatuses;
            TempData["Id"] = id;
            return View();
        }

        public ViewResult StartInvestigator()
        {
            ViewBag.ErrandStatus = repository.ErrandStatuses;
            ViewBag.RoleView = repository.GetLoginRole();
            return View(repository.ErrandListInvestigator());
        }

        //Here the file upload is being created.
        public async Task<IActionResult> SaveStatus(ErrandStatus errandStatus, string events, string information, IFormFile loadSample, IFormFile loadImage)
        {
            int id = int.Parse(TempData["Id"].ToString());
            repository.UpdateErrandStatus(errandStatus.StatusId, id);

          
            //Creates the path to the files.
            var tempPath = Path.GetTempFileName();

            if(events != null)
            {
                repository.UpdateAction(events, id);
            }

            if(information != null)
            {
                repository.UpdateInfo(information, id);
            }

            //Checks if the user has chosen a file and if the file is in the correct format (pdf), if this checks out, the file is uploaded and can be found in the wwwroot map under the sample map in the uploads map. Guid is used to generate a random number infront of the file name to ensure no two files have the same name (this number is not visable to the user).
            if(loadSample != null && (loadSample.FileName.ToLower().Contains("pdf")))
            {
                using(var stream = new FileStream(tempPath, FileMode.Create))
                {
                    await loadSample.CopyToAsync(stream);
                }

                string samplePath = "Uploads/Sample";
                string uniqueSampleName = Guid.NewGuid().ToString() + "_" + loadSample.FileName;
                var pathSample = Path.Combine(environment.WebRootPath, samplePath, uniqueSampleName);
                System.IO.File.Move(tempPath, pathSample);
                repository.SaveSampleToDB(id, uniqueSampleName);
            }

            //Checks if the user has chosen an image and if the image is in the correct format (jpg or jpeg), if this checks out, the image is uploaded and can be found in the wwwroot map under the image map in the uploads map. Guid is used to generate a random number infront of the image name to ensure no two images have the same name (this number is not visable to the user).
            if (loadImage != null && (loadImage.FileName.ToLower().Contains("jpg") || (loadImage.FileName.ToLower().Contains("jpeg"))))
            {
                using (var stream = new FileStream(tempPath, FileMode.Create))
                {
                    await loadImage.CopyToAsync(stream);
                }

                string ImagePath = "Uploads/Image";
                string uniqueImageName = Guid.NewGuid().ToString() + "_" + loadImage.FileName;
                var pathImage = Path.Combine(environment.WebRootPath, ImagePath, uniqueImageName);
                System.IO.File.Move(tempPath, pathImage);
                repository.SaveImageToDB(id, uniqueImageName);
            }
            return RedirectToAction("StartInvestigator");
        }
    }
}