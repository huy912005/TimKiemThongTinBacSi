using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace Web.Models
{
    public class LichLamViec
    {
        [Key]
        public int IdLichLamViec { get; set; }

        public DateTime? NgayLamViec { get; set; }

        [StringLength(50)]
        public string KhungGio { get; set; }

        [StringLength(50)]
        public string TrangThai { get; set; }

        public int? IdBacSi { get; set; }
        public int? IdPhong { get; set; }

        [ForeignKey(nameof(IdBacSi))]
        public virtual BacSi BacSi { get; set; }

        [ForeignKey(nameof(IdPhong))]
        public virtual Phong Phong { get; set; }
    }
}
