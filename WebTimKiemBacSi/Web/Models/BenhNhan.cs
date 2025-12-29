using Microsoft.AspNetCore.Mvc.ModelBinding.Validation;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace Web.Models
{
    public class BenhNhan
    {
        [Key]
        public int IdBenhNhan { get; set; }

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
        public string? GioiTinh { get; set; }

        public DateTime? NgayDangKy { get; set; }

        [StringLength(255)]
        public string? soNhaTenDuong { get; set; }

        [StringLength(20)]
        public string? CCCD { get; set; }

        public int? IdPhuongXa { get; set; }

        [ForeignKey(nameof(IdPhuongXa))]
        [ValidateNever]
        public virtual PhuongXa? PhuongXa { get; set; }

        // Navigation
        public virtual ICollection<ThongBao_BenhNhan> ThongBao_BenhNhans { get; set; } = new List<ThongBao_BenhNhan>();
        public virtual ICollection<TheoDoi> TheoDois_AsBenhNhan { get; set; } = new List<TheoDoi>();
        public virtual ICollection<DanhGia> DanhGias { get; set; } = new List<DanhGia>();
        public virtual ICollection<TimKiem> TimKiems { get; set; } = new List<TimKiem>();
        public virtual ICollection<BaoCao> BaoCaos_AsBenhNhan { get; set; } = new List<BaoCao>();
    }
}
