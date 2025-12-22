package model;

import javax.persistence.Column;
import javax.persistence.Entity; // Thêm dòng này
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table; // Thêm dòng này
import javax.persistence.Transient;

@Entity // BẮT BUỘC CÓ
@Table(name = "chitietdonhang") // BẮT BUỘC CÓ (Tên phải khớp 100% với bảng trong MySQL)
public class ChiTietDonHang {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "MaChiTietDonHang")
    private Long maChiTiet;

    @Column(name = "MaDonHang")
    private Long maDonHang;

    @Column(name = "MaChiTietSP")
    private Long maChiTietSP;

    @Column(name = "SoLuong")
    private Integer soLuong;

    @Column(name = "DonGia")
    private Double donGia;

    @Transient
    private String tenSanPham;



	public Long getMaChiTiet() {
		return maChiTiet;
	}

	public void setMaChiTiet(Long maChiTiet) {
		this.maChiTiet = maChiTiet;
	}

	public Long getMaDonHang() {
		return maDonHang;
	}

	public void setMaDonHang(Long maDonHang) {
		this.maDonHang = maDonHang;
	}

	public Long getMaChiTietSP() {
		return maChiTietSP;
	}

	public void setMaChiTietSP(Long maChiTietSP) {
		this.maChiTietSP = maChiTietSP;
	}

	public Integer getSoLuong() {
		return soLuong;
	}

	public void setSoLuong(Integer soLuong) {
		this.soLuong = soLuong;
	}

	public Double getDonGia() {
		return donGia;
	}

	public void setDonGia(Double donGia) {
		this.donGia = donGia;
	}

	public String getTenSanPham() {
		return tenSanPham;
	}

	public void setTenSanPham(String tenSanPham) {
		this.tenSanPham = tenSanPham;
	}
    
}
