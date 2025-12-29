using Microsoft.AspNetCore.Authentication;
using Microsoft.AspNetCore.Authentication.Cookies;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using System.Security.Claims;
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
                            MatKhau = dangKy.MatKhau,
                            NgayDangKy = DateTime.Now
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
        public async Task<IActionResult> DangNhap(string email, string password)
        {
            if (string.IsNullOrWhiteSpace(email) || string.IsNullOrWhiteSpace(password))
            {
                ModelState.AddModelError(string.Empty, "Vui lòng nhập đầy đủ thông tin.");
                return View();
            }
            object user = null;
            string role = "";
            string userId = "";
            var bacSi = _db.BacSi.FirstOrDefault(b => b.Email == email && b.MatKhau == password);
            if (bacSi != null)
            {
                if (bacSi.TrangThai != 1)
                {
                    ModelState.AddModelError(string.Empty, "Tài khoản của bạn đang bị khóa hoặc chưa được kích hoạt.");
                    return View();
                }
                user = bacSi;
                role = "BacSi";
                userId = bacSi.IdBacSi.ToString();
            }
            if (user == null)
            {
                var benhNhan = _db.BenhNhan.FirstOrDefault(bn => bn.Email == email && bn.MatKhau == password);
                if (benhNhan != null)
                {
                    user = benhNhan;
                    role = "BenhNhan";
                    userId = benhNhan.IdBenhNhan.ToString();
                }
            }
            if (user == null)
            {
                var canBoHanhChinh = _db.CanBoHanhChinh.FirstOrDefault(cb => cb.Email == email && cb.MatKhau == password);
                if (canBoHanhChinh != null)
                {
                    user = canBoHanhChinh;
                    role = "CanBoHanhChinh";
                    userId = canBoHanhChinh.IdCanBo.ToString();
                }
            }
            if (user != null)
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
                if (role == "CanBoHanhChinh")
                    return RedirectToAction("Dashboard", "TaiKhoan");
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
        [HttpGet]
        public IActionResult TaiKhoanCaNhan()
        {
            var userId = User.FindFirstValue("UserId");
            var role = User.FindFirstValue(ClaimTypes.Role);
            var email = User.FindFirstValue(ClaimTypes.Email);
            if (userId == null)
                return RedirectToAction("DangNhap");
            int id = int.Parse(userId);
            TaiKhoanCaNhanVM taiKhoanCaNhanVM = new TaiKhoanCaNhanVM
            {
                Id = id,
                Role = role,
                Email = email
            };
            if (role == "BenhNhan")
            {
                var idBenhNhan = _db.BenhNhan.Find(id);
                if(idBenhNhan != null)
                {
                    taiKhoanCaNhanVM.HoTen = idBenhNhan.HoTen;
                    taiKhoanCaNhanVM.SoDienThoai = idBenhNhan.SoDienThoai;
                    taiKhoanCaNhanVM.CCCD = idBenhNhan.CCCD;
                    taiKhoanCaNhanVM.soNhaTenDuong = idBenhNhan.soNhaTenDuong;
                    taiKhoanCaNhanVM.GioiTinh = idBenhNhan.GioiTinh;
                    taiKhoanCaNhanVM.IdPhuongXa = idBenhNhan.IdPhuongXa;
                    taiKhoanCaNhanVM.DanhSachTheoDoi = _db.TheoDoi.Where(kt => kt.IdBenhNhan == id).Include(bd => bd.BacSi).Select(td => new BacSiTheoDoiDTO
                    {
                        IdBacSi = td.BacSi.IdBacSi,
                        AnhDaiDien = td.BacSi.AnhDaiDien,
                        HoTen = td.BacSi.HoTen,
                        ChuyenKhoa = td.BacSi.BangCap
                    }).ToList();
                }
            }
            else if (role == "BacSi")
            {
                var idBacSi = _db.BacSi.Find(id);
                taiKhoanCaNhanVM.HoTen = idBacSi.HoTen;
                taiKhoanCaNhanVM.SoDienThoai = idBacSi.SoDienThoai;
                taiKhoanCaNhanVM.CCCD = idBacSi.CCCD;
                taiKhoanCaNhanVM.soNhaTenDuong = idBacSi.soNhaTenDuong;
                taiKhoanCaNhanVM.GioiTinh = idBacSi.GioiTinh;
                taiKhoanCaNhanVM.IdPhuongXa = idBacSi.IdPhuongXa;
            }
            else
            {
                var idCanBo = _db.CanBoHanhChinh.Find(id);
                taiKhoanCaNhanVM.HoTen = idCanBo.HoTen;
                taiKhoanCaNhanVM.SoDienThoai = idCanBo.SoDienThoai;
                taiKhoanCaNhanVM.CCCD = idCanBo.CCCD;
                taiKhoanCaNhanVM.soNhaTenDuong = idCanBo.soNhaTenDuong;
                taiKhoanCaNhanVM.GioiTinh = idCanBo.GioiTinh;
                taiKhoanCaNhanVM.IdPhuongXa = idCanBo.IdPhuongXa;
            }
            taiKhoanCaNhanVM.PhuongXaList = _db.PhuongXa.Select(px => new Microsoft.AspNetCore.Mvc.Rendering.SelectListItem
            {
                Text = px.TenPhuongXa,
                Value = px.IdPhuongXa.ToString()
            }).ToList();
            return View(taiKhoanCaNhanVM);
        }
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> TaiKhoanCaNhan(TaiKhoanCaNhanVM model)
        {
            if (ModelState.IsValid)
            {
                if (model.Role == "BenhNhan")
                {
                    var idBenhNhan = _db.BenhNhan.Find(model.Id);
                    idBenhNhan.SoDienThoai = model.SoDienThoai;
                    idBenhNhan.CCCD = model.CCCD;
                    idBenhNhan.soNhaTenDuong = model.soNhaTenDuong;
                    idBenhNhan.GioiTinh = model.GioiTinh;
                    idBenhNhan.IdPhuongXa = model.IdPhuongXa;
                }
                else if (model.Role == "BacSi")
                {
                    var u = _db.BacSi.Find(model.Id);
                    u.SoDienThoai = model.SoDienThoai;
                    u.CCCD = model.CCCD;
                    u.soNhaTenDuong = model.soNhaTenDuong;
                    u.GioiTinh = model.GioiTinh;
                    u.IdPhuongXa = model.IdPhuongXa;
                }

                await _db.SaveChangesAsync();
                TempData["Success"] = "Cập nhật thông tin thành công!";
                return RedirectToAction("TaiKhoanCaNhan");
            }
            return View(model);
        }
        [HttpPost] 
        [ValidateAntiForgeryToken] 
        public async Task<IActionResult> XoaTheoDoi(int idBacSi)
        {
            var userId = User.FindFirstValue("UserId");
            if (string.IsNullOrEmpty(userId)) 
                return Unauthorized();
            int idBenhNhan = int.Parse(userId);
            var target = await _db.TheoDoi.FirstOrDefaultAsync(td => td.IdBenhNhan == idBenhNhan && td.IdBacSi == idBacSi);
            if (target != null)
            {
                _db.TheoDoi.Remove(target);
                await _db.SaveChangesAsync();
                TempData["Success"] = "Đã bỏ theo dõi bác sĩ thành công!";
            }
            return RedirectToAction(nameof(TaiKhoanCaNhan));
        }
        [Authorize(Roles = "CanBoHanhChinh")]
        public IActionResult Dashboard()
        {
            var thongKe = _db.ThongKeTimKiem.OrderByDescending(tk => tk.SoLuotTim).Take(10).ToList();
            ViewBag.TotalBacSi = _db.BacSi.Count();
            ViewBag.TotalBenhNhan = _db.BenhNhan.Count();
            ViewBag.TotalTimKiem = _db.TimKiem.Count();
            return View(thongKe);
        }
        [Authorize(Roles = "CanBoHanhChinh")]
        public IActionResult QuanLyBacSi()
        {
            var list = _db.BacSi.ToList();
            return View(list);
        }
        [Authorize(Roles ="CanBoHanhChinh")]
        public IActionResult QuanLyBenhNhan()
        {
            var list = _db.BenhNhan.ToList();
            return View(list);
        }
    }
}
