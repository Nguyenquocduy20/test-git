package dao;

import java.util.List;
import javax.persistence.EntityManager;
import javax.persistence.EntityTransaction;
import javax.persistence.TypedQuery;

import model.ChiTietSanPham;
import util.HypernateUtil;

public class ChiTietSanPhamDAO {

    // Lấy danh sách ChiTietSanPham theo maSanPham
    public List<ChiTietSanPham> getBySanPham(Long maSanPham) {
        EntityManager em = HypernateUtil.getEntityManager();
        try {
            TypedQuery<ChiTietSanPham> query = em.createQuery(
                "SELECT ct FROM ChiTietSanPham ct WHERE ct.maSanPham = :id",
                ChiTietSanPham.class
            );
            query.setParameter("id", maSanPham);
            return query.getResultList();
        } finally {
            em.close();
        }
    }

    // Thêm chi tiết sản phẩm
    public boolean insert(ChiTietSanPham ct) {
        EntityManager em = HypernateUtil.getEntityManager();
        try {
            em.getTransaction().begin();
            em.persist(ct);
            em.getTransaction().commit();
            return true;
        } catch (Exception e) {
            e.printStackTrace();
            if (em.getTransaction().isActive()) em.getTransaction().rollback();
            return false;
        } finally {
            em.close();
        }
    }

    public boolean update(ChiTietSanPham ct) {
        EntityManager em = HypernateUtil.getEntityManager();
        try {
            em.getTransaction().begin();
            em.merge(ct);
            em.getTransaction().commit();
            return true;
        } catch (Exception e) {
            e.printStackTrace();
            if (em.getTransaction().isActive()) em.getTransaction().rollback();
            return false;
        } finally {
            em.close();
        }
    }

    public boolean delete(Long maChiTiet) {
        EntityManager em = HypernateUtil.getEntityManager();
        try {
            ChiTietSanPham ct = em.find(ChiTietSanPham.class, maChiTiet);
            if (ct == null) return false;
            em.getTransaction().begin();
            em.remove(ct);
            em.getTransaction().commit();
            return true;
        } catch (Exception e) {
            e.printStackTrace();
            if (em.getTransaction().isActive()) em.getTransaction().rollback();
            return false;
        } finally {
            em.close();
        }
    }

    // Lấy chi tiết sản phẩm đầu tiên
    public ChiTietSanPham getFirstBySanPham(Long maSanPham) {
        EntityManager em = HypernateUtil.getEntityManager();
        try {
            TypedQuery<ChiTietSanPham> query = em.createQuery(
                "SELECT ct FROM ChiTietSanPham ct WHERE ct.maSanPham = :id",
                ChiTietSanPham.class
            );
            query.setParameter("id", maSanPham);
            query.setMaxResults(1);
            List<ChiTietSanPham> list = query.getResultList();
            return list.isEmpty() ? null : list.get(0);
        } finally {
            em.close();
        }
    }
    public boolean updateSoLuongTonBySanPham(Long maSanPham, int soLuongMoi) {
        EntityManager em = HypernateUtil.getEntityManager();
        EntityTransaction tran = em.getTransaction();
        try {
            tran.begin();
            // Lấy tất cả chi tiết sản phẩm của sản phẩm này
            List<ChiTietSanPham> list = em.createQuery(
                    "SELECT ct FROM ChiTietSanPham ct WHERE ct.maSanPham = :id", ChiTietSanPham.class)
                    .setParameter("id", maSanPham)
                    .getResultList();
            for (ChiTietSanPham ct : list) {
                ct.setSoLuongTon(soLuongMoi); // hoặc + soLuongMoi nếu bạn muốn cộng dồn
                em.merge(ct);
            }
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
