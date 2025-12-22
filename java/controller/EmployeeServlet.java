package controller;

import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import dao.NhanVienDAO;
import model.NhanVien;
/**
 * Servlet implementation class EmployeeServlet
 */
@WebServlet("/admin/employees")
public class EmployeeServlet extends HttpServlet {
	private NhanVienDAO dao = new NhanVienDAO();
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public EmployeeServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        
        String action = request.getParameter("action");
        String idStr = request.getParameter("id");

        // Nếu có yêu cầu sửa (action=edit), lấy thông tin nhân viên đó
        if ("edit".equals(action) && idStr != null) {
            Long id = Long.parseLong(idStr);
            NhanVien nvEdit = dao.getNhanVienById(id);
            request.setAttribute("employeeEdit", nvEdit);
        }

        // Logic lấy danh sách cũ của bạn
        List<NhanVien> list = dao.getAllEmployees("", "", "");
        request.setAttribute("employeeList", list);
        
        request.getRequestDispatcher("/WEB-INF/views/employee-list.jsp").forward(request, response);
    }

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        String action = request.getParameter("action");

        try {
            if ("lock".equals(action)) {
                // XỬ LÝ KHÓA: Lấy MaTaiKhoan từ form ẩn gửi lên
                String maTKStr = request.getParameter("maTaiKhoan");
                if (maTKStr != null) {
                    dao.lockTaiKhoan(Long.parseLong(maTKStr));
                }
            } 
            else if ("update".equals(action)) {
                // XỬ LÝ SỬA: Tìm nhân viên cũ và cập nhật thông tin mới
                Long id = Long.parseLong(request.getParameter("maNhanVien"));
                NhanVien nv = dao.getNhanVienById(id);
                
                if (nv != null) {
                    nv.setHoTen(request.getParameter("hoTen"));
                    nv.setEmail(request.getParameter("email"));
                    nv.setSoDienThoai(request.getParameter("soDienThoai"));
                    nv.setPhongBan(request.getParameter("phongBan"));
                    nv.setChucVu(request.getParameter("chucVu"));
                    nv.setTrangThai(request.getParameter("trangThai"));
                    
                    // Cập nhật Ngày vào làm (nếu có sửa)
                    String ngayStr = request.getParameter("ngayVaoLam");
                    if (ngayStr != null && !ngayStr.isEmpty()) {
                        nv.setNgayVaoLam(java.sql.Date.valueOf(ngayStr));
                    }
                    
                    dao.updateNhanVien(nv);
                }
            } 
            else {
                // XỬ LÝ THÊM MỚI (Logic bạn đã chạy ổn)
                NhanVien nv = new NhanVien();
                nv.setHoTen(request.getParameter("hoTen"));
                nv.setEmail(request.getParameter("email"));
                nv.setSoDienThoai(request.getParameter("soDienThoai"));
                nv.setPhongBan(request.getParameter("phongBan"));
                nv.setChucVu(request.getParameter("chucVu"));
                nv.setTrangThai(request.getParameter("trangThai"));
                
                String ngayStr = request.getParameter("ngayVaoLam");
                if (ngayStr != null && !ngayStr.isEmpty()) {
                    nv.setNgayVaoLam(java.sql.Date.valueOf(ngayStr));
                }
                
                // Tạm thời gán mã tài khoản là 2 như cũ hoặc dùng logic tạo mới TaiKhoan
                nv.setMaTaiKhoan(2L); 
                
                dao.saveNhanVien(nv);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        
        response.sendRedirect(request.getContextPath() + "/admin/employees");
    }
}
