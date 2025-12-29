using System.ComponentModel.DataAnnotations.Schema;

namespace Web.Models
{
    public class TheoDoi
    {
        public int IdBacSi { get; set; }
        public int IdBenhNhan { get; set; }

        public DateTime? NgayBatDauTheoDoi { get; set; }

        [ForeignKey(nameof(IdBacSi))]
        public virtual BacSi BacSi { get; set; }

        [ForeignKey(nameof(IdBenhNhan))]
        public virtual BenhNhan BenhNhan { get; set; }
    }
}
