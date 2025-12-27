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
--------------------------------SDT-------------
--bang benh nhan
ALTER TABLE BENHNHAN
	ADD CONSTRAINT CK_BENHNHAN_SDT
		CHECK(SoDienThoai LIKE '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'OR
				SoDienThoai LIKE'[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]')
--bang bac si
ALTER TABLE BACSI
	ADD CONSTRAINT CK_BACSI_SDT
		CHECK(SoDienThoai LIKE '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'OR
				SoDienThoai LIKE'[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]')
--bang can bo hanh chinh
ALTER TABLE CanBoHanhChinh
	ADD CONSTRAINT CK_CANBOHC_SDT
		CHECK(SoDienThoai LIKE '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'OR
				SoDienThoai LIKE'[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]')
--bang can bo benh vien
ALTER TABLE BenhVien
	ADD CONSTRAINT CK_BENHVIEN_SDT
		CHECK(HotLine LIKE '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'OR
				HotLine LIKE'[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]')
--------------------------------ADD FIELD-------------
-- Thêm cột TrangThai cho bảng BacSi
ALTER TABLE BacSi 
ADD TrangThai INT DEFAULT 1;
-- Thêm cột TrangThai cho bảng BenhNhan
ALTER TABLE BenhNhan 
ADD TrangThai INT DEFAULT 1;
GO
UPDATE BacSi SET TrangThai = 1;
UPDATE BenhNhan SET TrangThai = 1;
GO
--------------------------------EMAIL-------------
--bang benh nhan
ALTER TABLE BENHNHAN
	ADD CONSTRAINT CK_BENHNHAN_EMAIL
		CHECK(Email LIKE '[A-Z]%@%_')
--bang bac si
ALTER TABLE BACSI
	ADD CONSTRAINT CK_BACSI_EMAIL
		CHECK(Email LIKE '[A-Z]%@%_')
--bang can bo hanh chinh
ALTER TABLE CanBoHanhChinh
	ADD CONSTRAINT CK_CANBOHC_EMAIL
		CHECK(Email LIKE '[A-Z]%@%_')
--bang benh vien
ALTER TABLE BenhVien
	ADD CONSTRAINT CK_BenhVien_EMAIL
		CHECK(Email LIKE '[A-Z]%@%_')
--------------------------------GIỚI TÍNH-------------
--bang benh nhan
ALTER TABLE BENHNHAN
	ADD CONSTRAINT CK_BENHNHAN_GT
	CHECK(GIOITINH IN('NAM',N'NỮ'))
--giới tính mặc định bảng benh nhan
ALTER TABLE BENHNHAN
	ADD CONSTRAINT DF_BENHNHAN_GIOITINH DEFAULT N'NAM' FOR GIOITINH
--bang bac si
ALTER TABLE BACSI
	ADD CONSTRAINT CK_BACSI_GT
	CHECK(GIOITINH IN('NAM',N'NỮ'))
--giới tính mặc định bảng bac si
ALTER TABLE BACSI
	ADD CONSTRAINT DF_BACSI_GIOITINH DEFAULT N'NAM' FOR GIOITINH
--bang can bo hanh chinh
ALTER TABLE CanBoHanhChinh
	ADD CONSTRAINT CK_CANBOHC_GT
	CHECK(GIOITINH IN('NAM',N'NỮ'))
--giới tính mặc định bảng CBHC
ALTER TABLE CanBoHanhChinh
	ADD CONSTRAINT DF_CANBOHC_GIOITINH DEFAULT N'NAM' FOR GIOITINH
-------------------------------------------------------------INSERT---------------------------------------------------------------
-- 1. TỈNH THÀNH
SET IDENTITY_INSERT TinhThanh ON;
INSERT INTO TinhThanh (IdTinhThanh,TenTinhThanh) 
VALUES(1,N'Thành phố Đà Nẵng'), 
(2,N'Thành phố Hà Nội'), 
(3,N'Thành phố Hồ Chí Minh')
SET IDENTITY_INSERT TinhThanh OFF;
-- 2. PHƯỜNG XÃ
SET IDENTITY_INSERT PhuongXa ON;
INSERT INTO PhuongXa (IdPhuongXa, TenPhuongXa, IdTinhThanh) VALUES 
(1, N'Phường Hải Châu I', 1), 
(2, N'Phường Mỹ An', 1), 
(3, N'Phường Hòa Khánh Nam', 1)
SET IDENTITY_INSERT PhuongXa OFF;
-- 3. BỆNH VIỆN
SET IDENTITY_INSERT BenhVien ON;
INSERT INTO BenhVien (IdBenhVien, TenBenhVien, HotLine, Email, MoTa, DiaDiem, IdPhuongXa) VALUES 
(1, N'Bệnh viện Đà Nẵng', '02363821118', 'bvdn@danang.vn', N'BV Đa khoa hạng I', N'124 Hải Phòng', 1),
(2, N'Bệnh viện Phụ sản - Nhi', '02363957777', 'psn@danang.vn', N'BV Chuyên khoa Ngũ Hành Sơn', N'402 Lê Văn Hiến', 2),
(3, N'Bệnh viện Ung Bướu', '02363717717', 'ub@danang.vn', N'BV Ung Bướu Liên Chiểu', N'Tổ 78 Hòa Minh', 3)
SET IDENTITY_INSERT BenhVien OFF;
-- 4. KHU
SET IDENTITY_INSERT Khu ON;
INSERT INTO Khu (IdKhu, TenKhu, IdBenhVien) 
VALUES (1, N'Khu A', 1), 
(2, N'Khu B', 2), 
(3, N'Khu C', 3)
SET IDENTITY_INSERT Khu OFF
-- 5. PHÒNG
SET IDENTITY_INSERT Phong ON;
INSERT INTO Phong (IdPhong, TenPhong, Tang, IdKhu) 
VALUES (1, N'P101', 1, 1), 
(2, N'P202', 2, 2), 
(3, N'P303', 3, 3)
SET IDENTITY_INSERT Phong OFF
USE TimKiemThongTinBacSi;
GO
-- 6. BÁC SĨ
SET IDENTITY_INSERT BacSi ON;
INSERT INTO BacSi (IdBacSi, SoDienThoai, HoTen, Email, MatKhau, NgaySinh, GioiTinh, BangCap, NamKinhNghiem, ChungChiHanhNghe, ThanhTuu, MoTa, AnhDaiDien, soNhaTenDuong, CCCD, IdBenhVien, IdPhuongXa) 
VALUES (1, '0905111222', N'Phạm Minh Huy', 'Huy@gmail.com', 'Huy123!@#', '1980-01-01', N'Nam', N'Tiến sĩ', 15, N'CCHN-12345', N'Bàn tay vàng phẫu thuật tim', N'Chuyên gia nội tim mạch với nhiều năm kinh nghiệm', 'huy_avatar.jpg', N'123 Hải Phòng', '049205002552', 1, 1),
(2, '0905333444', N'Nguyễn Phước Quý Bửu', 'Buu@gmail.com', '123', '1985-05-05', N'Nữ', N'Thạc sĩ', 10, N'CCHN-67890', N'Cứu sống hàng nghìn bệnh nhi', N'Yêu trẻ và tận tâm với nghề y', 'buu_avatar.jpg', N'402 Lê Văn Hiến', '049205002192', 2, 2),
(3, '0905555666', N'Tạ Quang Nhựt', 'Nhut@gmail.com', '123', '1990-10-10', N'Nam', N'Bác sĩ CKI', 7, N'CCHN-55555', N'Nghiên cứu ung thư giai đoạn sớm', N'Luôn cập nhật kiến thức y khoa mới nhất', 'nhut_avatar.jpg', N'78 Hòa Minh', '049205001221', 3, 3);
SET IDENTITY_INSERT BacSi OFF;
-- 7. BỆNH NHÂN
SET IDENTITY_INSERT BenhNhan ON;
INSERT INTO BenhNhan (IdBenhNhan, SoDienThoai, HoTen, Email, MatKhau, NgaySinh, GioiTinh, NgayDangKy, soNhaTenDuong, CCCD, IdPhuongXa) 
VALUES (1, '0914000111', N'Dương Công Tiến', 'Tien@gmail.com', '123', '2000-01-01', N'Nam', GETDATE(), N'45 Nguyễn Chí Thanh', '049200111222', 1),
(2, '0914000222', N'Hoàng Lệ Thu', 'thu@gmail.com', '123', '1998-05-05', N'Nữ', GETDATE(), N'12 Ngũ Hành Sơn', '049200333444', 2),
(3, '0914000333', N'Nguyễn Quốc Sơn', 'son@gmail.com', '123', '1995-10-10', N'Nam', GETDATE(), N'99 Tôn Đức Thắng', '049200555666', 3);
SET IDENTITY_INSERT BenhNhan OFF;
-- 8. CÁN BỘ HÀNH CHÍNH
SET IDENTITY_INSERT CanBoHanhChinh ON;
INSERT INTO CanBoHanhChinh (IdCanBo, SoDienThoai, HoTen, Email, MatKhau, NgaySinh, GioiTinh, ChucVu, soNhaTenDuong, CCCD, IdBenhVien, IdPhuongXa) 
VALUES (1, '0236111987', N'Phạm Minh Huy', 'Huy@vn', 'Huy123!@#', '1975-01-01', N'Nam', N'Trưởng phòng IT', N'124 Hải Phòng', '049100111222', 1, 1),
(2, '0236222987', N'Minh Huy Phạm', 'MHuy2@vn', '123', '1988-12-12', N'Nam', N'Nhân viên nhân sự', N'20 Võ Nguyên Giáp', '049100333444', 2, 2),
(3, '0236333098', N'Trần Tiếp Tân', 'tieptan@vn', '123', '1992-06-06', N'Nữ', N'Nhân viên điều phối', N'10 Hòa Khánh', '049100555666', 3, 3);
SET IDENTITY_INSERT CanBoHanhChinh OFF;
-- 9. CHUYÊN KHOA
SET IDENTITY_INSERT ChuyenKhoa ON;
INSERT INTO ChuyenKhoa (IdChuyenKhoa, TenChuyenKhoa, MoTa) VALUES 
(1, N'Nội Tim Mạch', N'Khám tim'), 
(2, N'Nhi Khoa', N'Khám trẻ em'), 
(3, N'Ung Bướu', N'Điều trị ung thư');
SET IDENTITY_INSERT ChuyenKhoa OFF;

-- 10. CHUYÊN KHOA_BÁC SĨ (Bảng trung gian, không có Identity nên insert bình thường)
INSERT INTO ChuyenKhoa_BacSi (IdBacSi, IdChuyenKhoa) 
VALUES (1, 1), 
(2, 2), 
(3, 3);
-- 11. LỊCH LÀM VIỆC
SET IDENTITY_INSERT LichLamViec ON;
INSERT INTO LichLamViec (IdLichLamViec, NgayLamViec, KhungGio, TrangThai, IdBacSi, IdPhong) VALUES 
(1, '2024-12-30', '07:30 - 11:30', N'Sẵn sàng', 1, 1),
(2, '2024-12-30', '13:30 - 17:00', N'Sẵn sàng', 2, 2),
(3, '2024-12-31', '07:30 - 11:30', N'Sẵn sàng', 3, 3);
SET IDENTITY_INSERT LichLamViec OFF;
-- 12. THÔNG BÁO
SET IDENTITY_INSERT ThongBao ON;
INSERT INTO ThongBao (IdThongBao, TieuDe, NoiDung, NgayGui, LoaiThongBao, IdCanBo) VALUES 
(1, N'Nghỉ Tết', N'BV nghỉ tết dương lịch', GETDATE(), N'Hành chính', 1),
(2, N'Họp chuyên môn', N'Họp bác sĩ khu A', GETDATE(), N'Nội bộ', 2),
(3, N'Khám miễn phí', N'Chương trình thiện nguyện', GETDATE(), N'Cộng đồng', 3);
SET IDENTITY_INSERT ThongBao OFF;
-- 13. DANH GIA
SET IDENTITY_INSERT DanhGia ON;
INSERT INTO DanhGia (IdDanhGia, DiemDanhGia, NoiDung, NgayDanhGia, IdBacSi, IdBenhNhan) VALUES 
(1, 5, N'Bác sĩ giỏi', GETDATE(), 1, 1),
(2, 4, N'Nhiệt tình', GETDATE(), 2, 2),
(3, 5, N'Rất tốt', GETDATE(), 3, 3);
SET IDENTITY_INSERT DanhGia OFF;
-- 14. THÔNG BÁO_BÁC SĨ
INSERT INTO ThongBao_BacSi (IdBacSi, IdThongBao, NgayXem, TrangThaiXem) 
VALUES (1, 1, GETDATE(), N'Đã xem'), 
(2, 1, NULL, N'Chưa xem'), 
(3, 2, GETDATE(), N'Đã xem');
-- 15. THÔNG BÁO_BỆNH NHÂN 
INSERT INTO ThongBao_BenhNhan (IdBenhNhan, IdThongBao, NgayXem, TrangThaiXem) VALUES 
(1, 3, GETDATE(), N'Đã xem'), 
(2, 3, NULL, N'Chưa xem'), 
(3, 3, GETDATE(), N'Đã xem');
-- 16. THEO DÕI
INSERT INTO TheoDoi (IdBacSi, IdBenhNhan, NgayBatDauTheoDoi) 
VALUES (1, 1, '2025-10-01'), 
(2, 2, '2025-12-01'), 
(3, 3, '2025-11-15');

-- 17. TÌM KIẾM
SET IDENTITY_INSERT TimKiem ON;
INSERT INTO TimKiem (IdTimKiem, TuKhoaTK, ThoiGianTK, ViTriTimKiem, IdBenhNhan) 
VALUES (1, N'Bác sĩ tim mạch Đà Nẵng', GETDATE(), N'Hải Châu', 1),
(2, N'Khám nhi Mỹ An', GETDATE(), N'Ngũ Hành Sơn', 2),
(3, N'Bệnh viện Ung Bướu', GETDATE(), N'Hòa Khánh', 3);
SET IDENTITY_INSERT TimKiem OFF;
-- 18. BÁO CÁO
SET IDENTITY_INSERT BaoCao ON;
INSERT INTO BaoCao (IdBaoCao, NoiDung, LoaiBaoCao, NgayTaoBaoCao, IdCanBo, IdBacSi, IdeBenhNhan) 
VALUES (1, N'Báo cáo lượt tìm kiếm tháng 12', N'Thống kê', GETDATE(), 1, 1, 1),
(2, N'Báo cáo danh sách bác sĩ mới', N'Nhân sự', GETDATE(), 2, 2, 2),
(3, N'Phản hồi từ bệnh nhân về dịch vụ', N'Góp ý', GETDATE(), 3, 3, 3);
SET IDENTITY_INSERT BaoCao OFF;
-------------------------------------------------------------SELECT---------------------------------------------------------------

-------------------------------------------------------------FUNCTION---------------------------------------------------------------
--15. fn_LayGioBatDau: Trích xuất giờ bắt đầu từ chuỗi KhungGio (ví dụ: "08:00 - 10:00").
GO
CREATE FUNCTION fn_LayGioBatDau(@khungGio NVARCHAR(50))
RETURNS NVARCHAR(10)
AS
BEGIN
    DECLARE @GioBatDau NVARCHAR(10)
    DECLARE @ViTriGachNoi INT
    SET @ViTriGachNoi=CHARINDEX('-',@KhungGio)
    IF @ViTriGachNoi > 0
    BEGIN
        -- Cắt chuỗi từ đầu đến trước dấu gạch ngang và loại bỏ khoảng trắng
        SET @GioBatDau= LTRIM(RTRIM(LEFT(@KhungGio,@ViTriGachNoi-1)))
    END
    RETURN @GioBatDau
END
GO
SELECT dbo.fn_LayGioBatDau('9:00-20:00') AS GioBatDau;
--16. fn_TinhThoiGianTheoDoi: Tính số ngày bệnh nhân đã theo dõi bác sĩ.
GO
CREATE FUNCTION fn_TinhThoiGianTheoDoi(@idBacSi INT,@idBenhNhan INT)
RETURNS INT
AS
BEGIN
    DECLARE @NgayBatDau Date
    DECLARE @SoNgay INT
    SELECT @NgayBatDau=NgayBatDauTheoDoi
    FROM TheoDoi
    WHERE IdBacSi=@idBacSi AND IdBenhNhan=@idBenhNhan
    IF @NgayBatDau IS NOT NULL 
        SET @SoNgay=DATEDIFF(DAY,@NgayBatDau,GETDATE())
    ELSE
        SET @SoNgay=0
    RETURN @SoNgay
END
GO
SELECT 
    b.HoTen AS TenBacSi, 
    bn.HoTen AS TenBenhNhan, 
    dbo.fn_TinhThoiGianTheoDoi(t.IdBacSi, t.IdBenhNhan) AS SoNgayTheoDoi
FROM TheoDoi t
JOIN BacSi b ON t.IdBacSi = b.IdBacSi
JOIN BenhNhan bn ON t.IdBenhNhan = bn.IdBenhNhan;
--17. fn_LayEmailCuaCanBo: Truy xuất email nhanh dựa trên IdCanBo.
GO
CREATE FUNCTION fn_LayEmailCuaCanBo(@idCanBo INT)
RETURNS VARCHAR(100)
AS
BEGIN
    DECLARE @emailCB VARCHAR(100)
    SELECT @emailCB=c.Email
    FROM CanBoHanhChinh c
    WHERE c.IdCanBo=@idCanBo
    RETURN ISNULL(@emailCB, N'Không tìm thấy Email')
END
GO
SELECT IdCanBo,dbo.fn_LayEmailCuaCanBo(IdCanBo) EmailCB
FROM CanBoHanhChinh
--18. fn_MaHoaMatKhauDonGian: Hàm mô phỏng việc che dấu mật khẩu.
GO
CREATE FUNCTION fn_MaHoaMatKhauDonGian(@matKhau VARCHAR(255))
RETURNS VARCHAR(255)
AS
BEGIN
    DECLARE @matKhauKetQua VARCHAR(255)
    SET @matKhauKetQua=REPLICATE('*',LEN(@matKhau))
    RETURN @matKhauKetQua
END
GO
SELECT b.HoTen,b.CCCD,b.AnhDaiDien,dbo.fn_MaHoaMatKhauDonGian(b.MatKhau) MatKhau
FROM BacSi b
--19. fn_ThongKeXepHangBacSi: Trả về thứ hạng của bác sĩ dựa trên ĐIỂM TRUNG BÌNH đánh giá.
GO
CREATE FUNCTION fn_ThongKeXepHangBacSi(@idBacSi INT)
RETURNS INT
AS
BEGIN
    DECLARE @thuHang INT
    DECLARE @soSaoCuaMinh FLOAT
    SELECT @soSaoCuaMinh = AVG(DiemDanhGia)
    FROM DanhGia
    WHERE IdBacSi=@idBacSi
    IF @soSaoCuaMinh IS NULL
        SET @soSaoCuaMinh=0
    SELECT @thuHang=COUNT(DISTINCT DiemTB)+1
    FROM (
        SELECT DISTINCT IdBacSi, AVG(DiemDanhGia) AS DiemTB
        FROM DanhGia
        GROUP BY IdBacSi
    ) AS BANGXEPHANG 
    WHERE DiemTB>@soSaoCuaMinh
    RETURN @thuHang
END
GO
SELECT b.IdBacSi, b.HoTen, ISNULL(CAST(AVG(CAST(d.DiemDanhGia AS FLOAT)) AS DECIMAL(10,1)), 0) AS DiemTrungBinh,dbo.fn_ThongKeXepHangBacSi(b.IdBacSi) AS ThuHang
FROM BacSi b
JOIN DanhGia d ON b.IdBacSi = d.IdBacSi
GROUP BY b.IdBacSi, b.HoTen
ORDER BY ThuHang ASC;

-------------------------------------------------------------PROC---------------------------------------------------------------
--15. pr_XoaLichCu: Xóa các lịch làm việc đã qua hơn 1 năm để nhẹ database.
GO
CREATE PROC pr_XoaLichCu
AS
BEGIN
    DECLARE @SoLuongXoa INT
    DELETE 
    FROM LichLamViec
    WHERE NgayLamViec<DATEADD(YEAR,-1,GETDATE())
    SET @SoLuongXoa=@@ROWCOUNT
    PRINT N'Đã xóa thành công '+CAST(@SoLuongXoa AS NVARCHAR)+' lich làm viec cũ!'
END
EXEC pr_XoaLichCu
--16. pr_LayHoSoChiTietBacSi: Join nhiều bảng để lấy toàn bộ thông tin, bằng cấp, chuyên khoa của BS.
GO
CREATE PROC pr_LayHoSoChiTietBacSi
    @idBacSi INT
AS
BEGIN
    SELECT b.IdBacSi, b.HoTen, b.SoDienThoai, b.Email,dbo.fn_MaHoaMatKhauDonGian(b.MatKhau) AS MatKhauBaoMat,b.BangCap, b.NamKinhNghiem, b.ThanhTuu,bv.TenBenhVien,
        b.soNhaTenDuong + ', ' + px.TenPhuongXa + ', ' + tt.TenTinhThanh AS DiaChi,
        (SELECT STRING_AGG(ck.TenChuyenKhoa, ', ') 
         FROM ChuyenKhoa_BacSi ckb 
         JOIN ChuyenKhoa ck ON ckb.IdChuyenKhoa = ck.IdChuyenKhoa 
         WHERE ckb.IdBacSi = b.IdBacSi) AS CacChuyenKhoa,
         dbo.fn_ThongKeXepHangBacSi(b.IdBacSi) AS ThuHangHienTai
    FROM BacSi b
    JOIN BENHVIEN bv ON bv.IdBenhVien=b.IdBenhVien
    JOIN PhuongXa px ON px.IdPhuongXa=b.IdPhuongXa
    JOIN TinhThanh tt ON tt.IdTinhThanh=px.IdTinhThanh
    WHERE b.IdBacSi=@idBacSi
END
GO
EXEC pr_LayHoSoChiTietBacSi 1;
--17. pr_GuiMailNhacLich: Trích xuất danh sách email bác sĩ có lịch vào ngày mai.
GO
CREATE OR ALTER PROC pr_GuiMailNhacLich
AS
BEGIN
    DECLARE @ngayMai DATE = CAST(DATEADD(DAY,1,GETDATE()) AS DATE)
    IF NOT EXISTS(SELECT 1 FROM LichLamViec WHERE NgayLamViec=@ngayMai)
    BEGIN
        PRINT N'Không có bác sĩ nào làm việc vào ngày mai '+CAST(@ngayMai as NVARCHAR(10))+')'
        RETURN
    END
    SELECT b.IdBacSi,b.HoTen,b.Email,p.TenPhong,p.Tang,@ngayMai as NgayNhacLich
    FROM BacSi b
    JOIN LichLamViec l ON b.IdBacSi = l.IdBacSi
    JOIN Phong p ON l.IdPhong = p.IdPhong
    WHERE l.NgayLamViec = @NgayMai AND l.TrangThai = N'Sẵn sàng'
END
GO
EXEC pr_GuiMailNhacLich;
--18. pr_PhanQuyenCanBo: Cập nhật chức vụ và quyền hạn cho Cán bộ.
GO
CREATE OR ALTER PROC pr_PhanQuyenCanBo
    @idCanBo INT,
    @chucVuMoi NVARCHAR(50)
AS
BEGIN
    IF NOT EXISTS(SELECT 1 FROM CanBoHanhChinh WHERE @idCanBo=IdCanBo)
    BEGIN 
        PRINT'Không tồn tại cán bộ trong danh sách!'
        RETURN
    END
    UPDATE CanBoHanhChinh
    SET ChucVu=@chucVuMoi
    WHERE @idCanBo=IdCanBo
END
EXEC pr_PhanQuyenCanBo 1, N'Trưởng phòng Nhân sự'
SELECT * FROM CanBoHanhChinh
--19. pr_KhoaTaiKhoan: Khóa người dùng nếu có quá nhiều báo cáo vi phạm.
GO
CREATE OR ALTER PROC pr_KhoaTaiKhoan
AS
BEGIN
    UPDATE BACSI
    SET TrangThai=0
    WHERE IdBacSi IN (
        SELECT IdBacSi
        FROM BaoCao 
        GROUP BY IdBacSi
        HAVING COUNT(IdBaoCao) >= 3
    )
    UPDATE BenhNhan
    SET TrangThai=0
    WHERE IdBenhNhan IN(
        SELECT IdeBenhNhan
        FROM BaoCao 
        GROUP BY IdeBenhNhan
        HAVING COUNT(IdBaoCao) >= 3
    )
    PRINT N'Hệ thống đã khóa các tài khoản vi phạm nhiều hơn 3 lần bị báo cáo!.'
END
GO
EXEC pr_KhoaTaiKhoan;
SELECT IdBacSi, HoTen, TrangThai FROM BacSi;
-------------------------------------------------------------TRIGGER---------------------------------------------------------------
--1. TG_GioiHanDiemDanhGia: Kiểm tra dữ liệu khi Bệnh nhân đánh giá bác sĩ. Đảm bảo số sao (Rating) phải nằm trong khoảng từ 1 đến 5.
GO
CREATE OR ALTER TRIGGER TG_GioiHanDiemDanhGia
