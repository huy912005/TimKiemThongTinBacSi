using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using System.Security.Claims;
using Web.Data;
using Web.Models;

namespace WebTimKiemBacSi.Controllers
{
    public class BenhVienController : Controller
    {
        private readonly ApplicationDbContext _db;

        public BenhVienController(ApplicationDbContext db)
        {
            _db = db;
        }
        public IActionResult Index()
        {
            var list = _db.BenhVien.ToList();
            return View(list);
        }
        public IActionResult Create()
        {
            ViewBag.PhuongXaList = _db.PhuongXa.ToList();
            return View();
        }
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Create(BenhVien model)
        {
            if (ModelState.IsValid)
            {
                _db.BenhVien.Add(model);
                await _db.SaveChangesAsync();
                TempData["Success"] = "Thêm bệnh viện mới thành công!";
                return RedirectToAction(nameof(Index));
            }
            ViewBag.PhuongXaList = _db.PhuongXa.ToList();
            return View(model);
        }
        public IActionResult Edit(int id)
        {
            var item = _db.BenhVien.Find(id);
            if (item == null) 
                return NotFound();
            ViewBag.PhuongXaList = _db.PhuongXa.ToList();
            return View(item);
        }
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Edit(BenhVien model)
        {
            if (ModelState.IsValid)
            {
                var userId = User.FindFirstValue("UserId");
                try
                {
                    using (var transaction = await _db.Database.BeginTransactionAsync())
                    {
                        if (!string.IsNullOrEmpty(userId))
                        {
                            await _db.Database.ExecuteSqlRawAsync("EXEC sp_set_session_context @key=N'IdCanBo', @value={0}", userId);
                        }

                        _db.BenhVien.Update(model);
                        await _db.SaveChangesAsync();
                        await transaction.CommitAsync();
                    }
                    TempData["Success"] = "Cập nhật thành công!";
                    return RedirectToAction(nameof(Index));
                }
                catch (Exception ex)
                {
                    ModelState.AddModelError("", "Lỗi: " + ex.Message);
                }
            }
            ViewBag.PhuongXaList = _db.PhuongXa.ToList();
            return View(model);
        }
        [HttpPost]
        public async Task<IActionResult> Delete(int id)
        {
            var item = _db.BenhVien.Find(id);
            if (item == null) 
                return Json(new { success = false });
            _db.BenhVien.Remove(item);
            await _db.SaveChangesAsync();
            return Json(new { success = true });
        }
    }
}
