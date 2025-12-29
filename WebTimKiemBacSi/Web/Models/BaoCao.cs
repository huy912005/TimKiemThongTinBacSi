using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace Web.Models
{
    public class BaoCao
    {
        [Key]
        public int IdBaoCao { get; set; }

        public string NoiDung { get; set; }

        [StringLength(100)]
        public string LoaiBaoCao { get; set; }

        public DateTime? NgayTaoBaoCao { get; set; }

        public int? IdCanBo { get; set; }
        public int? IdBacSi { get; set; }
        public int? IdBenhNhan { get; set; } 

        [ForeignKey(nameof(IdCanBo))]
        public virtual CanBoHanhChinh CanBoHanhChinh { get; set; }

        [ForeignKey(nameof(IdBacSi))]
        public virtual BacSi BacSi { get; set; }

        [ForeignKey(nameof(IdBenhNhan))]
        public virtual BenhNhan BenhNhan { get; set; }
    }
}
