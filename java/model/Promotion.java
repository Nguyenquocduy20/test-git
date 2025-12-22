package model;

import javax.persistence.*;
import java.util.Date;

@Entity
@Table(name = "khuyenmai")
public class Promotion {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "MaKhuyenMai")
    private Long maKhuyenMai;

    @Column(name = "TenKhuyenMai")
    private String tenKhuyenMai;

    @Column(name = "GiaTriGiam")
    private Double giaTriGiam;

    @Temporal(TemporalType.DATE)
    @Column(name = "NgayBatDau")
    private Date ngayBatDau;

    @Temporal(TemporalType.DATE)
    @Column(name = "NgayKetThuc")
    private Date ngayKetThuc;

    // ===== GETTER SETTER =====
    public Long getMaKhuyenMai() { return maKhuyenMai; }
    public void setMaKhuyenMai(Long maKhuyenMai) { this.maKhuyenMai = maKhuyenMai; }

    public String getTenKhuyenMai() { return tenKhuyenMai; }
    public void setTenKhuyenMai(String tenKhuyenMai) { this.tenKhuyenMai = tenKhuyenMai; }

    public Double getGiaTriGiam() { return giaTriGiam; }
    public void setGiaTriGiam(Double giaTriGiam) { this.giaTriGiam = giaTriGiam; }

    public Date getNgayBatDau() { return ngayBatDau; }
    public void setNgayBatDau(Date ngayBatDau) { this.ngayBatDau = ngayBatDau; }

    public Date getNgayKetThuc() { return ngayKetThuc; }
    public void setNgayKetThuc(Date ngayKetThuc) { this.ngayKetThuc = ngayKetThuc; }
}
