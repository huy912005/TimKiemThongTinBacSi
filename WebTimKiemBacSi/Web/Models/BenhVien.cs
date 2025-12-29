using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace Web.Models
{
    public class BenhVien
    {
        [Key]
        public int IdBenhVien { get; set; }

        [StringLength(200)]
        public string TenBenhVien { get; set; }

        [StringLength(20)]
        public string HotLine { get; set; }

        [StringLength(100)]
        public string Email { get; set; }

        public string MoTa { get; set; }

        [StringLength(255)]
        public string DiaDiem { get; set; }

        public int? IdPhuongXa { get; set; }

        [ForeignKey(nameof(IdPhuongXa))]
        public virtual PhuongXa PhuongXa { get; set; }
        public virtual ICollection<Khu> Khus { get; set; } = new List<Khu>();
        public virtual ICollection<BacSi> BacSis { get; set; } = new List<BacSi>();
        public virtual ICollection<CanBoHanhChinh> CanBoHanhChinhs { get; set; } = new List<CanBoHanhChinh>();
    }
}
