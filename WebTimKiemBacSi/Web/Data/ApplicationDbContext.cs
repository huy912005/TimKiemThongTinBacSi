using Microsoft.EntityFrameworkCore;
using Web.Models;
using WebTimKiemBacSi.Models;

namespace Web.Data
{
    public class ApplicationDbContext : DbContext
    {
        public ApplicationDbContext(DbContextOptions<ApplicationDbContext> options) : base(options)
        {
        }
        public DbSet<BacSi> BacSi { get; set; }
        public DbSet<ChuyenKhoa_BacSi> ChuyenKhoa_BacSi { get; set; }
        public DbSet<ChuyenKhoa> ChuyenKhoa { get; set; }
        public DbSet<BenhVien> BenhVien { get; set; }
        public DbSet<BenhNhan> BenhNhan { get; set; }
        public DbSet<TheoDoi> TheoDoi { get; set; }
        public DbSet<ThongBao> ThongBao { get; set; }
        public DbSet<ThongBao_BacSi> ThongBao_BacSi { get; set; }
        public DbSet<ThongBao_BenhNhan> ThongBao_BenhNhan { get; set; }
        public DbSet<LichLamViec> LichLamViec { get; set; }
        public DbSet<CanBoHanhChinh> CanBoHanhChinh { get; set; }
        public DbSet<TimKiem> TimKiem { get; set; }
        public DbSet<BaoCao> BaoCao { get; set; }
        public DbSet<PhuongXa> PhuongXa { get; set; }
        public DbSet<ThongKeTimKiem> ThongKeTimKiem { get; set; }

        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            base.OnModelCreating(modelBuilder);

            // 1. Chuyên Khoa - Bác Sĩ (many-to-many)
            modelBuilder.Entity<ChuyenKhoa_BacSi>()
                .HasKey(ckbs => new { ckbs.IdBacSi, ckbs.IdChuyenKhoa });

            modelBuilder.Entity<ChuyenKhoa_BacSi>()
                .HasOne(ckbs => ckbs.BacSi)
                .WithMany(bs => bs.ChuyenKhoa_BacSis)
                .HasForeignKey(ckbs => ckbs.IdBacSi);

            modelBuilder.Entity<ChuyenKhoa_BacSi>()
                .HasOne(ckbs => ckbs.ChuyenKhoa)
                .WithMany(ck => ck.ChuyenKhoa_BacSis)
                .HasForeignKey(ckbs => ckbs.IdChuyenKhoa);

            // 2. TheoDoi (Bệnh nhân theo dõi Bác sĩ)
            modelBuilder.Entity<TheoDoi>()
                .HasKey(t => new { t.IdBacSi, t.IdBenhNhan });

            modelBuilder.Entity<TheoDoi>()
                .HasOne(t => t.BacSi)
                .WithMany(bs => bs.TheoDois_AsBacSi)
                .HasForeignKey(t => t.IdBacSi);

            modelBuilder.Entity<TheoDoi>()
                .HasOne(t => t.BenhNhan)
                .WithMany(bn => bn.TheoDois_AsBenhNhan)
                .HasForeignKey(t => t.IdBenhNhan);

            // 3. ThongBao_BacSi (Bác sĩ nhận thông báo)
            modelBuilder.Entity<ThongBao_BacSi>()
                .HasKey(tb => new { tb.IdBacSi, tb.IdThongBao });

            modelBuilder.Entity<ThongBao_BacSi>()
                .HasOne(tb => tb.BacSi)
                .WithMany(bs => bs.ThongBao_BacSis)
                .HasForeignKey(tb => tb.IdBacSi);

            modelBuilder.Entity<ThongBao_BacSi>()
                .HasOne(tb => tb.ThongBao)
                .WithMany(t => t.ThongBao_BacSis)
                .HasForeignKey(tb => tb.IdThongBao);

            // 4. ThongBao_BenhNhan (Bệnh nhân nhận thông báo)
            modelBuilder.Entity<ThongBao_BenhNhan>()
                .HasKey(tb => new { tb.IdBenhNhan, tb.IdThongBao });

            modelBuilder.Entity<ThongBao_BenhNhan>()
                .HasOne(tb => tb.BenhNhan)
                .WithMany(bn => bn.ThongBao_BenhNhans)
                .HasForeignKey(tb => tb.IdBenhNhan);

            modelBuilder.Entity<ThongBao_BenhNhan>()
                .HasOne(tb => tb.ThongBao)
                .WithMany(t => t.ThongBao_BenhNhans)
                .HasForeignKey(tb => tb.IdThongBao);
            modelBuilder.Entity<TimKiem>()
                .ToTable(tb => tb.HasTrigger("TG_GhiLogTimKiem"));

            modelBuilder.Entity<ThongKeTimKiem>()
                .HasKey(t => t.TuKhoa);
            modelBuilder.Entity<BenhVien>()
                .ToTable(tb => tb.HasTrigger("TG_TuDongTaoThongBao"));
        }
    }
}
