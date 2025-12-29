using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace Web.Models
{
    public class PhuongXa
    {
        [Key]
        public int IdPhuongXa { get; set; }

        [StringLength(100)]
        public string TenPhuongXa { get; set; }

        public int? IdTinhThanh { get; set; }

        [ForeignKey(nameof(IdTinhThanh))]
        public virtual TinhThanh TinhThanh { get; set; }

        public virtual ICollection<BenhVien> BenhViens { get; set; } = new List<BenhVien>();
        public virtual ICollection<BacSi> BacSis { get; set; } = new List<BacSi>();
        public virtual ICollection<BenhNhan> BenhNhans { get; set; } = new List<BenhNhan>();
        public virtual ICollection<CanBoHanhChinh> CanBoHanhChinhs { get; set; } = new List<CanBoHanhChinh>();
    }
}
