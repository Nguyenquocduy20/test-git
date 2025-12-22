package model;

import java.util.Date;
import javax.persistence.*;

@Entity
@Table(name = "nhanvien")
public class NhanVien {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "MaNhanVien")
    private Long maNhanVien;

    @Column(name = "Ten")
    private String hoTen;

    @Column(name = "Email")
    private String email;

    @Column(name = "SoDienThoai")
    private String soDienThoai;

    @Column(name = "ChucVu")
    private String chucVu;

    @Column(name = "PhongBan")
    private String phongBan;

    @Column(name = "NgayVaoLam")
    @Temporal(TemporalType.DATE)
    private Date ngayVaoLam;

    @Column(name = "TrangThai")
    private String trangThai;

    @Column(name = "MaTaiKhoan")
    private Long maTaiKhoan;

   
    public NhanVien() {
        this.ngayVaoLam = new Date();
        this.trangThai = "Đang làm việc";
        this.phongBan = "Bán lẻ";
    }


	public Long getMaNhanVien() {
		return maNhanVien;
	}


	public void setMaNhanVien(Long maNhanVien) {
		this.maNhanVien = maNhanVien;
	}


	public String getHoTen() {
		return hoTen;
	}


	public void setHoTen(String hoTen) {
		this.hoTen = hoTen;
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


	public String getChucVu() {
		return chucVu;
	}


	public void setChucVu(String chucVu) {
		this.chucVu = chucVu;
	}


	public String getPhongBan() {
		return phongBan;
	}


	public void setPhongBan(String phongBan) {
		this.phongBan = phongBan;
	}


	public Date getNgayVaoLam() {
		return ngayVaoLam;
	}


	public void setNgayVaoLam(Date ngayVaoLam) {
		this.ngayVaoLam = ngayVaoLam;
	}


	public String getTrangThai() {
		return trangThai;
	}


	public void setTrangThai(String trangThai) {
		this.trangThai = trangThai;
	}


	public Long getMaTaiKhoan() {
		return maTaiKhoan;
	}


	public void setMaTaiKhoan(Long maTaiKhoan) {
		this.maTaiKhoan = maTaiKhoan;
	}
    
   
}