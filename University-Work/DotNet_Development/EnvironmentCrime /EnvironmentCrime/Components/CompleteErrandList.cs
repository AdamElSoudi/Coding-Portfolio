using System;
using EnvironmentCrime.Models;
using Microsoft.AspNetCore.Mvc;

namespace EnvironmentCrime.Components
{
	public class CompleteErrandList : ViewComponent
	{
		private IRepository repository;

		public CompleteErrandList(IRepository repo)
		{
			repository = repo;
		}

		public async Task<IViewComponentResult> InvokeAsync(IEnumerable<MyErrand> MyErrandList)
		{
			var getRole = repository.GetLoginRole();

			ViewBag.RoleView = getRole;
			return View(MyErrandList);
		}
	}
}

