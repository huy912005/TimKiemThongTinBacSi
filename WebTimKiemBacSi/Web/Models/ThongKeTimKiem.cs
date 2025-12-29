using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace WebTimKiemBacSi.Models
{
    [Table("ThongKeTimKiem")]
    public class ThongKeTimKiem
    {
        [Key]
        public string TuKhoa { get; set; } 
        public int SoLuotTim { get; set; }
        public DateTime? NgayCapNhatCuoi { get; set; }
    }
}
