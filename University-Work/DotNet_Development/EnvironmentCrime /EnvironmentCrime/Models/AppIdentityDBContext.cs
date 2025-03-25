using System;
using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Identity.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore;

namespace EnvironmentCrime.Models
{
	public class AppIdentityDBContext : IdentityDbContext<IdentityUser>
	{
		public AppIdentityDBContext(DbContextOptions<AppIdentityDBContext> options) : base(options)
		{

		}
	}
}

