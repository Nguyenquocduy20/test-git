package controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.DonHangDAO;
import dao.KhachHangDAO;
import dao.SanPhamDAO;
import model.SanPham;

/**
 * Servlet implementation class DashboardServlet
 */
@WebServlet("/admin/dashboards")
public class DashboardServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public DashboardServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // 1. Khởi tạo các DAO
        SanPhamDAO spDAO = new SanPhamDAO();
        KhachHangDAO khDAO = new KhachHangDAO();
        DonHangDAO orderDAO = new DonHangDAO();

        // 2. Lấy dữ liệu từ DB
        long totalProducts = spDAO.countAll();
        long totalCustomers = khDAO.countAll();
        double totalRevenue = orderDAO.calculateTotalRevenue();
        long newOrders = orderDAO.countNewOrdersToday();
        
        // Lấy danh sách 5 sản phẩm mới nhất (Cái này đổ vào bảng)
        List<SanPham> latestProducts = spDAO.getTop5Latest(); 

        // 3. ĐẨY DỮ LIỆU SANG JSP (Nếu thiếu bước này JSP sẽ trống)
        request.setAttribute("totalProducts", totalProducts);
        request.setAttribute("totalCustomers", totalCustomers);
        request.setAttribute("totalRevenue", totalRevenue);
        request.setAttribute("newOrders", newOrders);
        request.setAttribute("latestProducts", latestProducts);
        
        // Giả lập dữ liệu biểu đồ nếu chưa có hàm thật
        request.setAttribute("revenueDataJson", "[15, 25, 10, 40, 30, 60]");

        // 4. Forward sang file JSP (Kiểm tra đúng đường dẫn file)
        request.getRequestDispatcher("/WEB-INF/views/dashboard.jsp").forward(request, response);
    }

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
