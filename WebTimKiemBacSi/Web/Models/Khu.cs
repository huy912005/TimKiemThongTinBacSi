using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace Web.Models
{
    public class Khu
    {
        [Key]
        public int IdKhu { get; set; }

        [StringLength(100)]
        public string TenKhu { get; set; }

        public int? IdBenhVien { get; set; }

        [ForeignKey(nameof(IdBenhVien))]
        public virtual BenhVien BenhVien { get; set; } 
        public virtual ICollection<Phong> Phongs { get; set; } = new List<Phong>();
    }
}
