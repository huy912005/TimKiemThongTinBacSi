using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace Web.Models
{
    public class TimKiem
    {
        [Key]
        public int IdTimKiem { get; set; }

        [StringLength(255)]
        public string TuKhoaTK { get; set; }

        public DateTime? ThoiGianTK { get; set; }

        [StringLength(255)]
        public string ViTriTimKiem { get; set; }

        public int? IdBenhNhan { get; set; }

        [ForeignKey(nameof(IdBenhNhan))]
        public virtual BenhNhan BenhNhan { get; set; }
    }
}
