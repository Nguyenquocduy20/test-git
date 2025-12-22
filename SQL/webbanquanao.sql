-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:3306
-- Generation Time: Dec 22, 2025 at 02:08 PM
-- Server version: 9.1.0
-- PHP Version: 8.3.14

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `webbanquanao`
--

-- --------------------------------------------------------

--
-- Table structure for table `chitietdonhang`
--

DROP TABLE IF EXISTS `chitietdonhang`;
CREATE TABLE IF NOT EXISTS `chitietdonhang` (
  `MaChiTietDonHang` bigint NOT NULL AUTO_INCREMENT,
  `MaDonHang` bigint NOT NULL,
  `MaChiTietSP` bigint NOT NULL,
  `SoLuong` int NOT NULL,
  `DonGia` decimal(18,2) NOT NULL,
  PRIMARY KEY (`MaChiTietDonHang`),
  KEY `MaDonHang` (`MaDonHang`),
  KEY `MaChiTietSP` (`MaChiTietSP`)
) ;

--
-- Dumping data for table `chitietdonhang`
--

INSERT INTO `chitietdonhang` (`MaChiTietDonHang`, `MaDonHang`, `MaChiTietSP`, `SoLuong`, `DonGia`) VALUES
(1, 1, 1, 1, 200000.00),
(2, 1, 5, 1, 450000.00);

-- --------------------------------------------------------

--
-- Table structure for table `chitietgiohang`
--

DROP TABLE IF EXISTS `chitietgiohang`;
CREATE TABLE IF NOT EXISTS `chitietgiohang` (
  `MaChiTietGioHang` bigint NOT NULL AUTO_INCREMENT,
  `MaGioHang` bigint NOT NULL,
  `MaChiTietSP` bigint NOT NULL,
  `SoLuong` int NOT NULL,
  PRIMARY KEY (`MaChiTietGioHang`),
  UNIQUE KEY `UQ_GioHang_SP` (`MaGioHang`,`MaChiTietSP`),
  KEY `MaChiTietSP` (`MaChiTietSP`)
) ;

-- --------------------------------------------------------

--
-- Table structure for table `chitietsanpham`
--

DROP TABLE IF EXISTS `chitietsanpham`;
CREATE TABLE IF NOT EXISTS `chitietsanpham` (
  `MaChiTietSP` bigint NOT NULL AUTO_INCREMENT,
  `MaSanPham` bigint NOT NULL,
  `MaMau` int NOT NULL,
  `MaSize` int NOT NULL,
  `SoLuongTon` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`MaChiTietSP`),
  UNIQUE KEY `UQ_Variant` (`MaSanPham`,`MaMau`,`MaSize`),
  KEY `MaMau` (`MaMau`),
  KEY `MaSize` (`MaSize`)
) ;

--
-- Dumping data for table `chitietsanpham`
--

INSERT INTO `chitietsanpham` (`MaChiTietSP`, `MaSanPham`, `MaMau`, `MaSize`, `SoLuongTon`) VALUES
(1, 1, 1, 1, 50),
(2, 1, 1, 2, 30),
(3, 1, 2, 1, 40),
(4, 1, 2, 2, 0),
(5, 2, 1, 2, 20);

-- --------------------------------------------------------

--
-- Table structure for table `danhgia`
--

DROP TABLE IF EXISTS `danhgia`;
CREATE TABLE IF NOT EXISTS `danhgia` (
  `MaDanhGia` bigint NOT NULL AUTO_INCREMENT,
  `MaSanPham` bigint NOT NULL,
  `MaKhachHang` bigint NOT NULL,
  `Diem` int NOT NULL,
  `NoiDung` text,
  `NgayTao` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`MaDanhGia`),
  KEY `MaSanPham` (`MaSanPham`),
  KEY `MaKhachHang` (`MaKhachHang`)
) ;

--
-- Dumping data for table `danhgia`
--

INSERT INTO `danhgia` (`MaDanhGia`, `MaSanPham`, `MaKhachHang`, `Diem`, `NoiDung`, `NgayTao`) VALUES
(1, 1, 1, 5, 'Áo mặc mát, vải đẹp.', '2025-12-07 22:20:40');

-- --------------------------------------------------------

--
-- Table structure for table `danhmucsanpham`
--

DROP TABLE IF EXISTS `danhmucsanpham`;
CREATE TABLE IF NOT EXISTS `danhmucsanpham` (
  `MaDanhMuc` bigint NOT NULL AUTO_INCREMENT,
  `TenDanhMuc` varchar(100) NOT NULL,
  `MaDanhMucCha` bigint DEFAULT NULL,
  `MoTa` text,
  PRIMARY KEY (`MaDanhMuc`),
  UNIQUE KEY `TenDanhMuc` (`TenDanhMuc`),
  KEY `MaDanhMucCha` (`MaDanhMucCha`)
) ENGINE=InnoDB AUTO_INCREMENT=51 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `danhmucsanpham`
--

INSERT INTO `danhmucsanpham` (`MaDanhMuc`, `TenDanhMuc`, `MaDanhMucCha`, `MoTa`) VALUES
(1, 'Gu', NULL, 'GU'),
(2, 'Áo', NULL, 'ÁO'),
(3, 'Quần', NULL, 'Quần'),
(4, 'Gu đơn giản', 1, 'GU'),
(5, 'Gu thiết kế', 1, 'GU'),
(6, 'Gu thể thao', 1, 'GU'),
(7, 'Trạm thiết yếu', 4, 'Gu đơn giản'),
(8, 'Trạm Jean', 4, 'Gu đơn giản'),
(9, 'Trạm Công nghệ', 4, 'Gu đơn giản'),
(15, 'Nonbrand', 7, 'Con của trạm thiết yếu'),
(16, 'Seventy Seven', 7, 'Con của trạm thiết yếu'),
(17, 'The Worker', 7, 'Con của trạm thiết yếu'),
(29, 'Áo Thun', 2, 'Con của áo'),
(30, 'Áo sơ mi', 2, 'Con của áo'),
(31, 'Áo khoác', 2, 'Con của áo'),
(32, 'Áo Thun cổ tròn', 29, 'Con của áo thun'),
(33, 'Áo polo', 29, 'Con của áo thun'),
(46, 'Quần short', 3, 'Con của quần'),
(47, 'Quần dài', 3, 'Con của quần'),
(48, 'Quần Jean', 3, 'Con của quần'),
(49, 'Quần lót', 3, 'Con của quần'),
(50, 'Quần short thun', 46, 'Con của quần short');

-- --------------------------------------------------------

--
-- Table structure for table `donhang`
--

DROP TABLE IF EXISTS `donhang`;
CREATE TABLE IF NOT EXISTS `donhang` (
  `MaDonHang` bigint NOT NULL AUTO_INCREMENT,
  `MaKhachHang` bigint NOT NULL,
  `MaNhanVien` bigint DEFAULT NULL,
  `MaKhuyenMai` bigint DEFAULT NULL,
  `NgayDatHang` datetime DEFAULT CURRENT_TIMESTAMP,
  `TongTien` decimal(18,2) NOT NULL,
  `TrangThai` varchar(50) NOT NULL DEFAULT 'Chờ xử lý',
  `DiaChiGiaoHang` varchar(255) NOT NULL,
  `GhiChu` text,
  PRIMARY KEY (`MaDonHang`),
  KEY `MaKhachHang` (`MaKhachHang`),
  KEY `MaNhanVien` (`MaNhanVien`),
  KEY `MaKhuyenMai` (`MaKhuyenMai`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `donhang`
--

INSERT INTO `donhang` (`MaDonHang`, `MaKhachHang`, `MaNhanVien`, `MaKhuyenMai`, `NgayDatHang`, `TongTien`, `TrangThai`, `DiaChiGiaoHang`, `GhiChu`) VALUES
(1, 1, NULL, 1, '2025-12-07 22:20:40', 585000.00, 'Chờ xác nhận', '123 CMT8, HCM', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `giohang`
--

DROP TABLE IF EXISTS `giohang`;
CREATE TABLE IF NOT EXISTS `giohang` (
  `MaGioHang` bigint NOT NULL AUTO_INCREMENT,
  `MaKhachHang` bigint NOT NULL,
  `NgayTao` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`MaGioHang`),
  KEY `MaKhachHang` (`MaKhachHang`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `hinhanhsanpham`
--

DROP TABLE IF EXISTS `hinhanhsanpham`;
CREATE TABLE IF NOT EXISTS `hinhanhsanpham` (
  `MaHinhAnh` bigint NOT NULL AUTO_INCREMENT,
  `MaSanPham` bigint NOT NULL,
  `UrlHinhAnh` varchar(255) NOT NULL,
  `LaAnhChinh` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`MaHinhAnh`),
  KEY `MaSanPham` (`MaSanPham`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `khachhang`
--

DROP TABLE IF EXISTS `khachhang`;
CREATE TABLE IF NOT EXISTS `khachhang` (
  `MaKhachHang` bigint NOT NULL AUTO_INCREMENT,
  `Ten` varchar(100) NOT NULL,
  `Email` varchar(100) DEFAULT NULL,
  `SoDienThoai` varchar(15) DEFAULT NULL,
  `DiaChi` varchar(255) DEFAULT NULL,
  `MaTaiKhoan` bigint NOT NULL,
  `TrangThai` varchar(50) DEFAULT 'Active',
  `Hang` varchar(50) DEFAULT 'Member',
  PRIMARY KEY (`MaKhachHang`),
  UNIQUE KEY `MaTaiKhoan` (`MaTaiKhoan`),
  UNIQUE KEY `Email` (`Email`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `khachhang`
--

INSERT INTO `khachhang` (`MaKhachHang`, `Ten`, `Email`, `SoDienThoai`, `DiaChi`, `MaTaiKhoan`, `TrangThai`, `Hang`) VALUES
(1, 'Nguyễn Văn A', 'nva@gmail.com', '0912000001', '123 CMT8, HCM', 3, 'Active', 'Member'),
(2, 'Lê Thị B', 'ltb@gmail.com', '0912000002', '456 Nguyễn Trãi, HCM', 4, 'Active', 'Member'),
(3, 'NguyenQuocDuy', 'duy11@gmail.com', '0721862124', '3c cao lỗ', 1, 'Active', 'Silver');

-- --------------------------------------------------------

--
-- Table structure for table `khuyenmai`
--

DROP TABLE IF EXISTS `khuyenmai`;
CREATE TABLE IF NOT EXISTS `khuyenmai` (
  `MaKhuyenMai` bigint NOT NULL AUTO_INCREMENT,
  `TenKhuyenMai` varchar(100) NOT NULL,
  `GiaTriGiam` decimal(10,2) NOT NULL,
  `NgayBatDau` datetime NOT NULL,
  `NgayKetThuc` datetime NOT NULL,
  PRIMARY KEY (`MaKhuyenMai`)
) ;

--
-- Dumping data for table `khuyenmai`
--

INSERT INTO `khuyenmai` (`MaKhuyenMai`, `TenKhuyenMai`, `GiaTriGiam`, `NgayBatDau`, `NgayKetThuc`) VALUES
(1, 'SALE KHAI TRƯƠNG', 10.00, '2025-12-07 22:20:40', '2026-01-06 22:20:40'),
(4, 'SALE SAP SAN', 30.00, '2025-12-16 00:00:00', '2025-12-23 00:00:00');

-- --------------------------------------------------------

--
-- Table structure for table `kichthuoc`
--

DROP TABLE IF EXISTS `kichthuoc`;
CREATE TABLE IF NOT EXISTS `kichthuoc` (
  `MaSize` int NOT NULL AUTO_INCREMENT,
  `TenSize` varchar(20) NOT NULL,
  PRIMARY KEY (`MaSize`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `kichthuoc`
--

INSERT INTO `kichthuoc` (`MaSize`, `TenSize`) VALUES
(1, 'M'),
(2, 'L'),
(3, 'XL'),
(4, 'XXL');

-- --------------------------------------------------------

--
-- Table structure for table `mausac`
--

DROP TABLE IF EXISTS `mausac`;
CREATE TABLE IF NOT EXISTS `mausac` (
  `MaMau` int NOT NULL AUTO_INCREMENT,
  `TenMau` varchar(50) NOT NULL,
  `MaHex` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`MaMau`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `mausac`
--

INSERT INTO `mausac` (`MaMau`, `TenMau`, `MaHex`) VALUES
(1, 'Đen', '#000000'),
(2, 'Trắng', '#FFFFFF'),
(3, 'Đỏ', '#FF0000');

-- --------------------------------------------------------

--
-- Table structure for table `nhanvien`
--

DROP TABLE IF EXISTS `nhanvien`;
CREATE TABLE IF NOT EXISTS `nhanvien` (
  `MaNhanVien` bigint NOT NULL AUTO_INCREMENT,
  `Ten` varchar(100) NOT NULL,
  `Email` varchar(100) DEFAULT NULL,
  `SoDienThoai` varchar(15) DEFAULT NULL,
  `ChucVu` varchar(50) DEFAULT NULL,
  `MaTaiKhoan` bigint NOT NULL,
  `PhongBan` varchar(100) DEFAULT 'Bán lẻ',
  `NgayVaoLam` date DEFAULT NULL,
  `TrangThai` varchar(50) DEFAULT 'Đang làm việc',
  PRIMARY KEY (`MaNhanVien`),
  UNIQUE KEY `MaTaiKhoan` (`MaTaiKhoan`),
  UNIQUE KEY `Email` (`Email`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `nhanvien`
--

INSERT INTO `nhanvien` (`MaNhanVien`, `Ten`, `Email`, `SoDienThoai`, `ChucVu`, `MaTaiKhoan`, `PhongBan`, `NgayVaoLam`, `TrangThai`) VALUES
(1, 'Nguyễn Quản Lý', 'quanly@shop.vn', '0909111222', 'Thủ Kho', 1, 'Bán lẻ', '2025-12-03', 'Đang làm việc'),
(2, 'Trần Bán Hàng', 'banhang@shop.vn', '0909333444', 'Sale Online', 2, 'Bán lẻ', '2025-12-03', 'Đang làm việc'),
(7, 'Nguyen Quoc Du', 'an123@gmail.com', '0721862124', 'Tổng kho', 6, 'Kho vận', '2025-12-21', 'Đang làm việc'),
(8, 'Nguyen Quoc Duy', 'duy123@gmail.com', '0721862124', 'Tổng kho', 7, 'Bán lẻ', '2025-12-09', 'Đang làm việc');

-- --------------------------------------------------------

--
-- Table structure for table `sanpham`
--

DROP TABLE IF EXISTS `sanpham`;
CREATE TABLE IF NOT EXISTS `sanpham` (
  `MaSanPham` bigint NOT NULL AUTO_INCREMENT,
  `MaDanhMuc` bigint NOT NULL,
  `TenSanPham` varchar(200) NOT NULL,
  `GiaGoc` decimal(18,2) NOT NULL,
  `MoTa` text,
  `ChatLieu` varchar(100) DEFAULT NULL,
  `AnhDaiDien` varchar(255) DEFAULT NULL,
  `TrangThai` tinyint(1) DEFAULT '1',
  `NgayTao` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`MaSanPham`),
  KEY `MaDanhMuc` (`MaDanhMuc`)
) ;

--
-- Dumping data for table `sanpham`
--

INSERT INTO `sanpham` (`MaSanPham`, `MaDanhMuc`, `TenSanPham`, `GiaGoc`, `MoTa`, `ChatLieu`, `AnhDaiDien`, `TrangThai`, `NgayTao`) VALUES
(1, 3, 'ao_thun_xanh', 270000.00, 'ÃÂÃÂÃÂÃÂo thun local brand.', '', 'aotk1.png', 1, '2025-12-07 22:20:40'),
(2, 1, 'Quần Jean Rách Gối', 450000.00, 'Quần jean phong cách bụi bặm.', NULL, 'quanjeans.png', 1, NULL),
(14, 3, 'aotaydai', 180000.00, 'a', NULL, '1765559219830_ao-khoac-no-style-m44-xanh-d-ng-1174885229.png', 1, '2025-12-13 00:06:38'),
(18, 2, 'ao_dep', 215000.00, 'aaa', NULL, '1766245321300_ao-khoac-no-style-m44-xanh-d-ng-1174885229.png', 1, '2025-12-20 22:42:01');

-- --------------------------------------------------------

--
-- Table structure for table `taikhoan`
--

DROP TABLE IF EXISTS `taikhoan`;
CREATE TABLE IF NOT EXISTS `taikhoan` (
  `MaTaiKhoan` bigint NOT NULL AUTO_INCREMENT,
  `TenDangNhap` varchar(50) NOT NULL,
  `MatKhau` varchar(255) NOT NULL,
  `VaiTro` varchar(20) NOT NULL,
  `NgayTao` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`MaTaiKhoan`),
  UNIQUE KEY `TenDangNhap` (`TenDangNhap`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `taikhoan`
--

INSERT INTO `taikhoan` (`MaTaiKhoan`, `TenDangNhap`, `MatKhau`, `VaiTro`, `NgayTao`) VALUES
(1, 'admin', '123456', 'Admin', '2025-12-07 22:20:40'),
(2, 'nhanvien_kho', '123456', 'NhanVien', '2025-12-07 22:20:40'),
(3, 'khach_hang_a', '123456', 'KhachHang', '2025-12-07 22:20:40'),
(4, 'khach_hang_b', '123456', 'KhachHang', '2025-12-07 22:20:40'),
(6, 'an123@gmail.com', '123456', 'NhanVien', '2025-12-21 21:55:21'),
(7, 'duy123@gmail.com', 'LOCKED_1766330789291', 'NhanVien', '2025-12-21 22:22:11');

--
-- Constraints for dumped tables
--

--
-- Constraints for table `chitietdonhang`
--
ALTER TABLE `chitietdonhang`
  ADD CONSTRAINT `chitietdonhang_ibfk_1` FOREIGN KEY (`MaDonHang`) REFERENCES `donhang` (`MaDonHang`),
  ADD CONSTRAINT `chitietdonhang_ibfk_2` FOREIGN KEY (`MaChiTietSP`) REFERENCES `chitietsanpham` (`MaChiTietSP`);

--
-- Constraints for table `chitietgiohang`
--
ALTER TABLE `chitietgiohang`
  ADD CONSTRAINT `chitietgiohang_ibfk_1` FOREIGN KEY (`MaGioHang`) REFERENCES `giohang` (`MaGioHang`),
  ADD CONSTRAINT `chitietgiohang_ibfk_2` FOREIGN KEY (`MaChiTietSP`) REFERENCES `chitietsanpham` (`MaChiTietSP`);

--
-- Constraints for table `chitietsanpham`
--
ALTER TABLE `chitietsanpham`
  ADD CONSTRAINT `chitietsanpham_ibfk_1` FOREIGN KEY (`MaSanPham`) REFERENCES `sanpham` (`MaSanPham`),
  ADD CONSTRAINT `chitietsanpham_ibfk_2` FOREIGN KEY (`MaMau`) REFERENCES `mausac` (`MaMau`),
  ADD CONSTRAINT `chitietsanpham_ibfk_3` FOREIGN KEY (`MaSize`) REFERENCES `kichthuoc` (`MaSize`);

--
-- Constraints for table `danhgia`
--
ALTER TABLE `danhgia`
  ADD CONSTRAINT `danhgia_ibfk_1` FOREIGN KEY (`MaSanPham`) REFERENCES `sanpham` (`MaSanPham`),
  ADD CONSTRAINT `danhgia_ibfk_2` FOREIGN KEY (`MaKhachHang`) REFERENCES `khachhang` (`MaKhachHang`);

--
-- Constraints for table `danhmucsanpham`
--
ALTER TABLE `danhmucsanpham`
  ADD CONSTRAINT `danhmucsanpham_ibfk_1` FOREIGN KEY (`MaDanhMucCha`) REFERENCES `danhmucsanpham` (`MaDanhMuc`);

--
-- Constraints for table `donhang`
--
ALTER TABLE `donhang`
  ADD CONSTRAINT `donhang_ibfk_1` FOREIGN KEY (`MaKhachHang`) REFERENCES `khachhang` (`MaKhachHang`),
  ADD CONSTRAINT `donhang_ibfk_2` FOREIGN KEY (`MaNhanVien`) REFERENCES `nhanvien` (`MaNhanVien`),
  ADD CONSTRAINT `donhang_ibfk_3` FOREIGN KEY (`MaKhuyenMai`) REFERENCES `khuyenmai` (`MaKhuyenMai`);

--
-- Constraints for table `giohang`
--
ALTER TABLE `giohang`
  ADD CONSTRAINT `giohang_ibfk_1` FOREIGN KEY (`MaKhachHang`) REFERENCES `khachhang` (`MaKhachHang`);

--
-- Constraints for table `hinhanhsanpham`
--
ALTER TABLE `hinhanhsanpham`
  ADD CONSTRAINT `hinhanhsanpham_ibfk_1` FOREIGN KEY (`MaSanPham`) REFERENCES `sanpham` (`MaSanPham`);

--
-- Constraints for table `khachhang`
--
ALTER TABLE `khachhang`
  ADD CONSTRAINT `khachhang_ibfk_1` FOREIGN KEY (`MaTaiKhoan`) REFERENCES `taikhoan` (`MaTaiKhoan`);

--
-- Constraints for table `nhanvien`
--
ALTER TABLE `nhanvien`
  ADD CONSTRAINT `nhanvien_ibfk_1` FOREIGN KEY (`MaTaiKhoan`) REFERENCES `taikhoan` (`MaTaiKhoan`);

--
-- Constraints for table `sanpham`
--
ALTER TABLE `sanpham`
  ADD CONSTRAINT `sanpham_ibfk_1` FOREIGN KEY (`MaDanhMuc`) REFERENCES `danhmucsanpham` (`MaDanhMuc`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
