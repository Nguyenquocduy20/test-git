package dao;

import java.util.List;
import javax.persistence.EntityManager;
import javax.persistence.TypedQuery;
import model.KhachHang;
import util.HypernateUtil;

public class KhachHangDAO {
    
    public List<KhachHang> getAllCustomers(String keyword) {
        EntityManager em = HypernateUtil.getEntityManager();
        try {
            // Sử dụng LEFT JOIN FETCH để đảm bảo khách hàng mới (chưa có đơn hàng) vẫn hiển thị
            StringBuilder hql = new StringBuilder("SELECT DISTINCT kh FROM KhachHang kh LEFT JOIN FETCH kh.danhSachDonHang WHERE 1=1");
            
            if (keyword != null && !keyword.isEmpty()) {
                hql.append(" AND (kh.ten LIKE :key OR kh.email LIKE :key OR kh.soDienThoai LIKE :key)");
            }
            
            TypedQuery<KhachHang> query = em.createQuery(hql.toString(), KhachHang.class);
            
            if (keyword != null && !keyword.isEmpty()) {
                query.setParameter("key", "%" + keyword + "%");
            }
            
            return query.getResultList();
        } finally {
            em.close();
        }
    }

    public void saveKhachHang(KhachHang kh) {
        EntityManager em = HypernateUtil.getEntityManager();
        try {
            em.getTransaction().begin();
            
            // KIỂM TRA: Nếu MaTaiKhoan đang trống, hãy gán một giá trị hợp lệ 
            // (Giá trị này phải tồn tại trong bảng 'taikhoan' nếu có ràng buộc khóa ngoại)
            if (kh.getMaTaiKhoan() == null) {
                kh.setMaTaiKhoan(1L); 
            }
            
            em.persist(kh);
            em.getTransaction().commit(); // Đảm bảo đã commit để dữ liệu ghi xuống DB
        } catch (Exception e) {
            if (em.getTransaction().isActive()) em.getTransaction().rollback();
            e.printStackTrace();
        } finally {
            em.close();
        }
    }
    public long countAll() {
        EntityManager em = util.HypernateUtil.getEntityManager();
        try {
            String jpql = "SELECT COUNT(k) FROM KhachHang k";
            return (long) em.createQuery(jpql).getSingleResult();
        } finally {
            em.close();
        }
    }

    // Bạn không cần hàm getTongChiTieu này nữa nếu đã dùng hàm tính toán trực tiếp trong Model KhachHang
}