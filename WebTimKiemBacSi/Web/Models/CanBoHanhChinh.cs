using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace Web.Models
{
    public class CanBoHanhChinh
    {
        [Key]
        public int IdCanBo { get; set; }

        [StringLength(15)]
        public string SoDienThoai { get; set; }

        [StringLength(100)]
        public string HoTen { get; set; }

        [StringLength(100)]
        public string Email { get; set; }

        [StringLength(255)]
        public string MatKhau { get; set; }

        public DateTime? NgaySinh { get; set; }

        [StringLength(10)]
        public string GioiTinh { get; set; }

        [StringLength(100)]
        public string ChucVu { get; set; }

        [StringLength(255)]
        public string soNhaTenDuong { get; set; }

        [StringLength(20)]
        public string CCCD { get; set; }

        public int? IdBenhVien { get; set; }
        public int? IdPhuongXa { get; set; }

        [ForeignKey(nameof(IdBenhVien))]
        public virtual BenhVien BenhVien { get; set; }

        [ForeignKey(nameof(IdPhuongXa))]
        public virtual PhuongXa PhuongXa { get; set; }

        // Navigation
        public virtual ICollection<ThongBao> ThongBaos { get; set; } = new List<ThongBao>();
        public virtual ICollection<BaoCao> BaoCaos_AsCanBo { get; set; } = new List<BaoCao>();
    }
}
