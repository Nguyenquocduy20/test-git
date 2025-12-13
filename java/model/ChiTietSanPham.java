package model;

import javax.persistence.*;

@Entity
@Table(name = "ChiTietSanPham")
public class ChiTietSanPham {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "MaChiTietSP")
    private Long maChiTietSP;

    @Column(name = "MaSanPham", nullable = false)
    private Long maSanPham;

    @ManyToOne
    @JoinColumn(name = "MaSanPham", insertable = false, updatable = false)
    private SanPham sanPham;

    @Column(name = "MaMau", nullable = false)
    private Integer maMau;

    @Column(name = "MaSize", nullable = false)
    private Integer maSize;

    @Column(name = "SoLuongTon", nullable = false)
    private Integer soLuongTon;

    // Getter & Setter
    public Long getMaChiTietSP() { return maChiTietSP; }
    public void setMaChiTietSP(Long maChiTietSP) { this.maChiTietSP = maChiTietSP; }

    public Long getMaSanPham() { return maSanPham; }
    public void setMaSanPham(Long maSanPham) { this.maSanPham = maSanPham; }

    public SanPham getSanPham() { return sanPham; }
    public void setSanPham(SanPham sanPham) { this.sanPham = sanPham; }

    public Integer getMaMau() { return maMau; }
    public void setMaMau(Integer maMau) { this.maMau = maMau; }

    public Integer getMaSize() { return maSize; }
    public void setMaSize(Integer maSize) { this.maSize = maSize; }

    public Integer getSoLuongTon() { return soLuongTon; }
    public void setSoLuongTon(Integer soLuongTon) { this.soLuongTon = soLuongTon; }
}
