package controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.KhachHangDAO;
import model.KhachHang;

@WebServlet("/admin/customers")
public class CustomerServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    // KHAI BÁO DAO Ở ĐÂY (Để cả doGet và doPost đều dùng được)
    private KhachHangDAO dao = new KhachHangDAO();

    public CustomerServlet() {
        super();
    }

    /**
     * Hiển thị danh sách khách hàng & Tìm kiếm
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        // Đảm bảo đọc tiếng Việt từ thanh URL nếu có
        request.setCharacterEncoding("UTF-8");
        
        String keyword = request.getParameter("keyword");
        
        // Gọi hàm từ DAO (Đã có keyword)
        List<KhachHang> list = dao.getAllCustomers(keyword);
        
        request.setAttribute("customerList", list);
        request.setAttribute("keyword", keyword);
        
        // Trỏ về đúng file JSP của bạn
        request.getRequestDispatcher("/WEB-INF/views/customer-list.jsp").forward(request, response);
    }

    /**
     * Xử lý thêm khách hàng mới từ Modal
     */
    @Override
 // Trong doPost của CustomerServlet.java
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        
        String ten = request.getParameter("ten");
        String email = request.getParameter("email");
        String sdt = request.getParameter("soDienThoai");
        String hang = request.getParameter("hang");
        String diaChi = request.getParameter("diaChi");

        KhachHang kh = new KhachHang();
        kh.setTen(ten);
        kh.setEmail(email);
        kh.setSoDienThoai(sdt);
        kh.setHang(hang != null ? hang : "Member");
        kh.setDiaChi(diaChi);
        kh.setTrangThai("Active");

        // QUAN TRỌNG: Gán giá trị cho MaTaiKhoan vì DB bắt buộc phải có
        // Bạn hãy kiểm tra bảng 'taikhoan' xem có ID nào hiện có (ví dụ: 1)
        kh.setMaTaiKhoan(1L); 

        dao.saveKhachHang(kh);
        
        response.sendRedirect(request.getContextPath() + "/admin/customers");
    }
}