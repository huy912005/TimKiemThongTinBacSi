using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace Web.Models
{
    public class Phong
    {
        [Key]
        public int IdPhong { get; set; }

        [StringLength(100)]
        public string TenPhong { get; set; }

        public int? Tang { get; set; }

        public int? IdKhu { get; set; }

        [ForeignKey(nameof(IdKhu))]
        public virtual Khu Khu { get; set; }
        public virtual ICollection<LichLamViec> LichLamViecs { get; set; } = new List<LichLamViec>();
    }
}
