--Kiem tra xem database đa ton ti hay chưa, ton tai th? xóa
USE master;
IF EXISTS (SELECT name FROM sys.databases WHERE name = 'TimKiemThongTinBacSi')
BEGIN
    ALTER DATABASE TimKiemThongTinBacSi SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE TimKiemThongTinBacSi;
END;
--tao database TimKiemThongTinBacSi
CREATE DATABASE TimKiemThongTinBacSi
GO
USE TimKiemThongTinBacSi
-- TỈNH THÀNH
CREATE TABLE TinhThanh (
    IdTinhThanh INT IDENTITY PRIMARY KEY,
    TenTinhThanh NVARCHAR(100) NOT NULL
);
-- PHƯỜNG XÃ
CREATE TABLE PhuongXa (
    IdPhuongXa INT IDENTITY PRIMARY KEY,
    TenPhuongXa NVARCHAR(100),
    IdTinhThanh INT,
    FOREIGN KEY (IdTinhThanh) REFERENCES TinhThanh(IdTinhThanh)
);
-- BỆNH VIỆN KHU PHÒNG
CREATE TABLE BenhVien (
    IdBenhVien INT IDENTITY PRIMARY KEY,
    TenBenhVien NVARCHAR(200),
    HotLine VARCHAR(20),
    Email VARCHAR(100),
    MoTa NVARCHAR(MAX),
    DiaDiem NVARCHAR(255),
    IdPhuongXa INT,
    FOREIGN KEY (IdPhuongXa) REFERENCES PhuongXa(IdPhuongXa)
);
CREATE TABLE Khu (
    IdKhu INT IDENTITY PRIMARY KEY,
    TenKhu NVARCHAR(100),
    IdBenhVien INT,
    FOREIGN KEY (IdBenhVien) REFERENCES BenhVien(IdBenhVien)
);
CREATE TABLE Phong (
    IdPhong INT IDENTITY PRIMARY KEY,
    TenPhong NVARCHAR(100),
    Tang INT,
    IdKhu INT,
    FOREIGN KEY (IdKhu) REFERENCES Khu(IdKhu)
);
----------------------------------------------------------------NGƯỜI DÙNG----------------------------------------------
CREATE TABLE BacSi (
    IdBacSi INT IDENTITY PRIMARY KEY,
    SoDienThoai VARCHAR(15),
    HoTen NVARCHAR(100),
    Email VARCHAR(100),
    MatKhau VARCHAR(255),
    NgaySinh DATE,
    GioiTinh NVARCHAR(10),
    BangCap NVARCHAR(100),
    NamKinhNghiem INT,
    ChungChiHanhNghe NVARCHAR(255),
    ThanhTuu NVARCHAR(MAX),
    MoTa NVARCHAR(MAX),
    AnhDaiDien NVARCHAR(255),
    soNhaTenDuong NVARCHAR(255),
    CCCD VARCHAR(20),
    IdBenhVien INT,
    IdPhuongXa INT,
    FOREIGN KEY (IdPhuongXa) REFERENCES PhuongXa(IdPhuongXa),
    FOREIGN KEY (IdBenhVien) REFERENCES BenhVien(IdBenhVien)
);
CREATE TABLE BenhNhan (
    IdBenhNhan INT IDENTITY PRIMARY KEY,
    SoDienThoai VARCHAR(15),
    HoTen NVARCHAR(100),
    Email VARCHAR(100),
    MatKhau VARCHAR(255),
    NgaySinh DATE,
    GioiTinh NVARCHAR(10),
    NgayDangKy DATE,
    soNhaTenDuong NVARCHAR(255),
    CCCD VARCHAR(20) NULL,
    IdPhuongXa INT,
    FOREIGN KEY (IdPhuongXa) REFERENCES PhuongXa(IdPhuongXa)
);
CREATE TABLE CanBoHanhChinh (
    IdCanBo INT IDENTITY PRIMARY KEY,
    SoDienThoai VARCHAR(15),
    HoTen NVARCHAR(100),
    Email VARCHAR(100),
    MatKhau VARCHAR(255),
    NgaySinh DATE,
    GioiTinh NVARCHAR(10),
    ChucVu NVARCHAR(100),
    soNhaTenDuong NVARCHAR(255),
    CCCD VARCHAR(20),
    IdBenhVien INT,
    IdPhuongXa INT,
    FOREIGN KEY (IdPhuongXa) REFERENCES PhuongXa(IdPhuongXa),
    FOREIGN KEY (IdBenhVien) REFERENCES BenhVien(IdBenhVien)
);
------------------------------------------------------CHUYÊN KHOA-------------------------------------
CREATE TABLE ChuyenKhoa (
    IdChuyenKhoa INT IDENTITY PRIMARY KEY,
    TenChuyenKhoa NVARCHAR(150),
    MoTa NVARCHAR(MAX)
);
CREATE TABLE ChuyenKhoa_BacSi (
    IdBacSi INT,
    IdChuyenKhoa INT,
    PRIMARY KEY (IdBacSi, IdChuyenKhoa),
    FOREIGN KEY (IdBacSi) REFERENCES BacSi(IdBacSi),
    FOREIGN KEY (IdChuyenKhoa) REFERENCES ChuyenKhoa(IdChuyenKhoa)
);
------------------------------------------------------LỊCH LÀM VIỆC-------------------------------------
CREATE TABLE LichLamViec (
    IdLichLamViec INT IDENTITY PRIMARY KEY,
    NgayLamViec DATE,
    KhungGio NVARCHAR(50),
    TrangThai NVARCHAR(50),
    IdBacSi INT,
    IdPhong INT,
    FOREIGN KEY (IdBacSi) REFERENCES BacSi(IdBacSi),
    FOREIGN KEY (IdPhong) REFERENCES Phong(IdPhong)
);
------------------------------------------------------THÔNG BÁO-------------------------------------
CREATE TABLE ThongBao (
    IdThongBao INT IDENTITY PRIMARY KEY,
    TieuDe NVARCHAR(255),
    NoiDung NVARCHAR(MAX),
    NgayGui DATETIME,
    LoaiThongBao NVARCHAR(100),
    IdCanBo INT,
    FOREIGN KEY (IdCanBo) REFERENCES CanBoHanhChinh(IdCanBo)
);

CREATE TABLE ThongBao_BacSi (
    IdBacSi INT,
    IdThongBao INT,
    NgayXem DATETIME,
    TrangThaiXem NVARCHAR(50),
    PRIMARY KEY (IdBacSi, IdThongBao),
    FOREIGN KEY (IdBacSi) REFERENCES BacSi(IdBacSi),
    FOREIGN KEY (IdThongBao) REFERENCES ThongBao(IdThongBao)
);

CREATE TABLE ThongBao_BenhNhan (
    IdBenhNhan INT,
    IdThongBao INT,
    NgayXem DATETIME,
    TrangThaiXem NVARCHAR(50),
    PRIMARY KEY (IdBenhNhan, IdThongBao),
    FOREIGN KEY (IdBenhNhan) REFERENCES BenhNhan(IdBenhNhan),
    FOREIGN KEY (IdThongBao) REFERENCES ThongBao(IdThongBao)
);

------------------------------------------------------THEO DÕI ĐÁNH GIÁ-------------------------------------
CREATE TABLE TheoDoi (
    IdBacSi INT,
    IdBenhNhan INT,
    NgayBatDauTheoDoi DATE,
    PRIMARY KEY (IdBacSi, IdBenhNhan),
    FOREIGN KEY (IdBacSi) REFERENCES BacSi(IdBacSi),
    FOREIGN KEY (IdBenhNhan) REFERENCES BenhNhan(IdBenhNhan)
);

CREATE TABLE DanhGia (
    IdDanhGia INT IDENTITY PRIMARY KEY,
    DiemDanhGia INT,
    NoiDung NVARCHAR(MAX),
    NgayDanhGia DATE,
    IdBacSi INT,
    IdBenhNhan INT,
    FOREIGN KEY (IdBacSi) REFERENCES BacSi(IdBacSi),
    FOREIGN KEY (IdBenhNhan) REFERENCES BenhNhan(IdBenhNhan)
);
------------------------------------------------------TÌM KIẾM – BÁO CÁO-------------------------------------
CREATE TABLE TimKiem (
    IdTimKiem INT IDENTITY PRIMARY KEY,
    TuKhoaTK NVARCHAR(255),
    ThoiGianTK DATETIME,
    ViTriTimKiem NVARCHAR(255),
    IdBenhNhan INT,
    FOREIGN KEY (IdBenhNhan) REFERENCES BenhNhan(IdBenhNhan)
);
CREATE TABLE BaoCao (
    IdBaoCao INT IDENTITY PRIMARY KEY,
    NoiDung NVARCHAR(MAX),
    LoaiBaoCao NVARCHAR(100),
    NgayTaoBaoCao DATE,
    IdCanBo INT,
    IdBacSi INT,
    IdeBenhNhan Int,
    FOREIGN KEY (IdBacSi) REFERENCES BacSi(IdBacSi),
    FOREIGN KEY (IdCanBo) REFERENCES CanBoHanhChinh(IdCanBo),
    FOREIGN KEY (IdeBenhNhan) REFERENCES BenhNhan(IdBenhNhan)
);
-------------------------------------------------------------CONSTRAINT---------------------------------------------------------------

-------------------------------------------------------------INSERT---------------------------------------------------------------

-------------------------------------------------------------SELECT---------------------------------------------------------------
-- Select theo IdBacSi
SELECT * FROM BacSi WHERE IdBacSi = 1;

-- Select theo Tên (Tìm gần đúng)
SELECT * FROM BacSi WHERE HoTen LIKE N'%Nguyễn%';

-- Select theo Chuyên khoa
SELECT bs.*, ck.TenChuyenKhoa 
FROM BacSi bs
JOIN ChuyenKhoa_BacSi ckbs ON bs.IdBacSi = ckbs.IdBacSi
JOIN ChuyenKhoa ck ON ckbs.IdChuyenKhoa = ck.IdChuyenKhoa
WHERE ck.TenChuyenKhoa LIKE N'%Nội khoa%';

-- Select theo Tỉnh Thành
SELECT bs.*, tt.TenTinhThanh
FROM BacSi bs
JOIN PhuongXa px ON bs.IdPhuongXa = px.IdPhuongXa
JOIN TinhThanh tt ON px.IdTinhThanh = tt.IdTinhThanh
WHERE tt.TenTinhThanh LIKE N'%Đà Nẵng%';

-- Select theo Phường Xã
SELECT bs.*, px.TenPhuongXa
FROM BacSi bs
JOIN PhuongXa px ON bs.IdPhuongXa = px.IdPhuongXa
WHERE px.TenPhuongXa LIKE N'%Quế Sơn%';

-- Select bác sĩ theo Ngày làm việc
SELECT DISTINCT bs.HoTen, l.NgayLamViec, l.KhungGio, l.TrangThai
FROM BacSi bs
JOIN LichLamViec l ON bs.IdBacSi = l.IdBacSi
WHERE l.NgayLamViec = '2023-12-25';

-- Select bác sĩ theo Khu
SELECT DISTINCT bs.HoTen, k.TenKhu
FROM BacSi bs
JOIN LichLamViec l ON bs.IdBacSi = l.IdBacSi
JOIN Phong p ON l.IdPhong = p.IdPhong
JOIN Khu k ON p.IdKhu = k.IdKhu
WHERE k.TenKhu LIKE N'%Khu A%';

-- Select bác sĩ theo Phòng
SELECT DISTINCT bs.HoTen, p.TenPhong, p.Tang
FROM BacSi bs
JOIN LichLamViec l ON bs.IdBacSi = l.IdBacSi
JOIN Phong p ON l.IdPhong = p.IdPhong
WHERE p.TenPhong LIKE N'%Phòng 101%';

-- Select bác sĩ thuộc một Bệnh viện cụ thể
SELECT bs.*, bv.TenBenhVien
FROM BacSi bs
JOIN BenhVien bv ON bs.IdBenhVien = bv.IdBenhVien
WHERE bv.TenBenhVien LIKE N'%Bệnh viện Ung Bướu%';

-- Select danh sách bệnh nhân đang theo dõi một bác sĩ (ví dụ IdBacSi = 1)
SELECT bn.HoTen AS TenBenhNhan, bn.SoDienThoai, td.NgayBatDauTheoDoi
FROM BenhNhan bn
JOIN TheoDoi td ON bn.IdBenhNhan = td.IdBenhNhan
WHERE td.IdBacSi = 1;

-- Select bác sĩ được tìm kiếm nhiều nhất (Dựa trên từ khóa có chứa tên bác sĩ)
SELECT TOP 5 bs.HoTen, COUNT(tk.IdTimKiem) AS SoLuotTimKiem
FROM BacSi bs
LEFT JOIN TimKiem tk ON tk.TuKhoaTK LIKE N'%' + bs.HoTen + '%'
GROUP BY bs.IdBacSi, bs.HoTen
ORDER BY SoLuotTimKiem DESC;

-- Select bệnh nhân tìm kiếm bác sĩ nhiều nhất
SELECT TOP 5 bn.HoTen, COUNT(tk.IdTimKiem) AS TongSoLuotTim
FROM BenhNhan bn
JOIN TimKiem tk ON bn.IdBenhNhan = tk.IdBenhNhan
GROUP BY bn.IdBenhNhan, bn.HoTen
ORDER BY TongSoLuotTim DESC;

-------------------------------------------------------------FUNCTION---------------------------------------------------------------

-------------------------------------------------------------PROC---------------------------------------------------------------

-------------------------------------------------------------TRIGGER---------------------------------------------------------------