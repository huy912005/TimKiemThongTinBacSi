using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.Rendering;
using Microsoft.EntityFrameworkCore;
using System.Diagnostics;
using Web.Data;
using Web.Models;
using WebTimKiemBacSi.ViewModel;

namespace Web.Controllers
{
    public class HomeController : Controller
    {
        private readonly ILogger<HomeController> _logger;
        private readonly ApplicationDbContext _db;

        public HomeController(ILogger<HomeController> logger, ApplicationDbContext db)
        {
            _logger = logger;
            _db = db;
        }
        
        public IActionResult Index(string? tenBS, int? chuyenKhoa, int? benhVien)
        {
            IQueryable<BacSi> query = _db.BacSi.Include(b => b.BenhVien).Include(b => b.ChuyenKhoa_BacSis).ThenInclude(ckbs => ckbs.ChuyenKhoa);
            if(!string.IsNullOrWhiteSpace(tenBS))
                query=query.Where(b => b.HoTen.Contains(tenBS.Trim()));
            if(chuyenKhoa.HasValue && chuyenKhoa.Value > 0)
                query=query.Where(b => b.ChuyenKhoa_BacSis.Any(ckbs => ckbs.IdChuyenKhoa == chuyenKhoa));
            if(benhVien.HasValue && benhVien.Value > 0)
                query=query.Where(b => b.IdBenhVien == benhVien);
            IEnumerable<BacSi> objBacSiList = query.ToList();
            var homeViewModel= new HomeViewModel()
            {
                BacSis = objBacSiList,
                ChuyenKhoaList = _db.ChuyenKhoa.OrderBy(ck => ck.TenChuyenKhoa).Select(ck => new SelectListItem
                {
                    Value= ck.IdChuyenKhoa.ToString(),
                    Text= ck.TenChuyenKhoa
                }).ToList().Prepend(new SelectListItem { Value="",Text="Chuyên khoa"}).ToList(),
                BenhVienList=_db.BenhVien.OrderBy(bv=>bv.TenBenhVien).Select(bv=>new SelectListItem
                {
                    Value= bv.IdBenhVien.ToString(),
                    Text= bv.TenBenhVien
                }).ToList().Prepend(new SelectListItem { Value="",Text="Bệnh viện"}).ToList(),
                SearchTen= tenBS,
                SelectedChuyenKhoaId= chuyenKhoa,
                SelectedBenhVienId= benhVien
            };
            return View(homeViewModel);
        }
        public IActionResult Details(int? id)
        {
            if (id == null || id == 0)
            {
                return NotFound();
            }
            var bacSi = _db.BacSi.Include(u => u.BenhVien).Include(u => u.PhuongXa).FirstOrDefault(u => u.IdBacSi == id);
            if (bacSi == null)
            {
                return NotFound();
            }
            return View(bacSi);
        }
        public IActionResult Privacy()
        {
            return View();
        }

        [ResponseCache(Duration = 0, Location = ResponseCacheLocation.None, NoStore = true)]
        public IActionResult Error()
        {
            return View(new ErrorViewModel { RequestId = Activity.Current?.Id ?? HttpContext.TraceIdentifier });
        }
    }
}
