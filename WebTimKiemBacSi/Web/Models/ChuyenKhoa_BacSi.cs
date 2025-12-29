using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace Web.Models
{
    public class ChuyenKhoa_BacSi
    {
        public int IdBacSi { get; set; }
        public int IdChuyenKhoa { get; set; }

        public virtual BacSi BacSi { get; set; }
        public virtual ChuyenKhoa ChuyenKhoa { get; set; }
    }
}
