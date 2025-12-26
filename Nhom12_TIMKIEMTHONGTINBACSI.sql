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

-------------------------------------------------------------FUNCTION---------------------------------------------------------------

-------------------------------------------------------------PROC---------------------------------------------------------------

-------------------------------------------------------------TRIGGER---------------------------------------------------------------