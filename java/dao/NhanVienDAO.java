package dao;

import java.util.List;
import javax.persistence.EntityManager;
import javax.persistence.TypedQuery;
import model.NhanVien;
import model.TaiKhoan;
import util.HypernateUtil;

public class NhanVienDAO {

   
	// Trong NhanVienDAO.java
	public List<NhanVien> getAllEmployees(String keyword, String phongBan, String chucVu) {
	    EntityManager em = HypernateUtil.getEntityManager();
	    try {
	        // Thử dùng câu lệnh này trước để xem dữ liệu có hiện ra không
	        String hql = "FROM NhanVien"; 
	        return em.createQuery(hql, NhanVien.class).getResultList();
	    } finally {
	        em.close();
	    }
	}

    
	public void saveNhanVien(NhanVien nv) {
	    EntityManager em = util.HypernateUtil.getEntityManager();
	    try {
	        em.getTransaction().begin();

	        // 1. Tạo một tài khoản mới hoàn toàn cho nhân viên này
	        TaiKhoan tk = new TaiKhoan();
	        tk.setTenDangNhap(nv.getEmail()); // Dùng email làm username để đảm bảo UNIQUE
	        tk.setMatKhau("123456");         // Mật khẩu mặc định
	        tk.setVaiTro("NhanVien");        //
	        tk.setNgayTao(new java.util.Date()); //

	        // 2. Lưu tài khoản vào DB trước để lấy MaTaiKhoan tự động
	        em.persist(tk);
	        em.flush(); // Đẩy dữ liệu xuống để tk nhận được ID tự sinh

	        // 3. Gán MaTaiKhoan vừa tạo cho nhân viên
	        nv.setMaTaiKhoan(tk.getMaTaiKhoan());

	        // 4. Lưu nhân viên
	        em.persist(nv);

	        em.getTransaction().commit();
	    } catch (Exception e) {
	        if (em.getTransaction().isActive()) em.getTransaction().rollback();
	        e.printStackTrace();
	    } finally {
	        em.close();
	    }
	}
	public NhanVien getNhanVienById(Long id) {
	    EntityManager em = util.HypernateUtil.getEntityManager();
	    try {
	        // Sử dụng hàm find để tìm kiếm trực tiếp theo khóa chính (MaNhanVien)
	        return em.find(NhanVien.class, id);
	    } catch (Exception e) {
	        e.printStackTrace();
	        return null;
	    } finally {
	        em.close();
	    }
	}
	public void updateNhanVien(NhanVien nv) {
	    EntityManager em = util.HypernateUtil.getEntityManager();
	    try {
	        em.getTransaction().begin();
	        em.merge(nv); // merge dùng để cập nhật đối tượng đã tồn tại
	        em.getTransaction().commit();
	    } catch (Exception e) {
	        if (em.getTransaction().isActive()) em.getTransaction().rollback();
	        e.printStackTrace();
	    } finally {
	        em.close();
	    }
	}

	public void lockTaiKhoan(Long maTaiKhoan) {
	    EntityManager em = util.HypernateUtil.getEntityManager();
	    try {
	        em.getTransaction().begin();
	        // Tìm tài khoản theo ID
	        TaiKhoan tk = em.find(TaiKhoan.class, maTaiKhoan);
	        if (tk != null) {
	            // Giả sử bạn thêm cột TrangThai vào bảng TaiKhoan hoặc đổi mật khẩu để khóa
	            tk.setMatKhau("LOCKED_" + System.currentTimeMillis()); 
	            em.merge(tk);
	        }
	        em.getTransaction().commit();
	    } catch (Exception e) {
	        if (em.getTransaction().isActive()) em.getTransaction().rollback();
	        e.printStackTrace();
	    } finally {
	        em.close();
	    }
	}
}