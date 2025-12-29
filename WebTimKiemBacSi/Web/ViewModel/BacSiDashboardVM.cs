using Microsoft.AspNetCore.Mvc.Rendering;
using Web.Models;
using WebTimKiemBacSi.ViewModel.DTO;

namespace WebTimKiemBacSi.ViewModel
{
    public class BacSiDashboardVM
    {
        public BacSi HoSo { get; set; }
        public List<BenhNhanTheoDoiDTO> DanhSachBenhNhanTheoDoi { get; set; }
        public List<ThongBao_BacSi> ThongBaoMoi { get; set; }
        public List<SelectListItem> PhuongXaList { get; set; }
        public List<SelectListItem> BenhVienList { get; set; }
    }
}
