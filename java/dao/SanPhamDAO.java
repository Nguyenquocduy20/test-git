package dao;

import javax.persistence.EntityManager;
import javax.persistence.EntityTransaction;
import javax.persistence.TypedQuery;
import java.util.List;
import java.util.ArrayList;

import model.SanPham;
import model.ChiTietSanPham;
import dto.SanPhamDTO;
import util.HypernateUtil; // Giữ nguyên tên lớp tiện ích bạn cung cấp

public class SanPhamDAO {

    // Khởi tạo ChiTietSanPhamDAO để tính Tổng số lượng tồn
    private ChiTietSanPhamDAO ctDao = new ChiTietSanPhamDAO();

    /**
     * Chuyển đổi đối tượng SanPham (Entity) sang SanPhamDTO (DTO)
     * Thêm logic tính tổng số lượng tồn và xử lý ảnh đại diện mặc định.
     * Đổi tên hàm từ 'toDTO' thành 'convertToDTO' để thống nhất với Servlet.
     * @param sp Đối tượng SanPham
     * @return Đối tượng SanPhamDTO đã được ánh xạ
     */
    public SanPhamDTO convertToDTO(SanPham sp) {
        if (sp == null) {
            return null;
        }

        SanPhamDTO dto = new SanPhamDTO();
        
        // --- Ánh xạ các trường từ Entity sang DTO ---
        dto.setMaSanPham(sp.getMaSanPham());
        dto.setTenSanPham(sp.getTenSanPham());
        dto.setMaDanhMuc(sp.getMaDanhMuc());
        dto.setGiaGoc(sp.getGiaGoc());
        dto.setMoTa(sp.getMoTa());
        dto.setChatLieu(sp.getChatLieu());
        // Đảm bảo ảnh đại diện luôn có giá trị (default.png)
        dto.setAnhDaiDien(sp.getAnhDaiDien() != null && !sp.getAnhDaiDien().isEmpty() ? sp.getAnhDaiDien() : "default.png");
        dto.setTrangThai(sp.getTrangThai());
        dto.setNgayTao(sp.getNgayTao());

        // --- Logic tính toán Tổng Số Lượng Tồn ---
        // Sử dụng ChiTietSanPhamDAO để lấy danh sách chi tiết và tính tổng
        List<ChiTietSanPham> listCT = ctDao.getBySanPham(sp.getMaSanPham());
        int tong = 0;
        if (listCT != null) {
            tong = listCT.stream()
                        .mapToInt(ChiTietSanPham::getSoLuongTon)
                        .sum();
        }
        dto.setTongSoLuongTon(tong);
        
        return dto;
    }

    /**
     * Lấy tất cả sản phẩm từ DB và chuyển đổi sang DTO
     * @return Danh sách SanPhamDTO
     */
    public List<SanPhamDTO> getAll() {
        EntityManager em = HypernateUtil.getEntityManager();
        List<SanPhamDTO> listDTO = new ArrayList<>();
        try {
            // Sử dụng TypedQuery để chuẩn hóa
            TypedQuery<SanPham> query = em.createQuery("SELECT s FROM SanPham s", SanPham.class);
            List<SanPham> listSP = query.getResultList();

            for (SanPham sp : listSP) {
                listDTO.add(convertToDTO(sp));
            }
            return listDTO;
        } finally {
            em.close();
        }
    }

    /**
     * Lấy SanPham theo ID (dùng cho Servlet/Logic nghiệp vụ)
     * @param id Mã sản phẩm
     * @return Đối tượng SanPham Entity
     */
    public SanPham getById(Long id) {
        EntityManager em = HypernateUtil.getEntityManager();
        try {
            return em.find(SanPham.class, id);
        } finally {
            em.close();
        }
    }

    /**
     * Lấy SanPham theo ID và chuyển đổi sang DTO (dùng cho hiển thị)
     * @param id Mã sản phẩm
     * @return Đối tượng SanPhamDTO
     */
    public SanPhamDTO getByIdDTO(Long id) {
        EntityManager em = HypernateUtil.getEntityManager();
        try {
            SanPham sp = em.find(SanPham.class, id);
            return convertToDTO(sp); // Gọi hàm đã đổi tên
        } finally {
            em.close();
        }
    }

    /**
     * Thêm mới một SanPham vào DB
     * @param sp Đối tượng SanPham cần chèn
     * @return true nếu thành công
     */
    public boolean insert(SanPham sp) {
        EntityManager em = HypernateUtil.getEntityManager();
        EntityTransaction tran = em.getTransaction();
        try {
            tran.begin();
            em.persist(sp);
            em.flush(); // Đảm bảo ID được tạo trước khi commit (nếu cần)
            tran.commit();
            return true;
        } catch (Exception e) {
            e.printStackTrace();
            if (tran.isActive()) tran.rollback();
            return false;
        } finally {
            em.close();
        }
    }

    /**
     * Cập nhật SanPham trong DB
     * @param sp Đối tượng SanPham đã thay đổi
     * @return true nếu thành công
     */
    public boolean update(SanPham sp) {
        EntityManager em = HypernateUtil.getEntityManager();
        EntityTransaction tran = em.getTransaction();
        try {
            tran.begin();
            em.merge(sp);
            tran.commit();
            return true;
        } catch (Exception e) {
            e.printStackTrace();
            if (tran.isActive()) tran.rollback();
            return false;
        } finally {
            em.close();
        }
    }

    /**
     * Xóa SanPham theo ID
     * @param id Mã sản phẩm cần xóa
     * @return true nếu xóa thành công
     */
    public boolean delete(Long id) {
        EntityManager em = HypernateUtil.getEntityManager();
        EntityTransaction tran = em.getTransaction();
        try {
            SanPham sp = em.find(SanPham.class, id);
            if (sp == null) return false;
            
            tran.begin();
            // Lấy lại đối tượng trong transaction nếu nó bị detached
            if (!em.contains(sp)) {
                sp = em.merge(sp); 
            }
            em.remove(sp);
            tran.commit();
            return true;
        } catch (Exception e) {
            e.printStackTrace();
            if (tran.isActive()) tran.rollback();
            return false;
        } finally {
            em.close();
        }
    }

    /**
     * Cập nhật số lượng tồn của ChiTietSanPham
     * @param maChiTietSP Mã chi tiết sản phẩm
     * @param soLuongTon Số lượng tồn mới
     * @return true nếu thành công
     */
    public boolean updateSoLuongTon(Long maChiTietSP, int soLuongTon) {
        EntityManager em = HypernateUtil.getEntityManager();
        EntityTransaction tran = em.getTransaction();
        try {
            tran.begin();
            ChiTietSanPham ctsp = em.find(ChiTietSanPham.class, maChiTietSP);
            
            if (ctsp == null) {
                tran.rollback();
                return false;
            }
            
            ctsp.setSoLuongTon(soLuongTon);
            em.merge(ctsp);
            tran.commit();
            return true;
        } catch (Exception e) {
            e.printStackTrace();
            if (tran.isActive()) tran.rollback();
            return false;
        } finally {
            em.close();
        }
    }
}