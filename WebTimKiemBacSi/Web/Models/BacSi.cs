using System.ComponentModel;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace Web.Models
{
    public class BacSi
    {
        [Key]
        public int IdBacSi { get; set; }

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
        public string BangCap { get; set; }

        public int? NamKinhNghiem { get; set; }

        [StringLength(255)]
        public string ChungChiHanhNghe { get; set; }

        public string ThanhTuu { get; set; }

        public string MoTa { get; set; }

        [StringLength(255)]
        public string AnhDaiDien { get; set; }

        [StringLength(255)]
        public string soNhaTenDuong { get; set; }

        [StringLength(20)]
        public string CCCD { get; set; }
        public int TrangThai { get; set; }

        public int? IdBenhVien { get; set; }
        public int? IdPhuongXa { get; set; }

        [ForeignKey(nameof(IdBenhVien))]
        public virtual BenhVien BenhVien { get; set; }

        [ForeignKey(nameof(IdPhuongXa))]
        public virtual PhuongXa PhuongXa { get; set; }

        // Navigation
        public virtual ICollection<ChuyenKhoa_BacSi> ChuyenKhoa_BacSis { get; set; } = new List<ChuyenKhoa_BacSi>();
        public virtual ICollection<LichLamViec> LichLamViecs { get; set; } = new List<LichLamViec>();
        public virtual ICollection<ThongBao_BacSi> ThongBao_BacSis { get; set; } = new List<ThongBao_BacSi>();
        public virtual ICollection<TheoDoi> TheoDois_AsBacSi { get; set; } = new List<TheoDoi>();
        public virtual ICollection<DanhGia> DanhGias { get; set; } = new List<DanhGia>();
        public virtual ICollection<BaoCao> BaoCaos_AsBacSi { get; set; } = new List<BaoCao>();
    }
}
