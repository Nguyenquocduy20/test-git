package model;

import java.math.BigDecimal;
import java.sql.Timestamp;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;
import javax.persistence.Transient;

@Entity
@Table(name = "donhang")
public class DonHang {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "MaDonHang")
    private Long maDonHang;

    // QUAN TRỌNG: Thêm insertable/updatable = false để không xung đột với đối tượng khachHang bên dưới
    @Column(name = "MaKhachHang", insertable = false, updatable = false)
    private Long maKhachHang; 

    @Column(name = "MaNhanVien")
    private Long maNhanVien;

    @Column(name = "MaKhuyenMai")
    private Long maKhuyenMai;

    @Column(name = "NgayDatHang")
    private Timestamp ngayDatHang;

    @Column(name = "TongTien")
    private BigDecimal tongTien;

    @Column(name = "TrangThai")
    private String trangThai;

    @Column(name = "DiaChiGiaoHang")
    private String diaChiGiaoHang;

    @Column(name = "GhiChu")
    private String ghiChu;

    @Transient 
    private String tenKhachHang; 
    
    @Transient
    private String soDienThoaiKhachHang;
  
    // ÁNH XẠ QUAN HỆ SANG MODEL KHACHHANG
    @ManyToOne
    @JoinColumn(name = "MaKhachHang") 
    private KhachHang khachHang;

    // Constructor mặc định
    public DonHang() {}

    // --- TẤT CẢ GETTER VÀ SETTER ---

    public Long getMaDonHang() {
        return maDonHang;
    }

    public void setMaDonHang(Long maDonHang) {
        this.maDonHang = maDonHang;
    }

    public Long getMaKhachHang() {
        return maKhachHang;
    }

    public void setMaKhachHang(Long maKhachHang) {
        this.maKhachHang = maKhachHang;
    }

    public Long getMaNhanVien() {
        return maNhanVien;
    }

    public void setMaNhanVien(Long maNhanVien) {
        this.maNhanVien = maNhanVien;
    }

    public Long getMaKhuyenMai() {
        return maKhuyenMai;
    }

    public void setMaKhuyenMai(Long maKhuyenMai) {
        this.maKhuyenMai = maKhuyenMai;
    }

    public Timestamp getNgayDatHang() {
        return ngayDatHang;
    }

    public void setNgayDatHang(Timestamp ngayDatHang) {
        this.ngayDatHang = ngayDatHang;
    }

    public BigDecimal getTongTien() {
        // Tránh lỗi NullPointerException khi thực hiện tính toán ở Stream
        return (tongTien != null) ? tongTien : BigDecimal.ZERO;
    }

    public void setTongTien(BigDecimal tongTien) {
        this.tongTien = tongTien;
    }

    public String getTrangThai() {
        return trangThai;
    }

    public void setTrangThai(String trangThai) {
        this.trangThai = trangThai;
    }

    public String getDiaChiGiaoHang() {
        return diaChiGiaoHang;
    }

    public void setDiaChiGiaoHang(String diaChiGiaoHang) {
        this.diaChiGiaoHang = diaChiGiaoHang;
    }

    public String getGhiChu() {
        return ghiChu;
    }

    public void setGhiChu(String ghiChu) {
        this.ghiChu = ghiChu;
    }

    public String getTenKhachHang() {
        return tenKhachHang;
    }

    public void setTenKhachHang(String tenKhachHang) {
        this.tenKhachHang = tenKhachHang;
    }

    public String getSoDienThoaiKhachHang() {
        return soDienThoaiKhachHang;
    }

    public void setSoDienThoaiKhachHang(String soDienThoaiKhachHang) {
        this.soDienThoaiKhachHang = soDienThoaiKhachHang;
    }

    public KhachHang getKhachHang() {
        return khachHang;
    }

    public void setKhachHang(KhachHang khachHang) {
        this.khachHang = khachHang;
    }
}