package dao;

import java.util.Collections;
import java.util.List;
import javax.persistence.EntityManager;
import javax.persistence.TypedQuery;

import model.ChiTietDonHang;
import model.DonHang;
import model.KhachHang;
import util.HypernateUtil;

public class DonHangDAO {

    // Số lượng đơn hàng tối đa trên mỗi trang
    private static final int RECORDS_PER_PAGE = 10; 

    /**
     * Lấy danh sách đơn hàng có phân trang và áp dụng tìm kiếm/lọc.
     * ĐÃ SỬA: Bỏ cú pháp JOIN SQL không chuẩn trong JPQL.
     * Tạm thời chỉ tìm kiếm theo Mã đơn hàng (MaDonHang) để đảm bảo query chạy.
     */
    public List<DonHang> getOrdersForList(String keyword, String status, String date, int page) {
        EntityManager em = HypernateUtil.getEntityManager();
        List<DonHang> orderList = Collections.emptyList();
        
        // SỬA JPQL: Chỉ truy vấn entity DonHang (dh)
        StringBuilder jpql = new StringBuilder("SELECT dh FROM DonHang dh WHERE 1=1 ");
        
        try {
            // 1. Xử lý Lọc và Tìm kiếm (Filter & Search)
            
            if (status != null && !status.isEmpty() && !status.contains("--")) {
                jpql.append(" AND dh.trangThai = :status");
            }
            
            if (keyword != null && !keyword.trim().isEmpty()) {
                // SỬA: Tạm thời chỉ tìm kiếm theo Mã đơn hàng (MaDonHang) để query đơn giản và chạy được.
                jpql.append(" AND CAST(dh.maDonHang AS string) LIKE :keyword");
            }
            
            // Xử lý lọc theo ngày (Cần thêm logic phức tạp hơn nếu muốn dùng)
            
            // Sắp xếp theo ngày đặt hàng mới nhất
            jpql.append(" ORDER BY dh.ngayDatHang DESC");

            TypedQuery<DonHang> query = em.createQuery(jpql.toString(), DonHang.class);

            // 2. Thiết lập tham số
            if (status != null && !status.isEmpty() && !status.contains("--")) {
                query.setParameter("status", status);
            }
            
            if (keyword != null && !keyword.trim().isEmpty()) {
                query.setParameter("keyword", "%" + keyword + "%");
            }

            // 3. Xử lý Phân trang (Pagination)
            query.setFirstResult((page - 1) * RECORDS_PER_PAGE);
            query.setMaxResults(RECORDS_PER_PAGE);

            orderList = query.getResultList();
            
            // GHI NHẬT KÝ (LOG): Kiểm tra số lượng đơn hàng lấy được
            System.out.println("DEBUG DAO: Số lượng đơn hàng lấy được từ DB: " + orderList.size());
            
            // 4. Bổ sung thông tin Khách hàng (Vẫn cần)
            // Lặp qua list đơn hàng, và lấy thông tin Khách hàng cho từng đơn
            for (DonHang dh : orderList) {
                KhachHang kh = em.find(KhachHang.class, dh.getMaKhachHang());
                if (kh != null) {
                    dh.setTenKhachHang(kh.getTen());
                    dh.setSoDienThoaiKhachHang(kh.getSoDienThoai());
                } else {
                    // Xử lý trường hợp không tìm thấy khách hàng (lỗi data)
                    dh.setTenKhachHang("Khách hàng không tồn tại");
                    dh.setSoDienThoaiKhachHang("N/A");
                    System.err.println("DEBUG DAO ERROR: Không tìm thấy KhachHang cho MaDonHang: " + dh.getMaDonHang() + " (MaKhachHang: " + dh.getMaKhachHang() + ")");
                }
            }

        } catch (Exception e) {
            // In lỗi ra console để debug nếu có bất kỳ lỗi nào xảy ra
            e.printStackTrace();
        } finally {
            em.close();
        }
        return orderList;
    }
    
    /**
     * Lấy tổng số bản ghi (record) để phục vụ cho việc tính toán tổng số trang
     * ĐÃ SỬA: Bỏ cú pháp JOIN SQL không chuẩn trong JPQL.
     */
    public long getTotalRecords(String keyword, String status) {
        EntityManager em = HypernateUtil.getEntityManager();
        long total = 0;
        
        // SỬA JPQL: Chỉ truy vấn entity DonHang (dh)
        StringBuilder jpql = new StringBuilder("SELECT COUNT(dh.maDonHang) FROM DonHang dh WHERE 1=1 ");

        try {
            if (status != null && !status.isEmpty() && !status.contains("--")) {
                jpql.append(" AND dh.trangThai = :status");
            }
            
            if (keyword != null && !keyword.trim().isEmpty()) {
               
                jpql.append(" AND CAST(dh.maDonHang AS string) LIKE :keyword");
            }
            
            TypedQuery<Long> query = em.createQuery(jpql.toString(), Long.class);
            
            if (status != null && !status.isEmpty() && !status.contains("--")) {
                query.setParameter("status", status);
            }
            
            if (keyword != null && !keyword.trim().isEmpty()) {
                query.setParameter("keyword", "%" + keyword + "%");
            }

            total = query.getSingleResult();
            System.out.println("DEBUG DAO: Tổng số bản ghi (Total Records) tìm thấy: " + total);

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            em.close();
        }
        return total;
    }
    
    public int getTotalPages(String keyword, String status) {
        long totalRecords = getTotalRecords(keyword, status);
       
        if (totalRecords == 0) return 1; 
        return (int) Math.ceil((double) totalRecords / RECORDS_PER_PAGE);
    }
    /**
     * Lấy danh sách chi tiết sản phẩm của một đơn hàng dựa trên MaDonHang.
     */
    public List<model.ChiTietDonHang> getChiTietByMaDonHang(long maDonHang) {
        EntityManager em = util.HypernateUtil.getEntityManager();
        List<model.ChiTietDonHang> list = java.util.Collections.emptyList();
        try {
            // Truy vấn lấy tất cả chi tiết thuộc về mã đơn hàng này
            String jpql = "SELECT ct FROM ChiTietDonHang ct WHERE ct.maDonHang = :maDonHang";
            list = em.createQuery(jpql, model.ChiTietDonHang.class)
                     .setParameter("maDonHang", maDonHang)
                     .getResultList();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            em.close();
        }
        return list;
    }

    /**
     * Lấy thông tin một đơn hàng cụ thể theo ID.
     */
    public DonHang getById(long id) {
        EntityManager em = util.HypernateUtil.getEntityManager();
        try {
            DonHang dh = em.find(DonHang.class, id);
            // Bổ sung tên khách hàng như cách bạn làm ở getOrdersForList
            if (dh != null) {
                model.KhachHang kh = em.find(model.KhachHang.class, dh.getMaKhachHang());
                if (kh != null) {
                    dh.setTenKhachHang(kh.getTen());
                    dh.setSoDienThoaiKhachHang(kh.getSoDienThoai());
                }
            }
            return dh;
        } finally {
            em.close();
        }
    }
    public Double calculateTotalRevenue() {
        EntityManager em = HypernateUtil.getEntityManager();
        try {
            // Ép kiểu Double ngay trong câu truy vấn JPQL
            String jpql = "SELECT CAST(SUM(d.tongTien) AS double) FROM DonHang d";
            
            TypedQuery<Double> query = em.createQuery(jpql, Double.class);
            Double result = query.getSingleResult();
            
            return result != null ? result : 0.0;
        } catch (Exception e) {
            e.printStackTrace();
            return 0.0;
        } finally {
            em.close();
        }
    }
    public long countNewOrdersToday() {
        EntityManager em = HypernateUtil.getEntityManager();
        try {
            // Lưu ý: dh.ngayDatHang phải khớp với tên biến trong file model DonHang.java
            String jpql = "SELECT COUNT(dh) FROM DonHang dh WHERE CAST(dh.ngayDatHang AS date) = CURRENT_DATE";
            Number result = (Number) em.createQuery(jpql).getSingleResult();
            return result != null ? result.longValue() : 0L;
        } catch (Exception e) {
            System.err.println("Lỗi tại countNewOrdersToday: " + e.getMessage());
            return 0L;
        } finally {
            em.close();
        }
    }

    /**
     * Đếm số lượng đơn hàng được đặt trong ngày hôm nay.
     */
    public long countAll() {
        EntityManager em = util.HypernateUtil.getEntityManager();
        try {
            String jpql = "SELECT COUNT(s) FROM SanPham s";
            // Ép kiểu qua Number để tránh lỗi ClassCastException
            Number result = (Number) em.createQuery(jpql).getSingleResult();
            return result != null ? result.longValue() : 0L;
        } catch (Exception e) {
            e.printStackTrace();
            return 0L;
        } finally {
            em.close();
        }
    }
}