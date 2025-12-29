using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Web.Data;

namespace WebTimKiemBacSi.Controllers
{
    public class BenhNhanController : Controller
    {
        private readonly ApplicationDbContext _db;
        public BenhNhanController(ApplicationDbContext db)
        {
            _db = db;
        }
        [Authorize(Roles = "CanBoHanhChinh")]
        public IActionResult QuanLyBenhNhan()
        {
            var list = _db.BenhNhan.ToList();
            return View(list);
        }
    }
}
