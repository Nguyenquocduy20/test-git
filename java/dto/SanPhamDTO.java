package dto;

import java.math.BigDecimal;
import java.util.Date;

import javax.persistence.EntityManager;

import model.SanPham;
import util.HypernateUtil;

public class SanPhamDTO {
    private Long maSanPham;
    private String tenSanPham;
    private Long maDanhMuc;
    private BigDecimal giaGoc;
    private String moTa;
    private String chatLieu;
    private String anhDaiDien;
    private int trangThai;
    private Date ngayTao;
    private int tongSoLuongTon;

    // Getter & Setter
    public Long getMaSanPham() { return maSanPham; }
    public void setMaSanPham(Long maSanPham) { this.maSanPham = maSanPham; }

    public String getTenSanPham() { return tenSanPham; }
    public void setTenSanPham(String tenSanPham) { this.tenSanPham = tenSanPham; }

    public Long getMaDanhMuc() { return maDanhMuc; }
    public void setMaDanhMuc(Long maDanhMuc) { this.maDanhMuc = maDanhMuc; }

    public BigDecimal getGiaGoc() { return giaGoc; }
    public void setGiaGoc(BigDecimal giaGoc) { this.giaGoc = giaGoc; }

    public String getMoTa() { return moTa; }
    public void setMoTa(String moTa) { this.moTa = moTa; }

    public String getChatLieu() { return chatLieu; }
    public void setChatLieu(String chatLieu) { this.chatLieu = chatLieu; }

    public String getAnhDaiDien() { return anhDaiDien; }
    public void setAnhDaiDien(String anhDaiDien) { this.anhDaiDien = anhDaiDien; }

    public int getTrangThai() { return trangThai; }
    public void setTrangThai(int trangThai) { this.trangThai = trangThai; }

    public Date getNgayTao() { return ngayTao; }
    public void setNgayTao(Date ngayTao) { this.ngayTao = ngayTao; }
   

    public int getTongSoLuongTon() { return tongSoLuongTon; }
    public void setTongSoLuongTon(int tongSoLuongTon) { this.tongSoLuongTon = tongSoLuongTon; }
}
