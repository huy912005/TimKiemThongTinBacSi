using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using System.Collections.Generic;
using System.Linq;
using Web.Data;
using Web.Models;

namespace Web.Controllers
{
    public class BacSiController : Controller
    {
        private readonly ApplicationDbContext _db;

        public BacSiController(ApplicationDbContext db)
        {
            _db = db;
        }
        public IActionResult Index()
        {
            IEnumerable<BacSi> objBacSiList = _db.BacSi.ToList();
            return View(objBacSiList);
        }
        public IActionResult Create()
        {
            return View();
        }
        [HttpPost]
        [ValidateAntiForgeryToken]
        public IActionResult Create(BacSi obj)
        {
            if (ModelState.IsValid)
            {
                _db.BacSi.Add(obj);
                _db.SaveChanges();
                return RedirectToAction("Index");
            }
            return View(obj);
        }
        public IActionResult Edit(int? id)
        {
            if (id == null || id == 0) return NotFound();

            var bacSiFromDb = _db.BacSi.Find(id);
            if (bacSiFromDb == null) return NotFound();

            return View(bacSiFromDb);
        }
        [HttpPost]
        [ValidateAntiForgeryToken]
        public IActionResult Edit(BacSi obj)
        {
            if (ModelState.IsValid)
            {
                _db.BacSi.Update(obj);
                _db.SaveChanges();
                return RedirectToAction("Index");
            }
            return View(obj);
        }
        public IActionResult Delete(int? id)
        {
            if (id == null || id == 0) return NotFound();

            var bacSiFromDb = _db.BacSi.Find(id);
            if (bacSiFromDb == null) return NotFound();

            return View(bacSiFromDb);
        }
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public IActionResult DeletePost(int? id)
        {
            var obj = _db.BacSi.Find(id);
            if (obj == null) return NotFound();

            _db.BacSi.Remove(obj);
            _db.SaveChanges();
            return RedirectToAction("Index");
        }
    }
}