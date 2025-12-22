package controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class AdminServlet
 */
@WebServlet("/admin")
public class AdminServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AdminServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Thiết lập tiếng Việt
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");

        // Lấy tham số 'action' từ URL
        String action = request.getParameter("action");

        if (action == null) {
            action = "dashboard"; // Mặc định vào dashboard nếu không có tham số
        }

        switch (action) {
            case "profile":
                // Forward sang trang profile.jsp (Giả sử file nằm trong WebContent/admin/profile.jsp)
                request.getRequestDispatcher("/WEB-INF/views/profile.jsp").forward(request, response);
                break;
                
            case "dashboard":
                // Forward sang trang index.jsp (hoặc trang dashboard chính của bạn)
                request.getRequestDispatcher("/WEB-INF/views/index.jsp").forward(request, response);
                break;

            default:
                request.getRequestDispatcher("/WEB-INF/views/index.jsp").forward(request, response);
                break;
        }
    }

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
