package dao;

import java.util.List;
import javax.persistence.EntityManager;
import javax.persistence.TypedQuery;

import model.Promotion;
import util.HypernateUtil;

public class PromotionDAO {

    // =====================
    // LIST + SEARCH
    // =====================
    public List<Promotion> getAll(String keyword, String status) {
        EntityManager em = HypernateUtil.getEntityManager();

        String jpql = "SELECT p FROM Promotion p WHERE 1=1";

        if (keyword != null && !keyword.isEmpty()) {
            jpql += " AND p.tenKhuyenMai LIKE :kw";
        }

        jpql += " ORDER BY p.ngayBatDau DESC";

        TypedQuery<Promotion> query = em.createQuery(jpql, Promotion.class);

        if (keyword != null && !keyword.isEmpty()) {
            query.setParameter("kw", "%" + keyword + "%");
        }

        List<Promotion> list = query.getResultList();
        em.close();
        return list;
    }

    // =====================
    // FIND BY ID
    // =====================
    public Promotion findById(Long id) {
        EntityManager em = HypernateUtil.getEntityManager();
        Promotion p = em.find(Promotion.class, id);
        em.close();
        return p;
    }

    // =====================
    // ADD
    // =====================
    public void insert(Promotion p) {
        EntityManager em = HypernateUtil.getEntityManager();
        em.getTransaction().begin();
        em.persist(p);
        em.getTransaction().commit();
        em.close();
    }

    // =====================
    // UPDATE
    // =====================
    public void update(Promotion p) {
        EntityManager em = HypernateUtil.getEntityManager();
        em.getTransaction().begin();
        em.merge(p);
        em.getTransaction().commit();
        em.close();
    }

    // =====================
    // DELETE
    // =====================
    public void delete(Long id) {
        EntityManager em = HypernateUtil.getEntityManager();
        em.getTransaction().begin();

        Promotion p = em.find(Promotion.class, id);
        if (p != null) {
            em.remove(p);
        }

        em.getTransaction().commit();
        em.close();
    }
}
