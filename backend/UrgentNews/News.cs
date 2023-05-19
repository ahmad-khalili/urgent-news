using System.ComponentModel.DataAnnotations;

namespace UrgentNews;

public class News
{
    [Key]
    public int Id { get; set; }

    public string Title { get; set; } = string.Empty;

    public string Content { get; set; } = string.Empty;
}