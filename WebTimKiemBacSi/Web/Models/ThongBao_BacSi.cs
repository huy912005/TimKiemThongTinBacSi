using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace Web.Models
{
    public class ThongBao_BacSi
    {
        public int IdBacSi { get; set; }
        public int IdThongBao { get; set; }

        public DateTime? NgayXem { get; set; }

        [StringLength(50)]
        public string TrangThaiXem { get; set; }

        [ForeignKey(nameof(IdBacSi))]
        public virtual BacSi BacSi { get; set; }

        [ForeignKey(nameof(IdThongBao))]
        public virtual ThongBao ThongBao { get; set; }
    }
}
