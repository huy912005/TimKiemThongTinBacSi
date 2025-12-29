using System.ComponentModel.DataAnnotations;

namespace WebTimKiemBacSi.ViewModel
{
    public class GuiThongBaoVM
    {
        [Required(ErrorMessage = "Vui lòng nhập tiêu đề")]
        public string TieuDe { get; set; }

        [Required(ErrorMessage = "Vui lòng nhập nội dung")]
        public string NoiDung { get; set; }

        public string LoaiThongBao { get; set; } = "Hệ thống";
    }
}
