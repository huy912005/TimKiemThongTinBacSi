using Microsoft.AspNetCore.Mvc.Rendering;

namespace WebTimKiemBacSi.ViewModel
{
    public class TaiKhoanCaNhanVM
    {
        public int Id { get; set; }
        public string HoTen { get; set; }
        public string Email { get; set; }
        public string Role { get; set; }
        public string? SoDienThoai { get; set; }
        public string? CCCD { get; set; }
        public string? soNhaTenDuong { get; set; }
        public string? GioiTinh { get; set; }
        public int? IdPhuongXa { get; set; }
        public List<SelectListItem>? PhuongXaList { get; set; }
        public List<BacSiTheoDoiDTO>? DanhSachTheoDoi { get; set; }
    }
}
public class BacSiTheoDoiDTO
{
    public int IdBacSi { get; set; }
    public string HoTen { get; set; }
    public string ChuyenKhoa { get; set; }
    public string AnhDaiDien { get; set; }
}