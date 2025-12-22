package controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.mysql.cj.result.Row;

import dao.DonHangDAO;
import model.ChiTietDonHang;
import model.DonHang;

@WebServlet("/admin/orders")
public class OrderListServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private DonHangDAO donHangDAO;

    public void init() throws ServletException {
        super.init();
        donHangDAO = new DonHangDAO(); // Khởi tạo DAO
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        
        String action = request.getParameter("action");
        
        // Nếu action là "viewDetail", thực hiện lấy chi tiết đơn hàng
     // Giả sử trong OrderServlet.java
        if ("viewDetail".equals(action)) {
            String idStr = request.getParameter("id");
            if (idStr != null) {
                long id = Long.parseLong(idStr);
                DonHangDAO dao = new DonHangDAO();
                
      
                List<ChiTietDonHang> details = dao.getChiTietByMaDonHang(id);
                
                // 2. Lấy thông tin đơn hàng (để lấy MaKhuyenMai)
                DonHang order = dao.getById(id);
                
                // 3. Đẩy dữ liệu sang JSP
                request.setAttribute("details", details);
                request.setAttribute("order", order); // Quan trọng: Để lấy được order.maKhuyenMai
                
                request.getRequestDispatcher("/WEB-INF/views/order-detail.jsp").forward(request, response);
            }
        }
        // Mặc định hoặc khi action trống thì hiện danh sách đơn hàng
        else {
            String keyword = request.getParameter("keyword");
            String status = request.getParameter("status");
            String date = request.getParameter("date");
            String pageStr = request.getParameter("page");

            int currentPage = 1;
            if (pageStr != null && pageStr.matches("\\d+")) {
                currentPage = Integer.parseInt(pageStr);
            }
            
            List<DonHang> orderList = donHangDAO.getOrdersForList(keyword, status, date, currentPage);
            int totalPages = donHangDAO.getTotalPages(keyword, status);

            request.setAttribute("orderList", orderList);
            request.setAttribute("totalPages", totalPages);
            request.setAttribute("currentPage", currentPage);
            request.setAttribute("keyword", keyword);
            request.setAttribute("status", status);
            
            request.getRequestDispatcher("/WEB-INF/views/order-list.jsp").forward(request, response);
        }
        if ("export".equals(action)) {
            String keyword = request.getParameter("keyword");
            String status = request.getParameter("status");
            List<DonHang> allOrders = donHangDAO.getOrdersForList(keyword, status, null, 1);

            // Thiết lập header cho trình duyệt hiểu là tải file CSV
            response.setContentType("text/csv; charset=UTF-8");
            response.setHeader("Content-Disposition", "attachment; filename=DanhSachDonHang.csv");
            
            // Thêm BOM cho UTF-8 để Excel không bị lỗi font tiếng Việt
            response.getWriter().write('\ufeff');

            try (PrintWriter writer = response.getWriter()) {
                // 1. Ghi tiêu đề cột
                writer.println("Mã Đơn,Khách Hàng,Ngày Đặt,Tổng Tiền,Trạng Thái");

                // 2. Ghi dữ liệu
                for (DonHang dh : allOrders) {
                    writer.printf("%s,%s,%s,%s,%s\n",
                        "YM-" + dh.getMaDonHang(),
                        dh.getTenKhachHang(),
                        dh.getNgayDatHang().toString(),
                        dh.getTongTien(),
                        dh.getTrangThai()
                    );
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
            return;
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        doGet(request, response);
    }
}