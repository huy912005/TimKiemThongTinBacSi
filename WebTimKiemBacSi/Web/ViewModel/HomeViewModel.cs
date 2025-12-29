using Microsoft.AspNetCore.Mvc.Rendering;
using Web.Models;

namespace WebTimKiemBacSi.ViewModel
{
    public class HomeViewModel
    {
        public IEnumerable<BacSi> BacSis { get; set; } = new List<BacSi>();
        public List<SelectListItem> ChuyenKhoaList { get; set; } = new List<SelectListItem>();
        public List<SelectListItem> BenhVienList { get; set; } = new List<SelectListItem>();
        public int? SelectedChuyenKhoaId { get; set; }
        public int? SelectedBenhVienId { get; set; }
        public string SearchTen { get; set; }
    }
}
