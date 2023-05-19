using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;

namespace UrgentNews.Controllers;

[ApiController]
[Route("[controller]")]
public class NewsController : ControllerBase
{
    private readonly UrgentNewsContext _context;

    public NewsController(UrgentNewsContext context)
    {
        _context = context;
    }

    [HttpGet]
    public async Task<List<News>> GetNews()
    {
        return await _context.News.ToListAsync();
    }
}