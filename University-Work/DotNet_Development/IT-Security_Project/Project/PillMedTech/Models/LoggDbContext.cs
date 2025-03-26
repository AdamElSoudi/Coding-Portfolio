using System;
using Microsoft.EntityFrameworkCore;

namespace PillMedTech.Models
{
	public class LoggDbContext : DbContext
    {
        public LoggDbContext(DbContextOptions<LoggDbContext> options) : base(options) { }
        public DbSet<Logger> Loggers { get; set; }
    }
}

