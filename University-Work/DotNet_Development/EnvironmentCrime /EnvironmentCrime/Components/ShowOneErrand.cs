using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using EnvironmentCrime.Models;

namespace EnvironmentCrime.Components
{
	public class ShowOneErrand : ViewComponent
	{
		private readonly IRepository repository;

		public ShowOneErrand(IRepository repo)
		{
			repository = repo;
		}

		public async Task<IViewComponentResult> InvokeAsync(int id)
		{
			var errandDetail = await repository.GetErrandDetail(id);
			return View(errandDetail);
        }
    }
}

