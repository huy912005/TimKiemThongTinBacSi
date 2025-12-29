using Microsoft.AspNetCore.Authentication;
using Microsoft.AspNetCore.Authentication.Cookies;
using Microsoft.AspNetCore.Mvc;
using System.Threading.Tasks;
using Web.Data;
using Web.Models;
using WebTimKiemBacSi.ViewModel;

namespace WebTimKiemBacSi.Controllers
{
    public class TaiKhoanController : Controller
    {
        private readonly ApplicationDbContext _db;
        public TaiKhoanController(ApplicationDbContext db)
        {
            _db = db;
        }
        [HttpGet]
        public IActionResult DangKy()
        {
            return View();
        }
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> DangKy(DangKyViewModel dangKy)
        {
            if (ModelState.IsValid)
            {
                if (_db.BacSi.Any(b => b.Email == dangKy.Email) || _db.BenhNhan.Any(bn => bn.Email == dangKy.Email) || _db.CanBoHanhChinh.Any(cb => cb.Email == dangKy.Email))
                {
                    ModelState.AddModelError("Email", "Email đã được sử dụng.");
                    return View(dangKy);
                }
                switch (dangKy.Role)
                {
                    case "BacSi":
                        var bacsi = new BacSi
                        {
                            HoTen = dangKy.HoTen,
                            Email = dangKy.Email,
                            SoDienThoai = dangKy.SoDienThoai,
                            MatKhau = dangKy.MatKhau,
                            TrangThai = 1
                        };
                        _db.BacSi.Add(bacsi);
                        _db.SaveChanges();
                        break;
                    case "CanBoHanhChinh":
                        var canbohanhchinh = new CanBoHanhChinh
                        {
                            HoTen = dangKy.HoTen,
                            Email = dangKy.Email,
                            SoDienThoai = dangKy.SoDienThoai,
                            MatKhau = dangKy.MatKhau
                        };
                        _db.CanBoHanhChinh.Add(canbohanhchinh);
                        _db.SaveChanges();
                        break;
                    default:
                        var benhnhan = new BenhNhan
                        {
                            HoTen = dangKy.HoTen,
                            Email = dangKy.Email,
                            SoDienThoai = dangKy.SoDienThoai,
                            MatKhau = dangKy.MatKhau
                        };
                        _db.BenhNhan.Add(benhnhan);
                        _db.SaveChanges();
                        break;
                }
                TempData["Success"] = "Đăng ký tài khoản thành công!";
                return RedirectToAction("DangNhap");
            }
            return View(dangKy);
        }
        [HttpGet]
        public IActionResult DangNhap()
        {
            return View();
        }
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> DangNhap(string email,string password)
        {
            if(string.IsNullOrWhiteSpace(email) || string.IsNullOrWhiteSpace(password))
            {
                ModelState.AddModelError(string.Empty, "Vui lòng nhập đầy đủ thông tin.");
                return View();
            }
            object user = null;
            string role = "";
            string userId = "";
            var bacSi=_db.BacSi.FirstOrDefault(b => b.Email == email && b.MatKhau == password);
            if(bacSi != null)
            {
                if(bacSi.TrangThai != 1)
                {
                    ModelState.AddModelError(string.Empty, "Tài khoản của bạn đang bị khóa hoặc chưa được kích hoạt.");
                    return View();
                }
                user = bacSi;
                role = "BacSi";
                userId = bacSi.IdBacSi.ToString();
            }
            if (user==null)
            {
                var benhNhan = _db.BenhNhan.FirstOrDefault(bn => bn.Email == email && bn.MatKhau == password);
                if (benhNhan != null)
                {
                    user= benhNhan;
                    role = "BenhNhan";
                    userId = benhNhan.IdBenhNhan.ToString();
                }
            }
            if(user==null)
            {
                var canBoHanhChinh = _db.CanBoHanhChinh.FirstOrDefault(cb => cb.Email == email && cb.MatKhau == password);
                if (canBoHanhChinh != null)
                {
                    user= canBoHanhChinh;
                    role = "CanBoHanhChinh";
                    userId = canBoHanhChinh.IdCanBo.ToString();
                }
            }
            if(user!=null)
            {
                var claims = new List<System.Security.Claims.Claim>
                {
                    new System.Security.Claims.Claim(System.Security.Claims.ClaimTypes.Name, (user as dynamic).HoTen),
                    new System.Security.Claims.Claim(System.Security.Claims.ClaimTypes.Email, (user as dynamic).Email),
                    new System.Security.Claims.Claim(System.Security.Claims.ClaimTypes.Role, role),
                    new System.Security.Claims.Claim("UserId", userId)
                };
                var identity = new System.Security.Claims.ClaimsIdentity(claims, CookieAuthenticationDefaults.AuthenticationScheme);
                await HttpContext.SignInAsync(CookieAuthenticationDefaults.AuthenticationScheme, new System.Security.Claims.ClaimsPrincipal(identity));
                TempData["Success"] = "Đăng nhập thành công!";
                return RedirectToAction("Index", "Home");
            }
            ModelState.AddModelError(string.Empty, "Email hoặc mật khẩu không đúng.");
            return View();
        }
        public async Task<IActionResult> DangXuat()
        {
            await HttpContext.SignOutAsync(CookieAuthenticationDefaults.AuthenticationScheme);
            return RedirectToAction("Index", "Home");
        }
    }
}
