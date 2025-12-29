using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace Web.Models
{
    public class ThongBao
    {
        [Key]
        public int IdThongBao { get; set; }

        [StringLength(255)]
        public string TieuDe { get; set; }

        public string NoiDung { get; set; }

        public DateTime? NgayGui { get; set; }

        [StringLength(100)]
        public string LoaiThongBao { get; set; }

        public int? IdCanBo { get; set; }

        [ForeignKey(nameof(IdCanBo))]
        public virtual CanBoHanhChinh CanBoHanhChinh { get; set; }

        // Navigation
        public virtual ICollection<ThongBao_BacSi> ThongBao_BacSis { get; set; } = new List<ThongBao_BacSi>();
        public virtual ICollection<ThongBao_BenhNhan> ThongBao_BenhNhans { get; set; } = new List<ThongBao_BenhNhan>();
    }
}
