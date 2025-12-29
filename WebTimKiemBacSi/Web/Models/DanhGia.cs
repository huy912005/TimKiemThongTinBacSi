using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace Web.Models
{
    public class DanhGia
    {
        [Key]
        public int IdDanhGia { get; set; }

        public int? DiemDanhGia { get; set; }

        public string NoiDung { get; set; }

        public DateTime? NgayDanhGia { get; set; }

        public int? IdBacSi { get; set; }
        public int? IdBenhNhan { get; set; }

        [ForeignKey(nameof(IdBacSi))]
        public virtual BacSi BacSi { get; set; }

        [ForeignKey(nameof(IdBenhNhan))]
        public virtual BenhNhan BenhNhan { get; set; }
    }
}
