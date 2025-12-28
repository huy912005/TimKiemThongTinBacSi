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
(3,N'Thành phố Hồ Chí Minh'),
(4, N'Thành phố Huế'),
(5, N'Tỉnh Quảng Nam'),
(6, N'Tỉnh Bình Định'),
(7, N'Tỉnh Khánh Hòa');
SET IDENTITY_INSERT TinhThanh OFF;
-- 2. PHƯỜNG XÃ
SET IDENTITY_INSERT PhuongXa ON;
INSERT INTO PhuongXa (IdPhuongXa, TenPhuongXa, IdTinhThanh) VALUES 
(1, N'Phường Hải Châu I', 1), 
(2, N'Phường Mỹ An', 1), 
(3, N'Phường Hòa Khánh Nam', 1),
(4, N'Phường Thuận Hòa', 4),
(5, N'Phường An Mỹ', 5),
(6, N'Phường Trần Phú', 6),
(7, N'Phường Vĩnh Hải', 7);
SET IDENTITY_INSERT PhuongXa OFF;
-- 3. BỆNH VIỆN
SET IDENTITY_INSERT BenhVien ON;
INSERT INTO BenhVien (IdBenhVien, TenBenhVien, HotLine, Email, MoTa, DiaDiem, IdPhuongXa) VALUES 
(1, N'Bệnh viện Đà Nẵng', '02363821118', 'bvdn@danang.vn', N'BV Đa khoa hạng I', N'124 Hải Phòng', 1),
(2, N'Bệnh viện Phụ sản - Nhi', '02363957777', 'psn@danang.vn', N'BV Chuyên khoa Ngũ Hành Sơn', N'402 Lê Văn Hiến', 2),
(3, N'Bệnh viện Ung Bướu', '02363717717', 'ub@danang.vn', N'BV Ung Bướu Liên Chiểu', N'Tổ 78 Hòa Minh', 3),
(4, N'Bệnh viện Trung ương Huế', '02343822222', 'bvhue@vn', N'BV tuyến trung ương', N'16 Lê Lợi', 4),
(5, N'Bệnh viện Đa khoa Quảng Nam', '02353991111', 'bvqn@vn', N'BV tỉnh Quảng Nam', N'01 Phan Bội Châu', 5),
(6, N'Bệnh viện Đa khoa Bình Định', '02563992222', 'bvbd@vn', N'BV đa khoa', N'106 Nguyễn Huệ', 6),
(7, N'Bệnh viện Khánh Hòa', '02583883333', 'bvkh@vn', N'BV tỉnh Khánh Hòa', N'19 Yersin', 7);
SET IDENTITY_INSERT BenhVien OFF;
-- 4. KHU
SET IDENTITY_INSERT Khu ON;
INSERT INTO Khu (IdKhu, TenKhu, IdBenhVien) 
VALUES (1, N'Khu A', 1), 
(2, N'Khu B', 2), 
(3, N'Khu C', 3),
(4, N'Khu D', 4),
(5, N'Khu E', 5),
(6, N'Khu F', 6),
(7, N'Khu G', 7);
SET IDENTITY_INSERT Khu OFF
-- 5. PHÒNG
SET IDENTITY_INSERT Phong ON;
INSERT INTO Phong (IdPhong, TenPhong, Tang, IdKhu) 
VALUES (1, N'P101', 1, 1), 
(2, N'P202', 2, 2), 
(3, N'P303', 3, 3),
(4, N'P401', 4, 4),
(5, N'P502', 5, 5),
(6, N'P603', 6, 6),
(7, N'P704', 7, 7);
SET IDENTITY_INSERT Phong OFF
USE TimKiemThongTinBacSi;
GO
-- 6. BÁC SĨ
SET IDENTITY_INSERT BacSi ON;
INSERT INTO BacSi (IdBacSi, SoDienThoai, HoTen, Email, MatKhau, NgaySinh, GioiTinh, BangCap, NamKinhNghiem, ChungChiHanhNghe, ThanhTuu, MoTa, AnhDaiDien, soNhaTenDuong, CCCD, IdBenhVien, IdPhuongXa) 
VALUES (1, '0905111222', N'Phạm Minh Huy', 'Huy@gmail.com', 'Huy123!@#', '1980-01-01', N'Nam', N'Tiến sĩ', 15, N'CCHN-12345', N'Bàn tay vàng phẫu thuật tim', N'Chuyên gia nội tim mạch với nhiều năm kinh nghiệm', 'huy_avatar.jpg', N'123 Hải Phòng', '049205002552', 1, 1),
(2, '0905333444', N'Nguyễn Phước Quý Bửu', 'Buu@gmail.com', '123', '1985-05-05', N'Nữ', N'Thạc sĩ', 10, N'CCHN-67890', N'Cứu sống hàng nghìn bệnh nhi', N'Yêu trẻ và tận tâm với nghề y', 'buu_avatar.jpg', N'402 Lê Văn Hiến', '049205002192', 2, 2),
(3, '0905555666', N'Tạ Quang Nhựt', 'Nhut@gmail.com', '123', '1990-10-10', N'Nam', N'Bác sĩ CKI', 7, N'CCHN-55555', N'Nghiên cứu ung thư giai đoạn sớm', N'Luôn cập nhật kiến thức y khoa mới nhất', 'nhut_avatar.jpg', N'78 Hòa Minh', '049205001221', 3, 3),
(4,'0906000001',N'Lê Văn Thành','thanh@bv.vn','123','1982-02-02',N'Nam',N'Thạc sĩ',12,N'CCHN-11111',N'Giỏi ngoại khoa',N'Bác sĩ giàu kinh nghiệm','thanh.jpg',N'12 Lê Lợi','049200001111',4,4),
(5,'0906000002',N'Nguyễn Thị Mai','mai@bv.vn','123','1987-03-03',N'Nữ',N'Bác sĩ CKI',8,N'CCHN-22222',N'Tận tâm bệnh nhân',N'Chuyên khoa tổng quát','mai.jpg',N'22 Phan Bội Châu','049200002222',5,5),
(6,'0906000003',N'Trần Hoàng Long','long@bv.vn','123','1991-04-04',N'Nam',N'Bác sĩ',5,N'CCHN-33333',N'Nhiệt huyết',N'Luôn học hỏi','long.jpg',N'45 Nguyễn Huệ','049200003333',6,6),
(7,'0906000004',N'Phan Thị Hồng','hong@bv.vn','123','1994-05-05',N'Nữ',N'Bác sĩ',3,N'CCHN-44444',N'Trẻ trung',N'Chăm sóc tận tình','hong.jpg',N'99 Yersin','049200004444',7,7);
SET IDENTITY_INSERT BacSi OFF;
-- 7. BỆNH NHÂN
SET IDENTITY_INSERT BenhNhan ON;
INSERT INTO BenhNhan (IdBenhNhan, SoDienThoai, HoTen, Email, MatKhau, NgaySinh, GioiTinh, NgayDangKy, soNhaTenDuong, CCCD, IdPhuongXa) 
VALUES (1, '0914000111', N'Dương Công Tiến', 'Tien@gmail.com', '123', '2000-01-01', N'Nam', GETDATE(), N'45 Nguyễn Chí Thanh', '049200111222', 1),
(2, '0914000222', N'Hoàng Lệ Thu', 'thu@gmail.com', '123', '1998-05-05', N'Nữ', GETDATE(), N'12 Ngũ Hành Sơn', '049200333444', 2),
(3, '0914000333', N'Nguyễn Quốc Sơn', 'son@gmail.com', '123', '1995-10-10', N'Nam', GETDATE(), N'99 Tôn Đức Thắng', '049200555666', 3),
(4,'0915000001',N'Phạm Quốc Huy','pq@bn.vn','123','1999-01-01',N'Nam',GETDATE(),N'10 Lê Lợi','049300001111',4),
(5,'0915000002',N'Ngô Thị Lan','lan@bn.vn','123','2001-02-02',N'Nữ',GETDATE(),N'20 An Mỹ','049300002222',5),
(6,'0915000003',N'Lý Minh Đức','duc@bn.vn','123','1997-03-03',N'Nam',GETDATE(),N'30 Trần Phú','049300003333',6),
(7,'0915000004',N'Võ Thanh Tâm','tam@bn.vn','123','2003-04-04',N'Nữ',GETDATE(),N'40 Vĩnh Hải','049300004444',7);
SET IDENTITY_INSERT BenhNhan OFF;
-- 8. CÁN BỘ HÀNH CHÍNH
SET IDENTITY_INSERT CanBoHanhChinh ON;
INSERT INTO CanBoHanhChinh (IdCanBo, SoDienThoai, HoTen, Email, MatKhau, NgaySinh, GioiTinh, ChucVu, soNhaTenDuong, CCCD, IdBenhVien, IdPhuongXa) 
VALUES (1, '0236111987', N'Phạm Minh Huy', 'Huy@vn', 'Huy123!@#', '1975-01-01', N'Nam', N'Trưởng phòng IT', N'124 Hải Phòng', '049100111222', 1, 1),
(2, '0236222987', N'Minh Huy Phạm', 'MHuy2@vn', '123', '1988-12-12', N'Nam', N'Nhân viên nhân sự', N'20 Võ Nguyên Giáp', '049100333444', 2, 2),
(3, '0236333098', N'Trần Tiếp Tân', 'tieptan@vn', '123', '1992-06-06', N'Nữ', N'Nhân viên điều phối', N'10 Hòa Khánh', '049100555666', 3, 3),
(4,'0236000001',N'Nguyễn Văn Quản','ql@bv.vn','123','1980-01-01',N'Nam',N'Quản lý','12 Lê Lợi','049400001111',4,4),
(5,'0236000002',N'Lê Thị Hạnh','hanh@bv.vn','123','1985-02-02',N'Nữ',N'Nhân sự','22 An Mỹ','049400002222',5,5),
(6,'0236000003',N'Đỗ Minh Khoa','khoa@bv.vn','123','1990-03-03',N'Nam',N'Điều phối','33 Trần Phú','049400003333',6,6),
(7,'0236000004',N'Phan Thị Nga','nga@bv.vn','123','1993-04-04',N'Nữ',N'Thư ký','44 Yersin','049400004444',7,7);
SET IDENTITY_INSERT CanBoHanhChinh OFF;
-- 9. CHUYÊN KHOA
SET IDENTITY_INSERT ChuyenKhoa ON;
INSERT INTO ChuyenKhoa (IdChuyenKhoa, TenChuyenKhoa, MoTa) VALUES 
(1, N'Nội Tim Mạch', N'Khám tim'), 
(2, N'Nhi Khoa', N'Khám trẻ em'), 
(3, N'Ung Bướu', N'Điều trị ung thư'),
(4,N'Ngoại Tổng Quát',N'Phẫu thuật tổng hợp'),
(5,N'Sản Khoa',N'Chăm sóc thai phụ'),
(6,N'Tai Mũi Họng',N'Điều trị tai mũi họng'),
(7,N'Da Liễu',N'Chăm sóc da');
SET IDENTITY_INSERT ChuyenKhoa OFF;
-- 10. CHUYÊN KHOA_BÁC SĨ (Bảng trung gian, không có Identity nên insert bình thường)
INSERT INTO ChuyenKhoa_BacSi (IdBacSi, IdChuyenKhoa) 
VALUES (1, 1), 
(2, 2), 
(3, 3),
(4,4),(5,5),(6,6),(7,7);
-- 11. LỊCH LÀM VIỆC
SET IDENTITY_INSERT LichLamViec ON;
INSERT INTO LichLamViec (IdLichLamViec, NgayLamViec, KhungGio, TrangThai, IdBacSi, IdPhong) VALUES 
(1,'2024-12-30','07:30 - 11:30',N'Sẵn sàng',1,1),
(2,'2024-12-30','13:30 - 17:00',N'Sẵn sàng',2,2),
(3,'2024-12-31','07:30 - 11:30',N'Sẵn sàng',3,3),
(4,'2025-01-02','07:30 - 11:30',N'Sẵn sàng',4,4),
(5,'2025-01-02','13:30 - 17:00',N'Sẵn sàng',5,5),
(6,'2025-01-03','07:30 - 11:30',N'Sẵn sàng',6,6),
(7,'2025-01-03','13:30 - 17:00',N'Sẵn sàng',7,7);

SET IDENTITY_INSERT LichLamViec OFF;
-- 12. THÔNG BÁO
SET IDENTITY_INSERT ThongBao ON;
INSERT INTO ThongBao (IdThongBao, TieuDe, NoiDung, NgayGui, LoaiThongBao, IdCanBo) VALUES 
(1,N'Nghỉ Tết',N'BV nghỉ tết dương lịch',GETDATE(),N'Hành chính',1),
(2,N'Họp chuyên môn',N'Họp bác sĩ khu A',GETDATE(),N'Nội bộ',2),
(3,N'Khám miễn phí',N'Chương trình thiện nguyện',GETDATE(),N'Cộng đồng',3),
(4,N'Cập nhật quy định',N'Quy định mới của Bộ Y tế',GETDATE(),N'Hành chính',4),
(5,N'Tập huấn',N'Tập huấn phòng cháy',GETDATE(),N'Nội bộ',5),
(6,N'Thông báo lịch trực',N'Lịch trực tháng 1',GETDATE(),N'Hành chính',6),
(7,N'Thăm khám cộng đồng',N'Khám bệnh vùng sâu',GETDATE(),N'Cộng đồng',7);
SET IDENTITY_INSERT ThongBao OFF;
-- 13. DANH GIA
SET IDENTITY_INSERT DanhGia ON;
INSERT INTO DanhGia (IdDanhGia, DiemDanhGia, NoiDung, NgayDanhGia, IdBacSi, IdBenhNhan) VALUES 
(1,5,N'Bác sĩ giỏi',GETDATE(),1,1),
(2,4,N'Nhiệt tình',GETDATE(),2,2),
(3,5,N'Rất tốt',GETDATE(),3,3),
(4,4,N'Khám kỹ',GETDATE(),4,4),
(5,5,N'Chu đáo',GETDATE(),5,5),
(6,3,N'Đợi hơi lâu',GETDATE(),6,6),
(7,4,N'Tư vấn rõ ràng',GETDATE(),7,7);
SET IDENTITY_INSERT DanhGia OFF;
-- 14. THÔNG BÁO_BÁC SĨ
INSERT INTO ThongBao_BacSi (IdBacSi, IdThongBao, NgayXem, TrangThaiXem) 
VALUES  
(1,1,GETDATE(),N'Đã xem'),
(2,1,NULL,N'Chưa xem'),
(3,2,GETDATE(),N'Đã xem'),
(4,3,NULL,N'Chưa xem'),
(5,4,GETDATE(),N'Đã xem'),
(6,5,NULL,N'Chưa xem'),
(7,6,GETDATE(),N'Đã xem');
-- 15. THÔNG BÁO_BỆNH NHÂN 
INSERT INTO ThongBao_BenhNhan (IdBenhNhan, IdThongBao, NgayXem, TrangThaiXem) VALUES 
(1,3,GETDATE(),N'Đã xem'),
(2,3,NULL,N'Chưa xem'),
(3,3,GETDATE(),N'Đã xem'),
(4,4,NULL,N'Chưa xem'),
(5,5,GETDATE(),N'Đã xem'),
(6,6,NULL,N'Chưa xem'),
(7,7,GETDATE(),N'Đã xem');
-- 16. THEO DÕI
INSERT INTO TheoDoi (IdBacSi, IdBenhNhan, NgayBatDauTheoDoi) 
VALUES 
(1,1,'2025-01-01'),
(2,2,'2025-01-02'),
(3,3,'2025-01-03'),
(4,4,'2025-01-04'),
(5,5,'2025-01-05'),
(6,6,'2025-01-06'),
(7,7,'2025-01-07');

-- 17. TÌM KIẾM
SET IDENTITY_INSERT TimKiem ON;
INSERT INTO TimKiem (IdTimKiem, TuKhoaTK, ThoiGianTK, ViTriTimKiem, IdBenhNhan) 
VALUES 
(1,N'Bác sĩ tim mạch Đà Nẵng',GETDATE(),N'Hải Châu',1),
(2,N'Khám nhi Mỹ An',GETDATE(),N'Ngũ Hành Sơn',2),
(3,N'Bệnh viện Ung Bướu',GETDATE(),N'Hòa Khánh',3),
(4,N'Bác sĩ ngoại khoa Huế',GETDATE(),N'Huế',4),
(5,N'Khám sản khoa Quảng Nam',GETDATE(),N'Quảng Nam',5),
(6,N'Khám tai mũi họng Bình Định',GETDATE(),N'Bình Định',6),
(7,N'Bác sĩ da liễu Khánh Hòa',GETDATE(),N'Nha Trang',7);
SET IDENTITY_INSERT TimKiem OFF;
-- 18. BÁO CÁO
SET IDENTITY_INSERT BaoCao ON;
INSERT INTO BaoCao (IdBaoCao, NoiDung, LoaiBaoCao, NgayTaoBaoCao, IdCanBo, IdBacSi, IdeBenhNhan) 
VALUES 
(1,N'Báo cáo lượt tìm kiếm tháng 12',N'Thống kê',GETDATE(),1,1,1),
(2,N'Báo cáo danh sách bác sĩ mới',N'Nhân sự',GETDATE(),2,2,2),
(3,N'Phản hồi từ bệnh nhân',N'Góp ý',GETDATE(),3,3,3),
(4,N'Đánh giá chất lượng khám',N'Đánh giá',GETDATE(),4,4,4),
(5,N'Báo cáo lịch trực',N'Điều phối',GETDATE(),5,5,5),
(6,N'Phản ánh thái độ phục vụ',N'Phản ánh',GETDATE(),6,6,6),
(7,N'Báo cáo tổng hợp quý',N'Thống kê',GETDATE(),7,7,7);
SET IDENTITY_INSERT BaoCao OFF;
-------------------------------------------------------------SELECT-----------------------------------------------------------
---Danh sách bác sĩ bị báo cáo
SELECT 
    b.IdBacSi, 
    b.HoTen AS TenBacSi, 
    bc.NoiDung, 
    bc.LoaiBaoCao, 
    bc.NgayTaoBaoCao
FROM BacSi b
JOIN BaoCao bc ON b.IdBacSi = bc.IdBacSi;
---Bác sĩ bị báo cáo nhiều nhất
SELECT TOP 1 
    b.IdBacSi, 
    b.HoTen AS TenBacSi, 
    COUNT(bc.IdBaoCao) AS SoLuotBiBaoCao
FROM BacSi b
JOIN BaoCao bc ON b.IdBacSi = bc.IdBacSi
GROUP BY b.IdBacSi, b.HoTen
ORDER BY SoLuotBiBaoCao DESC;
---Danh sách bệnh nhân đã báo cáo
SELECT 
    bn.IdBenhNhan, 
    bn.HoTen AS TenBenhNhan, 
    bc.NoiDung, 
    bc.LoaiBaoCao, 
    bc.NgayTaoBaoCao
FROM BenhNhan bn
JOIN BaoCao bc ON bn.IdBenhNhan = bc.IdeBenhNhan;
---Bệnh nhân báo cáo nhiều nhất
SELECT TOP 1 
    bn.IdBenhNhan, 
    bn.HoTen AS TenBenhNhan, 
    COUNT(bc.IdBaoCao) AS SoLuotDaBaoCao
FROM BenhNhan bn
JOIN BaoCao bc ON bn.IdBenhNhan = bc.IdeBenhNhan
GROUP BY bn.IdBenhNhan, bn.HoTen
ORDER BY SoLuotDaBaoCao DESC;
-------------------------------------------------------------FUNCTION---------------------------------------------------------------
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
-- Select theo Tên (Tìm gần đúng)
SELECT * FROM BacSi WHERE HoTen LIKE N'%Nguyễn%';
-- Select theo Chuyên khoa
SELECT bs.*, ck.TenChuyenKhoa 
FROM BacSi bs
JOIN ChuyenKhoa_BacSi ckbs ON bs.IdBacSi = ckbs.IdBacSi
JOIN ChuyenKhoa ck ON ckbs.IdChuyenKhoa = ck.IdChuyenKhoa
WHERE ck.TenChuyenKhoa LIKE N'%Nhi khoa%';
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
WHERE px.TenPhuongXa LIKE N'%Hải Châu%';
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
WHERE p.TenPhong LIKE N'%P101%';
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
--1. fn_DinhDangSoDienThoai: Chuyển số điện thoại về định dạng chuẩn (vd: 090... -> +84...).
IF OBJECT_ID('dbo.fn_DinhDangSoDienThoai', 'FN') IS NOT NULL
    DROP FUNCTION dbo.fn_DinhDangSoDienThoai;
GO
CREATE FUNCTION dbo.fn_DinhDangSoDienThoai (@SoDienThoai VARCHAR(30))
RETURNS VARCHAR(30)
AS
BEGIN
    DECLARE @s VARCHAR(30);

    IF @SoDienThoai IS NULL RETURN NULL;

    SET @s = LTRIM(RTRIM(@SoDienThoai));

    SET @s = REPLACE(@s, ' ', '');
    SET @s = REPLACE(@s, '.', '');
    SET @s = REPLACE(@s, '-', '');
    SET @s = REPLACE(@s, '(', '');
    SET @s = REPLACE(@s, ')', '');

    IF @s = '' RETURN NULL;

    IF LEFT(@s, 3) = '+84' RETURN @s;

    IF LEFT(@s, 4) = '0084'
        RETURN '+84' + SUBSTRING(@s, 5, 50);

    IF LEFT(@s, 2) = '84'
        RETURN '+84' + SUBSTRING(@s, 3, 50);

    IF LEFT(@s, 1) = '0'
        RETURN '+84' + SUBSTRING(@s, 2, 50);

    IF LEFT(@s, 1) = '+' RETURN @s;

    RETURN @s;
END
GO
--2. fn_TinhTrungBinhSao: Tính điểm đánh giá trung bình của 1 bác sĩ.
IF OBJECT_ID('dbo.fn_TinhTrungBinhSao', 'FN') IS NOT NULL
    DROP FUNCTION dbo.fn_TinhTrungBinhSao;
GO
CREATE FUNCTION dbo.fn_TinhTrungBinhSao (@IdBacSi INT)
RETURNS DECIMAL(4,2)
AS
BEGIN
    DECLARE @avg DECIMAL(4,2);

    SELECT @avg =
        CAST(AVG(CAST(DiemDanhGia AS DECIMAL(10,2))) AS DECIMAL(4,2))
    FROM dbo.DanhGia
    WHERE IdBacSi = @IdBacSi;

    RETURN ISNULL(@avg, 0.00);
END
GO
--3. fn_DemBenhNhanTheoDoi: Đếm số lượng bệnh nhân đang theo dõi một bác sĩ cụ thể.
IF OBJECT_ID('dbo.fn_DemBenhNhanTheoDoi', 'FN') IS NOT NULL
    DROP FUNCTION dbo.fn_DemBenhNhanTheoDoi;
GO
CREATE FUNCTION dbo.fn_DemBenhNhanTheoDoi (@IdBacSi INT)
RETURNS INT
AS
BEGIN
    DECLARE @cnt INT;

    SELECT @cnt = COUNT(*)
    FROM dbo.TheoDoi
    WHERE IdBacSi = @IdBacSi;

    RETURN ISNULL(@cnt, 0);
END
GO
--4. fn_KiemTraLichTrong: Trả về 1 (True) nếu bác sĩ rảnh vào một khung giờ/ngày cụ thể.
IF OBJECT_ID('dbo.fn_KiemTraLichTrong', 'FN') IS NOT NULL
    DROP FUNCTION dbo.fn_KiemTraLichTrong;
GO
CREATE FUNCTION dbo.fn_KiemTraLichTrong
(
    @IdBacSi  INT,
    @Ngay     DATE,
    @KhungGio NVARCHAR(50)
)
RETURNS BIT
AS
BEGIN
    DECLARE @kq BIT = 0;

    IF EXISTS
    (
        SELECT 1
        FROM dbo.LichLamViec
        WHERE IdBacSi    = @IdBacSi
          AND NgayLamViec = @Ngay
          AND KhungGio    = @KhungGio
          AND TrangThai IN (N'Sẵn sàng', N'Rảnh', N'Trống', N'Available')
    )
    SET @kq = 1;

    RETURN @kq;
END
GO
--5. fn_LayDiaChiDayDuBacSi: Kết hợp Số nhà + Phường + Tỉnh thành thành 1 chuỗi.
IF OBJECT_ID('dbo.fn_LayDiaChiDayDuBacSi', 'FN') IS NOT NULL
    DROP FUNCTION dbo.fn_LayDiaChiDayDuBacSi;
GO
CREATE FUNCTION dbo.fn_LayDiaChiDayDuBacSi (@IdBacSi INT)
RETURNS NVARCHAR(500)
AS
BEGIN
    DECLARE @diachi NVARCHAR(500);

    SELECT @diachi =
        LTRIM(RTRIM(
            COALESCE(NULLIF(bs.soNhaTenDuong, N''), N'')
            + CASE
                WHEN NULLIF(bs.soNhaTenDuong, N'') IS NOT NULL AND px.TenPhuongXa IS NOT NULL
                    THEN N', '
                ELSE N''
              END
            + COALESCE(px.TenPhuongXa, N'')
            + CASE
                WHEN (NULLIF(bs.soNhaTenDuong, N'') IS NOT NULL OR px.TenPhuongXa IS NOT NULL)
                     AND tt.TenTinhThanh IS NOT NULL
                    THEN N', '
                ELSE N''
              END
            + COALESCE(tt.TenTinhThanh, N'')
        ))
    FROM dbo.BacSi bs
    LEFT JOIN dbo.PhuongXa  px ON bs.IdPhuongXa = px.IdPhuongXa
    LEFT JOIN dbo.TinhThanh tt ON px.IdTinhThanh = tt.IdTinhThanh
    WHERE bs.IdBacSi = @IdBacSi;

    RETURN NULLIF(@diachi, N'');
END
GO
--6.fn_TinhTuoi
CREATE FUNCTION fn_TinhTuoi (@NgaySinh DATE)
RETURNS INT
AS
BEGIN
    RETURN DATEDIFF(YEAR, @NgaySinh, GETDATE()) - 
           CASE WHEN (MONTH(@NgaySinh) > MONTH(GETDATE())) 
           OR (MONTH(@NgaySinh) = MONTH(GETDATE()) AND DAY(@NgaySinh) > DAY(GETDATE())) 
           THEN 1 ELSE 0 END;
END;
GO
--7.fn_PhanLoaiKinhNghiem
CREATE FUNCTION fn_PhanLoaiKinhNghiem (@IdBacSi INT)
RETURNS NVARCHAR(50)
AS
BEGIN
    DECLARE @Nam INT;
    DECLARE @KetQua NVARCHAR(50);
    
    SELECT @Nam = NamKinhNghiem FROM BacSi WHERE IdBacSi = @IdBacSi;
    
    SET @KetQua = CASE 
        WHEN @Nam > 10 THEN N'Chuyên gia'
        WHEN @Nam BETWEEN 5 AND 10 THEN N'Kinh nghiệm'
        ELSE N'Trẻ'
    END;
    
    RETURN @KetQua;
END;
GO
--8.fn_LayTenChuyenKhoaChinh
CREATE FUNCTION fn_LayTenChuyenKhoaChinh (@IdBacSi INT)
RETURNS NVARCHAR(150)
AS
BEGIN
    DECLARE @TenCK NVARCHAR(150);
    
    SELECT TOP 1 @TenCK = ck.TenChuyenKhoa
    FROM ChuyenKhoa ck
    JOIN ChuyenKhoa_BacSi ckbs ON ck.IdChuyenKhoa = ckbs.IdChuyenKhoa
    WHERE ckbs.IdBacSi = @IdBacSi;
    
    RETURN ISNULL(@TenCK, N'Chưa có');
END;
GO
--9.fn_DemThongBaoChuaDoc
CREATE FUNCTION fn_DemThongBaoChuaDoc (@IdNguoiDung INT, @LoaiNguoiDung NVARCHAR(20))
RETURNS INT
AS
BEGIN
    DECLARE @SoLuong INT = 0;
    
    IF @LoaiNguoiDung = 'BacSi'
    BEGIN
        SELECT @SoLuong = COUNT(*) FROM ThongBao_BacSi 
        WHERE IdBacSi = @IdNguoiDung AND TrangThaiXem = N'Chưa xem';
    END
    ELSE IF @LoaiNguoiDung = 'BenhNhan'
    BEGIN
        SELECT @SoLuong = COUNT(*) FROM ThongBao_BenhNhan 
        WHERE IdBenhNhan = @IdNguoiDung AND TrangThaiXem = N'Chưa xem';
    END
    
    RETURN @SoLuong;
END;
GO
-- 10. fn_TinhTyLePhanHoi: Tính % số thông báo đã xem trên tổng số thông báo nhận được (cho Bệnh nhân)
GO
CREATE FUNCTION fn_TinhTyLePhanHoi(@idBenhNhan INT)
RETURNS DECIMAL(5,2)
AS
BEGIN
    DECLARE @TongSo INT, @SoDaXem INT, @TyLe DECIMAL(5,2)
    
    SELECT @TongSo = COUNT(*) FROM ThongBao_BenhNhan WHERE IdBenhNhan = @idBenhNhan
    SELECT @SoDaXem = COUNT(*) FROM ThongBao_BenhNhan WHERE IdBenhNhan = @idBenhNhan AND TrangThaiXem = N'Đã xem'
    
    IF @TongSo = 0 SET @TyLe = 0
    ELSE SET @TyLe = (CAST(@SoDaXem AS DECIMAL(5,2)) / @TongSo) * 100
    
    RETURN @TyLe
END
GO
	-- Kiểm tra cho Bệnh nhân Id = 1 (Dương Công Tiến)
	-- Trong phần INSERT của bạn, Tiến có 1 thông báo và đã xem -> Kết quả kỳ vọng: 100.00
	/*SELECT 
		HoTen, 
		dbo.fn_TinhTyLePhanHoi(IdBenhNhan) AS TyLePhanHoi_PhanTram
	FROM BenhNhan
	WHERE IdBenhNhan = 1;

	-- Kiểm tra cho Bệnh nhân Id = 2 (Hoàng Lệ Thu)
	-- Thu có 1 thông báo nhưng NULL NgayXem -> Kết quả kỳ vọng: 0.00
	SELECT 
		HoTen, 
		dbo.fn_TinhTyLePhanHoi(IdBenhNhan) AS TyLePhanHoi_PhanTram
	FROM BenhNhan
	WHERE IdBenhNhan = 2;*/

-- 11. fn_LayDanhSachBacSiTheoPhuong: Trả về bảng danh sách bác sĩ tại 1 IdPhuongXa
GO
CREATE FUNCTION fn_LayDanhSachBacSiTheoPhuong(@idPhuongXa INT)
RETURNS TABLE
AS
RETURN (
    SELECT IdBacSi, HoTen, SoDienThoai, BangCap
    FROM BacSi
    WHERE IdPhuongXa = @idPhuongXa
)
GO
	-- Lấy bác sĩ ở Phường Hải Châu I (IdPhuongXa = 1)
	-- Kết quả kỳ vọng: Bác sĩ Phạm Minh Huy
	/*SELECT * FROM dbo.fn_LayDanhSachBacSiTheoPhuong(1);

	-- Thử với một ID không có bác sĩ nào (ví dụ: 99) -> Kết quả kỳ vọng: Bảng trống
	SELECT * FROM dbo.fn_LayDanhSachBacSiTheoPhuong(99);*/

-- 12. fn_KiemTraCCCD: Kiểm tra độ dài và định dạng số CCCD (12 số)
GO
CREATE FUNCTION fn_KiemTraCCCD(@cccd VARCHAR(20))
RETURNS NVARCHAR(50)
AS
BEGIN
    IF LEN(@cccd) = 12 AND @cccd NOT LIKE '%[^0-9]%'
        RETURN N'Hợp lệ'
    RETURN N'Không hợp lệ'
END
GO
	/*SELECT 
		'049205002552' AS SoNhapVao, dbo.fn_KiemTraCCCD('049205002552') AS KetQua -- Đúng 12 số
	UNION ALL
	SELECT 
		'12345' AS SoNhapVao, dbo.fn_KiemTraCCCD('12345') AS KetQua -- Sai (thiếu độ dài)
	UNION ALL
	SELECT 
		'04920500255A' AS SoNhapVao, dbo.fn_KiemTraCCCD('04920500255A') AS KetQua; -- Sai (chứa chữ)*/

-- 13. fn_LocTuKhoaNhayCam: Kiểm tra nội dung DanhGia có chứa từ cấm không
GO
CREATE FUNCTION fn_LocTuKhoaNhayCam(@noiDung NVARCHAR(MAX))
RETURNS NVARCHAR(50)
AS
BEGIN
    -- Bạn có thể thêm nhiều từ cấm vào đây
    IF @noiDung LIKE N'%tệ%' OR @noiDung LIKE N'%dở%' OR @noiDung LIKE N'%lừa đảo%'
        RETURN N'Vi phạm'
    RETURN N'Hợp lệ'
END
GO
	/*SELECT 
		N'Bác sĩ rất tận tâm' AS NoiDung, dbo.fn_LocTuKhoaNhayCam(N'Bác sĩ rất tận tâm') AS KiemTra
	UNION ALL
	SELECT
N'Dịch vụ quá tệ và lừa đảo' AS NoiDung, dbo.fn_LocTuKhoaNhayCam(N'Dịch vụ quá tệ và lừa đảo') AS KiemTra;*/

-- 14. fn_DemSoCaKhamTrongNgay: Đếm tổng số ca làm việc của 1 bệnh viện trong ngày
GO
CREATE FUNCTION fn_DemSoCaKhamTrongNgay(@idBenhVien INT, @ngay DATE)
RETURNS INT
AS
BEGIN
    DECLARE @soCa INT
    SELECT @soCa = COUNT(l.IdLichLamViec)
    FROM LichLamViec l
    JOIN BacSi b ON l.IdBacSi = b.IdBacSi
    WHERE b.IdBenhVien = @idBenhVien AND l.NgayLamViec = @ngay
    RETURN ISNULL(@soCa, 0)
END
GO
	-- Kiểm tra Bệnh viện Đà Nẵng (Id = 1) vào ngày 2024-12-30
	-- Kết quả kỳ vọng: 1 (vì có bác sĩ Phạm Minh Huy trực P101)
	/*SELECT 
		TenBenhVien, 
		dbo.fn_DemSoCaKhamTrongNgay(IdBenhVien, '2024-12-30') AS SoCaTrucTrongNgay
	FROM BenhVien
	WHERE IdBenhVien = 1;

	-- Thử ngày không có lịch khám -> Kết quả kỳ vọng: 0
	SELECT dbo.fn_DemSoCaKhamTrongNgay(1, '1900-01-01') AS SoCaTrucTrongNgay;*/

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
GO
USE TimKiemThongTinBacSi;
GO
IF TYPE_ID(N'dbo.IdList') IS NULL
    EXEC(N'CREATE TYPE dbo.IdList AS TABLE (Id INT NOT NULL PRIMARY KEY)');
GO
--1. pr_DangKyBacSi: Thêm mới bác sĩ kèm theo việc gán Chuyên khoa vào bảng trung gian.
IF OBJECT_ID('dbo.pr_DangKyBacSi', 'P') IS NOT NULL
    DROP PROCEDURE dbo.pr_DangKyBacSi;
GO
CREATE PROCEDURE dbo.pr_DangKyBacSi
(
    @SoDienThoai       VARCHAR(15),
    @HoTen             NVARCHAR(100),
    @Email             VARCHAR(100),
    @MatKhau           VARCHAR(255),
    @NgaySinh          DATE = NULL,
    @GioiTinh          NVARCHAR(10) = NULL,
    @BangCap           NVARCHAR(100) = NULL,
    @NamKinhNghiem     INT = NULL,
    @ChungChiHanhNghe  NVARCHAR(255) = NULL,
    @ThanhTuu          NVARCHAR(MAX) = NULL,
    @MoTa              NVARCHAR(MAX) = NULL,
    @AnhDaiDien        NVARCHAR(255) = NULL,
    @SoNhaTenDuong     NVARCHAR(255) = NULL,
    @CCCD              VARCHAR(20) = NULL,
    @IdBenhVien        INT = NULL,
    @IdPhuongXa        INT = NULL,
    @ChuyenKhoaIds     dbo.IdList READONLY, 
    @IdBacSiMoi        INT OUTPUT
)
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRY
        BEGIN TRAN;

        DECLARE @PhoneStd VARCHAR(30) = dbo.fn_DinhDangSoDienThoai(@SoDienThoai);

        IF EXISTS (SELECT 1 FROM dbo.BacSi WHERE Email = @Email)
            THROW 50001, N'Email bác sĩ đã tồn tại.', 1;

        IF @CCCD IS NOT NULL AND EXISTS (SELECT 1 FROM dbo.BacSi WHERE CCCD = @CCCD)
            THROW 50002, N'CCCD bác sĩ đã tồn tại.', 1;

        IF @PhoneStd IS NOT NULL AND EXISTS (SELECT 1 FROM dbo.BacSi WHERE dbo.fn_DinhDangSoDienThoai(SoDienThoai) = @PhoneStd)
            THROW 50003, N'Số điện thoại bác sĩ đã tồn tại.', 1;

        INSERT INTO dbo.BacSi
        (
            SoDienThoai, HoTen, Email, MatKhau, NgaySinh, GioiTinh, BangCap, NamKinhNghiem,
            ChungChiHanhNghe, ThanhTuu, MoTa, AnhDaiDien, soNhaTenDuong, CCCD, IdBenhVien, IdPhuongXa
        )
        VALUES
        (
            @PhoneStd, @HoTen, @Email, @MatKhau, @NgaySinh, @GioiTinh, @BangCap, @NamKinhNghiem,
            @ChungChiHanhNghe, @ThanhTuu, @MoTa, @AnhDaiDien, @SoNhaTenDuong, @CCCD, @IdBenhVien, @IdPhuongXa
        );

        SET @IdBacSiMoi = SCOPE_IDENTITY();

        INSERT INTO dbo.ChuyenKhoa_BacSi (IdBacSi, IdChuyenKhoa)
        SELECT @IdBacSiMoi, ck.Id
        FROM @ChuyenKhoaIds ck;

        COMMIT;
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0 ROLLBACK;
        THROW;
    END CATCH
END
GO
--2. pr_CapNhatLichCongTac: Thay đổi hàng loạt trạng thái lịch làm việc.
IF OBJECT_ID('dbo.pr_CapNhatLichCongTac', 'P') IS NOT NULL
    DROP PROCEDURE dbo.pr_CapNhatLichCongTac;
GO
CREATE PROCEDURE dbo.pr_CapNhatLichCongTac
(
    @IdBacSi       INT,
    @NgayTu        DATE,
    @NgayDen       DATE,
    @TrangThaiMoi  NVARCHAR(50),
    @KhungGio      NVARCHAR(50) = NULL
)
AS
BEGIN
    SET NOCOUNT ON;

    IF @NgayTu IS NULL OR @NgayDen IS NULL OR @NgayTu > @NgayDen
        THROW 50101, N'Khoảng ngày không hợp lệ.', 1;

    UPDATE dbo.LichLamViec
    SET TrangThai = @TrangThaiMoi
    WHERE IdBacSi = @IdBacSi
      AND NgayLamViec BETWEEN @NgayTu AND @NgayDen
      AND (@KhungGio IS NULL OR KhungGio = @KhungGio);

    SELECT @@ROWCOUNT AS SoDongDaCapNhat;
END
GO
--3. pr_DatLichHen: (Nghiệp vụ quan trọng) Chèn dữ liệu vào bảng liên quan và kiểm tra xung đột lịch.
IF OBJECT_ID('dbo.pr_DatLichHen', 'P') IS NOT NULL
    DROP PROCEDURE dbo.pr_DatLichHen;
GO
CREATE PROCEDURE dbo.pr_DatLichHen
(
    @IdBenhNhan  INT,
    @IdBacSi     INT,
    @Ngay        DATE,
    @KhungGio    NVARCHAR(50),
    @IdPhong     INT = NULL,
    @GhiChu      NVARCHAR(500) = NULL
)
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @IdLichLamViec INT;
    DECLARE @IdThongBao INT;

    BEGIN TRY
        BEGIN TRAN;

        -- Validate FK tối thiểu
        IF NOT EXISTS (SELECT 1 FROM dbo.BenhNhan WHERE IdBenhNhan = @IdBenhNhan)
            THROW 50201, N'Bệnh nhân không tồn tại.', 1;

        IF NOT EXISTS (SELECT 1 FROM dbo.BacSi WHERE IdBacSi = @IdBacSi)
            THROW 50202, N'Bác sĩ không tồn tại.', 1;

        -- Tìm slot
        SELECT TOP 1 @IdLichLamViec = IdLichLamViec
        FROM dbo.LichLamViec
        WHERE IdBacSi = @IdBacSi
          AND NgayLamViec = @Ngay
          AND KhungGio = @KhungGio
          AND (@IdPhong IS NULL OR IdPhong = @IdPhong);

        IF @IdLichLamViec IS NULL
            THROW 50203, N'Không tồn tại lịch làm việc phù hợp để đặt.', 1;

        -- Chốt lịch (atomic): chỉ đổi được nếu đang Sẵn sàng
        UPDATE dbo.LichLamViec
        SET TrangThai = N'Đã đặt'
        WHERE IdLichLamViec = @IdLichLamViec
          AND TrangThai = N'Sẵn sàng';

        IF @@ROWCOUNT = 0
            THROW 50204, N'Khung giờ không còn trống (đã đặt hoặc không sẵn sàng).', 1;

        -- Tạo thông báo
        INSERT INTO dbo.ThongBao (TieuDe, NoiDung, NgayGui, LoaiThongBao, IdCanBo)
        VALUES
        (
            N'Xác nhận đặt lịch',
            CONCAT(
                N'Bệnh nhân #', @IdBenhNhan,
                N' đã đặt lịch với bác sĩ #', @IdBacSi,
                N' vào ', CONVERT(NVARCHAR(10), @Ngay, 120),
                N' (', @KhungGio, N').',
                CASE
                    WHEN @GhiChu IS NULL OR LTRIM(RTRIM(@GhiChu)) = N'' THEN N''
                    ELSE CONCAT(N' Ghi chú: ', @GhiChu)
                END
            ),
            GETDATE(),
            N'Lịch hẹn',
            NULL
        );

        SET @IdThongBao = SCOPE_IDENTITY();

        INSERT INTO dbo.ThongBao_BacSi (IdBacSi, IdThongBao, NgayXem, TrangThaiXem)
        VALUES (@IdBacSi, @IdThongBao, NULL, N'Chưa xem');

        INSERT INTO dbo.ThongBao_BenhNhan (IdBenhNhan, IdThongBao, NgayXem, TrangThaiXem)
        VALUES (@IdBenhNhan, @IdThongBao, NULL, N'Chưa xem');

        COMMIT;

        SELECT
            @IdLichLamViec AS IdLichLamViecDaDat,
            @IdThongBao AS IdThongBaoDaTao;
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0 ROLLBACK;
        THROW;
    END CATCH
END
GO
--4. pr_TimKiemThongMinh: Tìm bác sĩ theo Tên, Chuyên khoa, và Địa điểm đồng thời lưu vào TimKiem.
IF OBJECT_ID('dbo.pr_TimKiemThongMinh', 'P') IS NOT NULL
    DROP PROCEDURE dbo.pr_TimKiemThongMinh;
GO
CREATE PROCEDURE dbo.pr_TimKiemThongMinh
(
    @TenBacSi      NVARCHAR(100) = NULL,
    @IdChuyenKhoa  INT = NULL,
    @IdTinhThanh   INT = NULL,
    @IdPhuongXa    INT = NULL,
    @IdBenhNhan    INT = NULL,
    @ViTriTimKiem  NVARCHAR(255) = NULL
)
AS
BEGIN
    SET NOCOUNT ON;

    -- log tìm kiếm (IdBenhNhan có thể NULL)
    DECLARE @TuKhoa NVARCHAR(255) =
        LTRIM(RTRIM(CONCAT(
            ISNULL(@TenBacSi, N''),
            CASE WHEN @IdChuyenKhoa IS NULL THEN N'' ELSE CONCAT(N' | CK:', @IdChuyenKhoa) END,
            CASE WHEN @IdPhuongXa IS NULL THEN N'' ELSE CONCAT(N' | PX:', @IdPhuongXa) END,
            CASE WHEN @IdTinhThanh IS NULL THEN N'' ELSE CONCAT(N' | TT:', @IdTinhThanh) END
        )));

    INSERT INTO dbo.TimKiem (TuKhoaTK, ThoiGianTK, ViTriTimKiem, IdBenhNhan)
    VALUES (@TuKhoa, GETDATE(), @ViTriTimKiem, @IdBenhNhan);

    -- kết quả tìm kiếm
    ;WITH CK AS
    (
        SELECT ckb.IdBacSi,
               STRING_AGG(ck.TenChuyenKhoa, N', ') AS DanhSachChuyenKhoa
        FROM dbo.ChuyenKhoa_BacSi ckb
        JOIN dbo.ChuyenKhoa ck ON ck.IdChuyenKhoa = ckb.IdChuyenKhoa
        GROUP BY ckb.IdBacSi
    )
    SELECT DISTINCT
        bs.IdBacSi,
        bs.HoTen,
        dbo.fn_DinhDangSoDienThoai(bs.SoDienThoai) AS SoDienThoaiChuan,
        bs.Email,
        bv.TenBenhVien,
        dbo.fn_LayDiaChiDayDuBacSi(bs.IdBacSi) AS DiaChiDayDu,
        ISNULL(ck.DanhSachChuyenKhoa, N'') AS ChuyenKhoa,
        dbo.fn_TinhTrungBinhSao(bs.IdBacSi) AS DiemTB,
        dbo.fn_DemBenhNhanTheoDoi(bs.IdBacSi) AS SoNguoiTheoDoi
    FROM dbo.BacSi bs
    LEFT JOIN dbo.BenhVien bv ON bv.IdBenhVien = bs.IdBenhVien
    LEFT JOIN dbo.PhuongXa px ON px.IdPhuongXa = bs.IdPhuongXa
    LEFT JOIN CK ck ON ck.IdBacSi = bs.IdBacSi
    WHERE
        (@TenBacSi IS NULL OR bs.HoTen LIKE N'%' + @TenBacSi + N'%')
        AND
        (@IdChuyenKhoa IS NULL OR EXISTS
            (
                SELECT 1
                FROM dbo.ChuyenKhoa_BacSi x
                WHERE x.IdBacSi = bs.IdBacSi
                  AND x.IdChuyenKhoa = @IdChuyenKhoa
            )
        )
        AND
        (
            (@IdPhuongXa IS NULL AND @IdTinhThanh IS NULL)
            OR (@IdPhuongXa IS NOT NULL AND bs.IdPhuongXa = @IdPhuongXa)
            OR (@IdPhuongXa IS NULL AND @IdTinhThanh IS NOT NULL AND px.IdTinhThanh = @IdTinhThanh)
        )
    ORDER BY bs.HoTen;
END
GO
--5. pr_DoiMatKhau: Kiểm tra mật khẩu cũ và cập nhật mật khẩu mới cho người dùng.
IF OBJECT_ID('dbo.pr_DoiMatKhau', 'P') IS NOT NULL
    DROP PROCEDURE dbo.pr_DoiMatKhau;
GO
CREATE PROCEDURE dbo.pr_DoiMatKhau
(
    @LoaiNguoiDung NVARCHAR(20),  -- 'BACSI' | 'BENHNHAN' | 'CANBO'
    @IdNguoiDung   INT,
    @MatKhauCu     VARCHAR(255),
    @MatKhauMoi    VARCHAR(255)
)
AS
BEGIN
    SET NOCOUNT ON;

    IF @MatKhauMoi IS NULL OR LTRIM(RTRIM(@MatKhauMoi)) = ''
        THROW 50301, N'Mật khẩu mới không hợp lệ.', 1;

    IF UPPER(@LoaiNguoiDung) = 'BACSI'
    BEGIN
        IF NOT EXISTS (SELECT 1 FROM dbo.BacSi WHERE IdBacSi = @IdNguoiDung AND MatKhau = @MatKhauCu)
            THROW 50302, N'Mật khẩu cũ không đúng hoặc tài khoản không tồn tại.', 1;

        UPDATE dbo.BacSi SET MatKhau = @MatKhauMoi WHERE IdBacSi = @IdNguoiDung;
        SELECT 1 AS ThanhCong;
        RETURN;
    END

    IF UPPER(@LoaiNguoiDung) = 'BENHNHAN'
    BEGIN
        IF NOT EXISTS (SELECT 1 FROM dbo.BenhNhan WHERE IdBenhNhan = @IdNguoiDung AND MatKhau = @MatKhauCu)
            THROW 50302, N'Mật khẩu cũ không đúng hoặc tài khoản không tồn tại.', 1;

        UPDATE dbo.BenhNhan SET MatKhau = @MatKhauMoi WHERE IdBenhNhan = @IdNguoiDung;
        SELECT 1 AS ThanhCong;
        RETURN;
    END

    IF UPPER(@LoaiNguoiDung) = 'CANBO'
    BEGIN
        IF NOT EXISTS (SELECT 1 FROM dbo.CanBoHanhChinh WHERE IdCanBo = @IdNguoiDung AND MatKhau = @MatKhauCu)
            THROW 50302, N'Mật khẩu cũ không đúng hoặc tài khoản không tồn tại.', 1;

        UPDATE dbo.CanBoHanhChinh SET MatKhau = @MatKhauMoi WHERE IdCanBo = @IdNguoiDung;
        SELECT 1 AS ThanhCong;
        RETURN;
    END

    --THROW 50303, N'LoaiNguoiDung không hợp lệ. Dùng: BACSI | BENHNHAN | CANBO.', 1;
END
GO
--6.pr_XoaTaiKhoanAnToan (Soft Delete)
CREATE PROCEDURE pr_XoaTaiKhoanAnToan
    @IdBenhNhan INT
AS
BEGIN
    SET NOCOUNT ON;
    -- Kiểm tra bệnh nhân có tồn tại không
    IF EXISTS (SELECT 1 FROM BenhNhan WHERE IdBenhNhan = @IdBenhNhan)
    BEGIN
        UPDATE BenhNhan 
        SET TrangThai = 0 
        WHERE IdBenhNhan = @IdBenhNhan;
        
        PRINT N'Đã chuyển trạng thái bệnh nhân sang 0 (Xóa mềm). Dữ liệu lịch sử báo cáo vẫn an toàn.';
    END
    ELSE
        PRINT N'Không tìm thấy ID bệnh nhân này.';
END;
GO
--7.pr_GuiThongBaoHeThong
CREATE PROCEDURE pr_GuiThongBaoHeThong
    @IdCanBo INT,
    @IdBenhVien INT,
    @TieuDe NVARCHAR(255),
    @NoiDung NVARCHAR(MAX),
    @LoaiThongBao NVARCHAR(100)
AS
BEGIN
    SET NOCOUNT ON;
    DECLARE @NewIdThongBao INT;

    -- 1. Tạo thông báo chính
    INSERT INTO ThongBao (TieuDe, NoiDung, NgayGui, LoaiThongBao, IdCanBo)
    VALUES (@TieuDe, @NoiDung, GETDATE(), @LoaiThongBao, @IdCanBo);

    SET @NewIdThongBao = SCOPE_IDENTITY();

    -- 2. Gửi cho tất cả bác sĩ thuộc bệnh viện được chọn
    INSERT INTO ThongBao_BacSi (IdBacSi, IdThongBao, TrangThaiXem)
    SELECT IdBacSi, @NewIdThongBao, N'Chưa xem'
    FROM BacSi
    WHERE IdBenhVien = @IdBenhVien;
END;
GO
--8.pr_ThongKeTuKhoaHot
CREATE PROCEDURE pr_ThongKeTuKhoaHot
AS
BEGIN
    SET NOCOUNT ON;
    SELECT TOP 10 
        TuKhoaTK, 
        COUNT(IdTimKiem) AS SoLuotTim
    FROM TimKiem
    WHERE ThoiGianTK >= DATEADD(DAY, -7, GETDATE())
    GROUP BY TuKhoaTK
    ORDER BY SoLuotTim DESC;
END;
GO
--9.pr_TuDongPhanPhong
CREATE PROCEDURE pr_TuDongPhanPhong
    @NgayLamViec DATE,
    @KhungGio NVARCHAR(50)
AS
BEGIN
    SET NOCOUNT ON;

    -- Gán bác sĩ chưa có lịch vào các phòng trống thuộc bệnh viện họ đang làm
    INSERT INTO LichLamViec (NgayLamViec, KhungGio, TrangThai, IdBacSi, IdPhong)
    SELECT 
        @NgayLamViec, 
        @KhungGio, 
        N'Sẵn sàng', 
        B.IdBacSi, 
        (SELECT TOP 1 P.IdPhong 
         FROM Phong P 
         INNER JOIN Khu K ON P.IdKhu = K.IdKhu 
         WHERE K.IdBenhVien = B.IdBenhVien
         AND P.IdPhong NOT IN (
            SELECT IdPhong FROM LichLamViec 
            WHERE NgayLamViec = @NgayLamViec AND KhungGio = @KhungGio
         ))
    FROM BacSi B
    WHERE B.IdBacSi NOT IN (
        SELECT IdBacSi FROM LichLamViec 
        WHERE NgayLamViec = @NgayLamViec AND KhungGio = @KhungGio
    );
END;
GO
-- 10. pr_ImportDanhSachPhuongXa: Thêm hàng loạt dữ liệu địa chính từ bảng tạm
GO
CREATE OR ALTER PROC pr_ImportDanhSachPhuongXa
AS
BEGIN
    -- Kiểm tra nếu bảng tạm tồn tại trong phiên làm việc hiện tại
    IF OBJECT_ID('tempdb..#TmpPhuongXa') IS NOT NULL
    BEGIN
        INSERT INTO PhuongXa (TenPhuongXa, IdTinhThanh)
        SELECT t.TenPhuong, t.IdTinh
        FROM #TmpPhuongXa t
        WHERE NOT EXISTS (
            SELECT 1 FROM PhuongXa p 
            WHERE p.TenPhuongXa = t.TenPhuong AND p.IdTinhThanh = t.IdTinh
        );
        PRINT N'Đã nhập dữ liệu thành công.';
    END
    ELSE
    BEGIN
        PRINT N'Lỗi: Không tìm thấy bảng tạm #TmpPhuongXa.';
    END
END;
GO
	-- TEST CÂU 10:
	/*CREATE TABLE #TmpPhuongXa (TenPhuong NVARCHAR(100), IdTinh INT);
	INSERT INTO #TmpPhuongXa VALUES (N'Phường Mỹ Khê', 1), (N'Phường An Khê', 1);
	EXEC pr_ImportDanhSachPhuongXa;
	SELECT * FROM PhuongXa WHERE TenPhuongXa IN (N'Phường Mỹ Khê', N'Phường An Khê');
	DROP TABLE #TmpPhuongXa;
	GO*/

-- 11. pr_DuyetDanhGia: Cán bộ hành chính kiểm tra đánh giá (Xử lý trực tiếp không dùng Function)
GO
CREATE OR ALTER PROC pr_DuyetDanhGia
    @IdDanhGia INT,
    @IdCanBo INT
AS
BEGIN
    DECLARE @NoiDung NVARCHAR(MAX);
    SELECT @NoiDung = NoiDung FROM DanhGia WHERE IdDanhGia = @IdDanhGia;

    -- Kiểm tra từ khóa nhạy cảm trực tiếp bằng LIKE
    IF @NoiDung LIKE N'%tệ%' OR @NoiDung LIKE N'%dở%' OR @NoiDung LIKE N'%lừa đảo%' OR @NoiDung LIKE N'%kém%'
    BEGIN
        PRINT N'Đánh giá ID ' + CAST(@IdDanhGia AS NVARCHAR) + N' vi phạm quy tắc. KHÔNG DUYỆT!';
    END
    ELSE
    BEGIN
        PRINT N'Đánh giá hợp lệ. Cán bộ ID ' + CAST(@IdCanBo AS NVARCHAR) + N' đã xác nhận.';
    END
END;
GO
	-- TEST CÂU 11:
	-- 1. Test nội dung sạch
	/*EXEC pr_DuyetDanhGia @IdDanhGia = 1, @IdCanBo = 1;
	-- 2. Test nội dung nhạy cảm
	INSERT INTO DanhGia (DiemDanhGia, NoiDung, NgayDanhGia, IdBacSi, IdBenhNhan) 
	VALUES (1, N'Bác sĩ lừa đảo khách hàng', GETDATE(), 1, 1);
	DECLARE @IdTest11 INT = SCOPE_IDENTITY();
	EXEC pr_DuyetDanhGia @IdDanhGia = @IdTest11, @IdCanBo = 1;
	GO*/

-- 12. pr_SuaThongTinBenhVien: Cập nhật Hotline/Email của bệnh viện
GO
CREATE OR ALTER PROC pr_SuaThongTinBenhVien
    @IdBenhVien INT,
    @Hotline VARCHAR(20),
    @Email VARCHAR(100)
AS
BEGIN
    UPDATE BenhVien
    SET HotLine = @Hotline, Email = @Email
    WHERE IdBenhVien = @IdBenhVien;

    IF @@ROWCOUNT > 0
        PRINT N'Cập nhật thông tin bệnh viện ' + CAST(@IdBenhVien AS NVARCHAR) + N' thành công.';
    ELSE
        PRINT N'Lỗi: Không tìm thấy ID bệnh viện này.';
END;
GO
	-- TEST CÂU 12:
	/*EXEC pr_SuaThongTinBenhVien @IdBenhVien = 1, @Hotline = '0988777666', @Email = 'danang_hospital@gmail.com';
	SELECT IdBenhVien, TenBenhVien, HotLine, Email FROM BenhVien WHERE IdBenhVien = 1;
	GO*/
-- 13. pr_ChuyenCongTacBacSi: Thay đổi IdBenhVien và dọn dẹp lịch làm việc
GO
CREATE OR ALTER PROC pr_ChuyenCongTacBacSi
    @IdBacSi INT,
    @IdBenhVienMoi INT
AS
BEGIN
    BEGIN TRANSACTION;
    BEGIN TRY
        -- Đổi cơ sở công tác
        UPDATE BacSi SET IdBenhVien = @IdBenhVienMoi WHERE IdBacSi = @IdBacSi;

        -- Xóa lịch trực tại cơ sở cũ từ hôm nay trở đi (vì phòng cũ không còn hiệu lực)
        DELETE FROM LichLamViec 
        WHERE IdBacSi = @IdBacSi AND NgayLamViec >= CAST(GETDATE() AS DATE);

        COMMIT TRANSACTION;
        PRINT N'Bác sĩ ID ' + CAST(@IdBacSi AS NVARCHAR) + N' đã chuyển viện.';
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;
        PRINT N'Lỗi hệ thống: Không thể chuyển công tác.';
    END CATCH
END;
GO
	-- TEST CÂU 13:
	-- Chuyển bác sĩ 2 sang bệnh viện 1
	/*EXEC pr_ChuyenCongTacBacSi @IdBacSi = 2, @IdBenhVienMoi = 1;
	SELECT HoTen, IdBenhVien FROM BacSi WHERE IdBacSi = 2;
	GO*/

-- 14. pr_TaoBaoCaoDinhKy: Tổng hợp số liệu vào bảng BaoCao
GO
CREATE OR ALTER PROC pr_TaoBaoCaoDinhKy
    @IdCanBo INT
AS
BEGIN
    DECLARE @SlBacSi INT, @SlBenhNhan INT;
    
    SELECT @SlBacSi = COUNT(*) FROM BacSi;
    SELECT @SlBenhNhan = COUNT(*) FROM BenhNhan;
    
    INSERT INTO BaoCao (NoiDung, LoaiBaoCao, NgayTaoBaoCao, IdCanBo)
    VALUES (
        N'Thống kê định kỳ: ' + CAST(@SlBacSi AS NVARCHAR) + N' bác sĩ, ' + 
        CAST(@SlBenhNhan AS NVARCHAR) + N' bệnh nhân.', 
        N'Tổng hợp', 
        GETDATE(), 
        @IdCanBo
    );

    PRINT N'Báo cáo đã được khởi tạo.';
END;
GO
	-- TEST CÂU 14:
	/*EXEC pr_TaoBaoCaoDinhKy @IdCanBo = 1;
	SELECT TOP 1 * FROM BaoCao ORDER BY IdBaoCao DESC;
	GO*/
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
ON DANHGIA
FOR INSERT, UPDATE
AS
BEGIN
    IF EXISTS(SELECT 1 FROM inserted WHERE DiemDanhGia<1 OR DiemDanhGia>5)
    BEGIN
        PRINT 'Điểm đánh giá phải nằm trong khoảng từ 1 đến 5 sao'
        ROLLBACK TRANSACTION;
    END
END
---demo insert 6 sao
INSERT INTO DanhGia (DiemDanhGia, NoiDung, NgayDanhGia, IdBacSi, IdBenhNhan) 
VALUES (6, N'Quá tốt', GETDATE(), 1, 1);
--2. TG_KiemTraTuoiHanhNghe: Kiểm tra ngày sinh của Bác sĩ khi thêm mới. 
--Đảm bảo bác sĩ phải đủ tuổi lao động hoặc tuổi hành nghề (ví dụ trên 24 tuổi) mới được lưu vào hệ thống.
GO
CREATE OR ALTER TRIGGER TG_KiemTraTuoiHanhNghe
ON BACSI
FOR INSERT, UPDATE
AS
BEGIN
    IF EXISTS(SELECT 1 FROM inserted WHERE DATEDIFF(YEAR,NGaySinh,GETDATE())<24)
    BEGIN
        PRINT'Bác sĩ phải từ 24 tuổi trở lên mới đủ điều kiện'
        ROLLBACK TRANSACTION;
    END
END
--- demo thêm bác sĩ sinh năm 2010
INSERT INTO BacSi (SoDienThoai, HoTen, NgaySinh, IdBenhVien, IdPhuongXa) 
VALUES ('0905123456', N'Bác sĩ Trẻ', '2010-01-01', 1, 1);
DELETE 
FROM BACSI
WHERE HoTen=N'Bác sĩ Trẻ'
--3. TG_CapNhatTrangThaiLich: Khi một lịch khám (Appointment) được tạo thành công, trigger này tự động cập nhật trạng thái khung giờ đó của bác sĩ từ "Trống" sang "Đã đặt" để người sau không tìm thấy khung giờ đó nữa.
IF OBJECT_ID(N'dbo.LichHen', N'U') IS NOT NULL
BEGIN
    EXEC(N'
    CREATE OR ALTER TRIGGER dbo.TG_CapNhatTrangThaiLich
    ON dbo.LichHen
    AFTER INSERT
    AS
    BEGIN
        SET NOCOUNT ON;

        IF EXISTS
        (
            SELECT 1
            FROM inserted i
            LEFT JOIN dbo.LichLamViec llv
              ON llv.IdBacSi = i.IdBacSi
             AND llv.NgayLamViec = i.NgayHen
             AND llv.KhungGio = i.KhungGio
             AND (i.IdPhong IS NULL OR llv.IdPhong = i.IdPhong)
             AND llv.TrangThai = N''Trống''
            WHERE llv.IdLichLamViec IS NULL
        )
        BEGIN
            THROW 51010, N''Khung giờ không còn trống hoặc không tồn tại trong lịch làm việc.'', 1;
        END

        UPDATE llv
        SET llv.TrangThai = N''Đã đặt''
        FROM dbo.LichLamViec llv
        JOIN inserted i
          ON llv.IdBacSi = i.IdBacSi
         AND llv.NgayLamViec = i.NgayHen
         AND llv.KhungGio = i.KhungGio
         AND (i.IdPhong IS NULL OR llv.IdPhong = i.IdPhong)
        WHERE llv.TrangThai = N''Trống'';
    END
    ');
END
ELSE
BEGIN
    PRINT N'Bỏ qua tạo TG_CapNhatTrangThaiLich vì chưa có bảng dbo.LichHen (Appointment).';
END
GO

--4. TG_TuDongTaoThongBao: Khi Cán bộ cập nhật thông tin Bệnh viện (như đổi địa chỉ hoặc hotline), trigger này tự động chèn một bản ghi vào bảng ThongBao cho tất cả Bác sĩ thuộc bệnh viện đó biết.
CREATE OR ALTER TRIGGER dbo.TG_TuDongTaoThongBao
ON dbo.BenhVien
AFTER UPDATE
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @IdCanBo INT = TRY_CONVERT(INT, SESSION_CONTEXT(N'IdCanBo'));

    -- Gom các bệnh viện có thay đổi thật sự vào bảng tạm
    DECLARE @Changed TABLE
    (
        IdBenhVien INT PRIMARY KEY,
        TenBenhVien NVARCHAR(200) NULL,

        OldDiaDiem NVARCHAR(255) NULL, NewDiaDiem NVARCHAR(255) NULL,
        OldHotLine VARCHAR(20)   NULL, NewHotLine VARCHAR(20)   NULL,
        OldEmail   VARCHAR(100)  NULL, NewEmail   VARCHAR(100)  NULL,
        OldMoTa    NVARCHAR(MAX) NULL, NewMoTa    NVARCHAR(MAX) NULL
    );

    INSERT INTO @Changed
    (
        IdBenhVien, TenBenhVien,
        OldDiaDiem, NewDiaDiem,
        OldHotLine, NewHotLine,
        OldEmail,   NewEmail,
        OldMoTa,    NewMoTa
    )
    SELECT
        i.IdBenhVien,
        i.TenBenhVien,
        d.DiaDiem,  i.DiaDiem,
        d.HotLine,  i.HotLine,
        d.Email,    i.Email,
        d.MoTa,     i.MoTa
    FROM inserted i
    JOIN deleted  d ON i.IdBenhVien = d.IdBenhVien
    WHERE
        ISNULL(i.DiaDiem, N'') <> ISNULL(d.DiaDiem, N'')
     OR ISNULL(i.HotLine, '')  <> ISNULL(d.HotLine, '')
     OR ISNULL(i.Email, '')    <> ISNULL(d.Email, '')
     OR ISNULL(i.MoTa, N'')    <> ISNULL(d.MoTa, N'');

    -- Không có thay đổi thì thoát
    IF NOT EXISTS (SELECT 1 FROM @Changed)
        RETURN;

    DECLARE @Map TABLE
    (
        IdBenhVien INT NOT NULL,
        IdThongBao INT NOT NULL
    );

    -- Tạo ThongBao: 1 bệnh viện đổi -> 1 thông báo
    MERGE dbo.ThongBao AS tgt
    USING
    (
        SELECT
            c.IdBenhVien,
            N'Cập nhật thông tin bệnh viện' AS TieuDe,
            CONCAT(
                N'Bệnh viện "', ISNULL(c.TenBenhVien, N''), N'" vừa được cập nhật.',
                N' DiaDiem: "', ISNULL(c.OldDiaDiem, N''), N'" -> "', ISNULL(c.NewDiaDiem, N''), N'".',
                N' HotLine: "', ISNULL(c.OldHotLine, ''),   N'" -> "', ISNULL(c.NewHotLine, ''),   N'".',
                N' Email: "',   ISNULL(c.OldEmail, ''),     N'" -> "', ISNULL(c.NewEmail, ''),     N'".'
            ) AS NoiDung,
            GETDATE() AS NgayGui,
            N'Bệnh viện' AS LoaiThongBao,
            @IdCanBo AS IdCanBo
        FROM @Changed c
    ) AS src
    ON 1 = 0
    WHEN NOT MATCHED THEN
        INSERT (TieuDe, NoiDung, NgayGui, LoaiThongBao, IdCanBo)
        VALUES (src.TieuDe, src.NoiDung, src.NgayGui, src.LoaiThongBao, src.IdCanBo)
    OUTPUT src.IdBenhVien, inserted.IdThongBao
    INTO @Map (IdBenhVien, IdThongBao);

    -- Gán thông báo cho tất cả bác sĩ thuộc bệnh viện đó
    INSERT INTO dbo.ThongBao_BacSi (IdBacSi, IdThongBao, NgayXem, TrangThaiXem)
    SELECT
        bs.IdBacSi,
        m.IdThongBao,
        NULL,
        N'Chưa xem'
    FROM @Map m
    JOIN dbo.BacSi bs ON bs.IdBenhVien = m.IdBenhVien;
END
GO
-- 5. TG_GhiLogTimKiem: Tự động tổng hợp từ khóa hot để phục vụ thống kê bác sĩ được quan tâm nhất.
IF OBJECT_ID('dbo.ThongKeTimKiem', 'U') IS NULL
BEGIN
    CREATE TABLE dbo.ThongKeTimKiem (
        TuKhoa NVARCHAR(255) PRIMARY KEY,
        SoLuotTim INT DEFAULT 0,
        NgayCapNhatCuoi DATETIME
    );
END
GO

CREATE OR ALTER TRIGGER dbo.TG_GhiLogTimKiem
ON dbo.TimKiem
AFTER INSERT
AS
BEGIN
    SET NOCOUNT ON;
    -- Cập nhật số lượt tìm kiếm cho từ khóa vừa chèn
    MERGE dbo.ThongKeTimKiem AS target
    USING (SELECT TuKhoaTK FROM inserted) AS source
    ON (target.TuKhoa = source.TuKhoaTK)
    WHEN MATCHED THEN
        UPDATE SET SoLuotTim = target.SoLuotTim + 1, NgayCapNhatCuoi = GETDATE()
    WHEN NOT MATCHED THEN
        INSERT (TuKhoa, SoLuotTim, NgayCapNhatCuoi)
        VALUES (source.TuKhoaTK, 1, GETDATE());
END
GO
	--TEST
	/*INSERT INTO dbo.TimKiem (TuKhoaTK, ThoiGianTK, ViTriTimKiem, IdBenhNhan) 
	VALUES (N'Bác sĩ Bửu', GETDATE(), N'Đà Nẵng', 1);

	SELECT * FROM dbo.ThongKeTimKiem; -- Kiểm tra số lượt tìm tăng lên 1*/

-- 6. TG_LuuLichSuThayDoiThongTin: Lưu vết thay đổi SĐT hoặc Email của Bác sĩ vào bảng Log_Changes.
IF OBJECT_ID('dbo.Log_Changes', 'U') IS NULL
BEGIN
    CREATE TABLE dbo.Log_Changes (
        IdLog INT IDENTITY PRIMARY KEY,
        LoaiDoiTuong NVARCHAR(50), -- 'BACSI'
        IdDoiTuong INT,
        TenCot NVARCHAR(50),
        GiaTriCu NVARCHAR(MAX),
        GiaTriMoi NVARCHAR(MAX),
        NgayThayDoi DATETIME DEFAULT GETDATE(),
        NguoiThucHien NVARCHAR(100)
    );
END
GO

CREATE OR ALTER TRIGGER dbo.TG_LuuLichSuThayDoiThongTin
ON dbo.BacSi
AFTER UPDATE
AS
BEGIN
    SET NOCOUNT ON;

    -- Lưu lịch sử nếu đổi Số điện thoại
    IF UPDATE(SoDienThoai)
    BEGIN
        INSERT INTO dbo.Log_Changes (LoaiDoiTuong, IdDoiTuong, TenCot, GiaTriCu, GiaTriMoi, NguoiThucHien)
        SELECT N'BACSI', i.IdBacSi, N'SoDienThoai', d.SoDienThoai, i.SoDienThoai, SUSER_NAME()
        FROM inserted i JOIN deleted d ON i.IdBacSi = d.IdBacSi
        WHERE i.SoDienThoai <> d.SoDienThoai;
    END

    -- Lưu lịch sử nếu đổi Email
    IF UPDATE(Email)
    BEGIN
        INSERT INTO dbo.Log_Changes (LoaiDoiTuong, IdDoiTuong, TenCot, GiaTriCu, GiaTriMoi, NguoiThucHien)
        SELECT N'BACSI', i.IdBacSi, N'Email', d.Email, i.Email, SUSER_NAME()
        FROM inserted i JOIN deleted d ON i.IdBacSi = d.IdBacSi
        WHERE i.Email <> d.Email;
    END
END
GO
	--TEST
	/*UPDATE dbo.BacSi 
	SET SoDienThoai = '0123444559', Email = 'new_email@gmail.com' 
	WHERE IdBacSi = 1;

	SELECT * FROM dbo.Log_Changes; -- Kiểm tra bản ghi log cũ và mới*/
