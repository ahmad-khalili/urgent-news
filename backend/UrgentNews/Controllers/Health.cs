using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;

namespace UrgentNews.Controllers;

[ApiController]
[Route("[controller]")]
public class HealthController : ControllerBase
{
    [HttpGet("connection")]
    public string GetConnectionString()
    {
        return Environment.GetEnvironmentVariable("UrgentNewsConnection") ??
               "Not Found";
    }
}