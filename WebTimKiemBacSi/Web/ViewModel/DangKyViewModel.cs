using System.ComponentModel.DataAnnotations;

namespace WebTimKiemBacSi.ViewModel
{
    public class DangKyViewModel
    {
        [Required] 
        public string HoTen { get; set; }
        [Required]
        [EmailAddress] 
        public string Email { get; set; }
        [Required] 
        public string SoDienThoai { get; set; }
        [Required]
        [DataType(DataType.Password)] 
        public string MatKhau { get; set; }
        public string Role { get; set; } = "BenhNhan";
    }
}
