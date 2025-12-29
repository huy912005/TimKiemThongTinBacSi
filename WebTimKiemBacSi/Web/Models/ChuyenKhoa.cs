using System.ComponentModel.DataAnnotations;

namespace Web.Models
{
    public class ChuyenKhoa
    {
        [Key]
        public int IdChuyenKhoa { get; set; }

        [StringLength(150)]
        public string TenChuyenKhoa { get; set; }

        public string MoTa { get; set; }
        public virtual ICollection<ChuyenKhoa_BacSi> ChuyenKhoa_BacSis { get; set; } = new List<ChuyenKhoa_BacSi>();
    }
}
