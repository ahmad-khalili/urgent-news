using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Internal;

namespace UrgentNews;

public class UrgentNewsContext : DbContext
{
    public UrgentNewsContext(DbContextOptions<UrgentNewsContext> dbContextOptions): base(dbContextOptions)
    {
        
    }
    
    public DbSet<News> News { get; set; }
}