package dao;

import javax.persistence.EntityManager;
import javax.persistence.EntityTransaction;
import javax.persistence.TypedQuery;
import java.util.List;
import model.SanPham;
import model.ChiTietSanPham;
import util.HypernateUtil;

public class SanPhamDAO {

    /**
     * Tính toán tổng số lượng tồn của một sản phẩm
     * (Hàm nội bộ dùng để cập nhật giá trị Transient cho Entity)
     */
    private void setInventory(SanPham sp, EntityManager em) {
        if (sp == null) return;
        try {
            TypedQuery<Long> query = em.createQuery(
                "SELECT SUM(ct.soLuongTon) FROM ChiTietSanPham ct WHERE ct.maSanPham = :maSP", Long.class);
            query.setParameter("maSP", sp.getMaSanPham());
            Long tong = query.getSingleResult();
            sp.setTongSoLuongTon(tong != null ? tong.intValue() : 0);
        } catch (Exception e) {
            sp.setTongSoLuongTon(0);
        }
    }

    /**
     * Lấy tất cả sản phẩm
     */
    public List<SanPham> getAll() {
        EntityManager em = HypernateUtil.getEntityManager();
        try {
            TypedQuery<SanPham> query = em.createQuery("SELECT s FROM SanPham s ORDER BY s.maSanPham DESC", SanPham.class);
            List<SanPham> list = query.getResultList();
            // Tính tồn kho cho từng sản phẩm
            for (SanPham sp : list) {
                setInventory(sp, em);
            }
            return list;
        } finally {
            em.close();
        }
    }

    /**
     * Tìm kiếm và lọc sản phẩm
     */
    public List<SanPham> searchAndFilter(String keyword, Long categoryId, Integer status) {
        EntityManager em = HypernateUtil.getEntityManager();
        try {
            StringBuilder jpql = new StringBuilder("SELECT s FROM SanPham s WHERE 1=1");

            if (keyword != null && !keyword.trim().isEmpty()) {
                jpql.append(" AND LOWER(s.tenSanPham) LIKE :keyword");
            }
            if (categoryId != null) {
                jpql.append(" AND s.maDanhMuc = :categoryId");
            }
            if (status != null) {
                jpql.append(" AND s.trangThai = :status");
            }
            jpql.append(" ORDER BY s.maSanPham DESC");

            TypedQuery<SanPham> query = em.createQuery(jpql.toString(), SanPham.class);

            if (keyword != null && !keyword.trim().isEmpty()) {
                query.setParameter("keyword", "%" + keyword.toLowerCase() + "%");
            }
            if (categoryId != null) {
                query.setParameter("categoryId", categoryId);
            }
            if (status != null) {
                query.setParameter("status", status);
            }

            List<SanPham> list = query.getResultList();
            for (SanPham sp : list) {
                setInventory(sp, em);
            }
            return list;
        } finally {
            em.close();
        }
    }

    /**
     * Lấy SanPham theo ID (Có kèm tồn kho)
     */
    public SanPham getById(Long id) {
        EntityManager em = HypernateUtil.getEntityManager();
        try {
            SanPham sp = em.find(SanPham.class, id);
            if (sp != null) {
                setInventory(sp, em);
            }
            return sp;
        } finally {
            em.close();
        }
    }

    /**
     * Thêm mới sản phẩm
     */
    public boolean insert(SanPham sp) {
        EntityManager em = HypernateUtil.getEntityManager();
        EntityTransaction tran = em.getTransaction();
        try {
            tran.begin();
            em.persist(sp);
            tran.commit();
            return true;
        } catch (Exception e) {
            if (tran.isActive()) tran.rollback();
            e.printStackTrace();
            return false;
        } finally {
            em.close();
        }
    }

    /**
     * Cập nhật sản phẩm
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
            if (tran.isActive()) tran.rollback();
            e.printStackTrace();
            return false;
        } finally {
            em.close();
        }
    }

    /**
     * Xóa sản phẩm
     */
    public boolean delete(Long id) {
        EntityManager em = HypernateUtil.getEntityManager();
        EntityTransaction tran = em.getTransaction();
        try {
            tran.begin();
            SanPham sp = em.find(SanPham.class, id);
            if (sp != null) {
                em.remove(sp);
                tran.commit();
                return true;
            }
            return false;
        } catch (Exception e) {
            if (tran.isActive()) tran.rollback();
            e.printStackTrace();
            return false;
        } finally {
            em.close();
        }
    }
 // Đếm tổng số lượng sản phẩm
    public long countAll() {
        EntityManager em = util.HypernateUtil.getEntityManager();
        try {
            String jpql = "SELECT COUNT(s) FROM SanPham s";
            // Bước 1: Lấy kết quả dưới dạng Number
            Object result = em.createQuery(jpql).getSingleResult();
            // Bước 2: Ép kiểu an toàn về long
            return (result != null) ? ((Number) result).longValue() : 0L;
        } catch (Exception e) {
            e.printStackTrace();
            return 0L;
        } finally {
            em.close();
        }
    }

    // Lấy 5 sản phẩm mới nhất dựa trên mã ID giảm dần
    public List<SanPham> getTop5Latest() {
        EntityManager em = util.HypernateUtil.getEntityManager();
        try {
            String jpql = "SELECT s FROM SanPham s ORDER BY s.maSanPham DESC";
            return em.createQuery(jpql, SanPham.class)
                     .setMaxResults(5)
                     .getResultList();
        } finally {
            em.close();
        }
    }
}