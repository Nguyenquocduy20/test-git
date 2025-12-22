package controller;

import java.io.IOException;
import java.sql.Date;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.PromotionDAO;
import model.Promotion;

@WebServlet("/admin/promotion")
public class PromotionServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private PromotionDAO promotionDAO = new PromotionDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String keyword = request.getParameter("keyword");
        String status = request.getParameter("status");

        List<Promotion> list = promotionDAO.getAll(keyword, status);

        request.setAttribute("promotions", list);
        request.getRequestDispatcher("/WEB-INF/views/promotion-list.jsp")
               .forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");

        try {
            if ("add".equals(action)) {
                Promotion p = buildPromotion(request);
                promotionDAO.insert(p);
            }

            if ("edit".equals(action)) {
                Promotion p = buildPromotion(request);
                p.setMaKhuyenMai(
                        Long.parseLong(request.getParameter("id"))
                );
                promotionDAO.update(p);
            }

            if ("delete".equals(action)) {
                Long id = Long.parseLong(request.getParameter("id"));
                promotionDAO.delete(id);
            }

            response.sendRedirect(request.getContextPath() + "/admin/promotion");

        } catch (Exception e) {
            throw new ServletException(e);
        }
    }

    private Promotion buildPromotion(HttpServletRequest req) {

        Promotion p = new Promotion();

        p.setTenKhuyenMai(req.getParameter("tenKhuyenMai"));
        p.setGiaTriGiam(Double.parseDouble(req.getParameter("giaTriGiam")));

        p.setNgayBatDau(Date.valueOf(req.getParameter("ngayBatDau")));
        p.setNgayKetThuc(Date.valueOf(req.getParameter("ngayKetThuc")));

        return p;
    }
}
