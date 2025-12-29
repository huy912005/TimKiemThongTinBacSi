using System.ComponentModel.DataAnnotations;

namespace Web.Models
{
    public class TinhThanh
    {
        [Key]
        public int IdTinhThanh { get; set; }

        [Required]
        [StringLength(100)]
        public string TenTinhThanh { get; set; }
        public virtual ICollection<PhuongXa> PhuongXas { get; set; } = new List<PhuongXa>();
    }
}
