package model;

import java.io.Serializable;
import java.math.BigDecimal;
import java.util.Date;
import javax.persistence.*;

import util.HypernateUtil;

@Entity
@Table(name = "SanPham")
@SqlResultSetMapping(
    name = "SanPhamWithStockMapping",
    entities = @EntityResult(
        entityClass = SanPham.class,
        fields = {
            @FieldResult(name = "maSanPham", column = "MaSanPham"),
            @FieldResult(name = "maDanhMuc", column = "MaDanhMuc"),
            @FieldResult(name = "tenSanPham", column = "TenSanPham"),
            @FieldResult(name = "giaGoc", column = "GiaGoc"),
            @FieldResult(name = "moTa", column = "MoTa"),
            @FieldResult(name = "chatLieu", column = "ChatLieu"),
            @FieldResult(name = "anhDaiDien", column = "AnhDaiDien"),
            @FieldResult(name = "trangThai", column = "TrangThai"),
            @FieldResult(name = "ngayTao", column = "NgayTao")
        }
    ),
    columns = {
        @ColumnResult(name = "tongSoLuongTon", type = Integer.class)
    }
)// Ánh xạ với tên bảng SanPham
public class SanPham implements Serializable {
    private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY) // Khóa chính tự tăng
    @Column(name = "MaSanPham")
    private Long maSanPham;

    @Column(name = "MaDanhMuc")
    private Long maDanhMuc;
    
    // Thuộc tính không nằm trong bảng, chỉ dùng để hiển thị (từ JOIN)
    @Transient 
    private String tenDanhMuc; 
    
    @Transient
    private int tongSoLuongTon;
    
    @Column(name = "TenSanPham", nullable = false)
    private String tenSanPham;

    @Column(name = "GiaGoc", nullable = false)
    private BigDecimal giaGoc;

    @Column(name = "MoTa", columnDefinition = "TEXT")
    private String moTa;
    
    @Column(name = "ChatLieu")
    private String chatLieu;

    @Column(name = "AnhDaiDien")
    private String anhDaiDien;

    @Column(name = "TrangThai")
    private int trangThai; // TINYINT(1) trong MySQL thường ánh xạ thành int/Boolean

    @Column(name = "NgayTao")
    @Temporal(TemporalType.TIMESTAMP) // Xử lý kiểu DATETIME
    private Date ngayTao;

    // Thuộc tính không nằm trong bảng, dùng để lưu tổng tồn kho (từ SUM)
    
	public Long getMaSanPham() {
		return maSanPham;
	}
	public void setMaSanPham(Long maSanPham) {
		this.maSanPham = maSanPham;
	}
	public Long getMaDanhMuc() {
		return maDanhMuc;
	}
	public void setMaDanhMuc(Long maDanhMuc) {
		this.maDanhMuc = maDanhMuc;
	}
	public String getTenDanhMuc() {
		return tenDanhMuc;
	}
	public void setTenDanhMuc(String tenDanhMuc) {
		this.tenDanhMuc = tenDanhMuc;
	}
	public String getTenSanPham() {
		return tenSanPham;
	}
	public void setTenSanPham(String tenSanPham) {
		this.tenSanPham = tenSanPham;
	}
	public BigDecimal getGiaGoc() {
		return giaGoc;
	}
	public void setGiaGoc(BigDecimal giaGoc) {
		this.giaGoc = giaGoc;
	}
	public String getMoTa() {
		return moTa;
	}
	public void setMoTa(String moTa) {
		this.moTa = moTa;
	}
	public String getChatLieu() {
		return chatLieu;
	}
	public void setChatLieu(String chatLieu) {
		this.chatLieu = chatLieu;
	}
	public String getAnhDaiDien() {
		return anhDaiDien;
	}
	public void setAnhDaiDien(String anhDaiDien) {
		this.anhDaiDien = anhDaiDien;
	}
	public int getTrangThai() {
		return trangThai;
	}
	public void setTrangThai(int trangThai) {
		this.trangThai = trangThai;
	}
	public Date getNgayTao() {
		return ngayTao;
	}
	public void setNgayTao(Date ngayTao) {
		this.ngayTao = ngayTao;
	}
	public int getTongSoLuongTon() {
		return tongSoLuongTon;
	}
	public void setTongSoLuongTon(int tongSoLuongTon) {
		this.tongSoLuongTon = tongSoLuongTon;
	}
	@Override
	public String toString() {
		return "SanPham [maSanPham=" + maSanPham + ", maDanhMuc=" + maDanhMuc + ", tenDanhMuc=" + tenDanhMuc
				+ ", tenSanPham=" + tenSanPham + ", giaGoc=" + giaGoc + ", moTa=" + moTa + ", chatLieu=" + chatLieu
				+ ", anhDaiDien=" + anhDaiDien + ", trangThai=" + trangThai + ", ngayTao=" + ngayTao
				+ ", tongSoLuongTon=" + tongSoLuongTon + "]";
	}
	 public SanPham getById(Long id) {
	        EntityManager em = HypernateUtil.getEntityManager();
	        try {
	            return em.find(SanPham.class, id);
	        } finally {
	            em.close();
	        }
	    }
	public SanPham() {
		super();
		// TODO Auto-generated constructor stub
	}
    
}
