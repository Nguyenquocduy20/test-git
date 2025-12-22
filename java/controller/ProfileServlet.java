package controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class ProfileServlet
 */
@WebServlet("/ProfileServlet")
public class ProfileServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ProfileServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");

        // Giả sử sau này bạn lấy dữ liệu từ DB, bạn sẽ set vào attribute ở đây
        // request.setAttribute("username", "Huỳnh Văn Hiền");

        // Forward sang file JSP (để file profile.jsp ở thư mục gốc WebContent/webapp)
        request.getRequestDispatcher("/WEB-INF/views/profile.jsp").forward(request, response);
    }

    // doPost dùng để xử lý khi nhấn nút "Lưu thay đổi" hoặc "Cập nhật"
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        
        // Lấy dữ liệu từ các ô input trong file profile.jsp
        String firstName = request.getParameter("firstName");
        String lastName = request.getParameter("lastName");
        String phone = request.getParameter("phone");

        // Logic xử lý: Lưu vào Database hoặc thông báo thành công
        System.out.println("Đã cập nhật: " + firstName + " " + lastName);

        // Sau khi lưu xong, tải lại trang profile
        response.sendRedirect(request.getContextPath() + "/profile?status=success");
    }
}