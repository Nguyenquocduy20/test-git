package model;

import java.util.List;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.OneToMany;
import javax.persistence.Table;

@Entity
@Table(name = "khachhang")
public class KhachHang {
    
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "MaKhachHang")
    private Long maKhachHang;
    
    @Column(name = "Ten")
    private String ten;
    
    @Column(name = "Email")
    private String email;
    
    @Column(name = "SoDienThoai")
    private String soDienThoai;
    
    @Column(name = "DiaChi")
    private String diaChi;
    
    @Column(name = "MaTaiKhoan")
    private Long maTaiKhoan;
    @Column(name = "TrangThai")
    private String trangThai = "Active";
    @Column(name = "Hang")
    private String hang = "Member";
    
    public String getHang() {
		return hang;
	}

	public void setHang(String hang) {
		this.hang = hang;
	}

	public String getTrangThai() {
		return trangThai;
	}

	public void setTrangThai(String trangThai) {
		this.trangThai = trangThai;
	}

	// Constructor rỗng (BẮT BUỘC cho JPA)
    public KhachHang() {}

    // --- GETTERS VÀ SETTERS ---

    public Long getMaKhachHang() {
        return maKhachHang;
    }

    public void setMaKhachHang(Long maKhachHang) {
        this.maKhachHang = maKhachHang;
    }

    public String getTen() {
        return ten;
    }

    public void setTen(String ten) {
        this.ten = ten;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getSoDienThoai() {
        return soDienThoai;
    }

    public void setSoDienThoai(String soDienThoai) {
        this.soDienThoai = soDienThoai;
    }

    public String getDiaChi() {
        return diaChi;
    }

    public void setDiaChi(String diaChi) {
        this.diaChi = diaChi;
    }

    public Long getMaTaiKhoan() {
        return maTaiKhoan;
    }

    public void setMaTaiKhoan(Long maTaiKhoan) {
        this.maTaiKhoan = maTaiKhoan;
    }
    @OneToMany(mappedBy = "khachHang", fetch = FetchType.LAZY)
    private List<DonHang> danhSachDonHang;
    // Hàm tính toán để dùng trên JSP
    public double getTongChiTieu() {
        if (danhSachDonHang == null || danhSachDonHang.isEmpty()) return 0;
        return danhSachDonHang.stream()
            .filter(dh -> dh.getTongTien() != null) // Loại bỏ đơn hàng không có tiền
            .mapToDouble(dh -> dh.getTongTien().doubleValue()) // Chuyển BigDecimal sang double
            .sum();
    }
    public int getSoDonHang() {
        return (danhSachDonHang != null) ? danhSachDonHang.size() : 0;
    }
}