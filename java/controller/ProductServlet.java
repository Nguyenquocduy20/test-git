package controller;

import java.io.File;
import java.io.IOException;
import java.math.BigDecimal;
import java.util.Date;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import dao.SanPhamDAO;
import model.SanPham;

@WebServlet("/admin/product")
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024, // 1MB
    maxFileSize = 1024 * 1024 * 5,   // 5MB
    maxRequestSize = 1024 * 1024 * 10 // 10MB
)
public class ProductServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    // Thư mục lưu trữ ảnh trong webapp
    private final String UPLOAD_DIR = "Frontend-master/img"; 
    
    private final SanPhamDAO dao = new SanPhamDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        request.setCharacterEncoding("UTF-8");
        String action = request.getParameter("action");

        // --- 1. XỬ LÝ CHUẨN BỊ DỮ LIỆU ĐỂ SỬA (BỎ JSON) ---
        if ("prepareEdit".equals(action)) {
            String idParam = request.getParameter("id");
            Long id = parseLong(idParam);
            if (id != null) {
                SanPham sp = dao.getById(id);
                // Đẩy thực thể SanPham trực tiếp vào request
                request.setAttribute("editProduct", sp);
                // Gửi cờ để JSP biết cần bật Modal sửa
                request.setAttribute("shouldOpenModal", true);
            }
        }

        // --- 2. XỬ LÝ SEARCH + FILTER + HIỂN THỊ DANH SÁCH ---
        String keyword = request.getParameter("keyword");
        String categoryParam = request.getParameter("category");
        String statusParam = request.getParameter("status");

        Long categoryId = parseLong(categoryParam);
        Integer status = (statusParam != null && !statusParam.isEmpty()) ? Integer.parseInt(statusParam) : null;

        // Trả về List<SanPham> trực tiếp (Đã có tính tổng tồn kho trong DAO)
        List<SanPham> products = dao.searchAndFilter(keyword, categoryId, status);

        request.setAttribute("products", products);
        request.getRequestDispatcher("/WEB-INF/views/product-list.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        String action = request.getParameter("action");
        String contextPath = request.getContextPath();
        
        try {
            // --- 1. XỬ LÝ XÓA SẢN PHẨM ---
            if ("delete".equals(action)) {
                Long id = parseLong(request.getParameter("maSanPham"));
                if (id != null) {
                    SanPham sp = dao.getById(id);
                    if (sp != null) {
                        deleteOldImage(sp.getAnhDaiDien(), request);
                        dao.delete(id); 
                    }
                }
                response.sendRedirect(contextPath + "/admin/product");
                return;
            }

            // --- 2. XỬ LÝ THÊM HOẶC CẬP NHẬT ---
            if ("add".equals(action) || "edit".equals(action)) {
                String idParam = request.getParameter("maSanPham");
                String tenSanPham = request.getParameter("tenSanPham");
                Long maDanhMuc = parseLong(request.getParameter("maDanhMuc"));
                BigDecimal giaGoc = parseBigDecimal(request.getParameter("giaGoc"));
                String moTa = request.getParameter("moTa");
                int trangThai = parseInt(request.getParameter("trangThai"), 1);

                SanPham sp;
                boolean isNew = "add".equals(action);

                if (!isNew && idParam != null && !idParam.isEmpty()) {
                    sp = dao.getById(parseLong(idParam));
                } else {
                    sp = new SanPham();
                }

                // Validation dữ liệu
                if (tenSanPham == null || tenSanPham.trim().isEmpty() || giaGoc.compareTo(BigDecimal.ZERO) < 0) {
                    request.setAttribute("errorMessage", "Dữ liệu không hợp lệ!");
                    doGet(request, response);
                    return; 
                }

                sp.setTenSanPham(tenSanPham);
                sp.setMaDanhMuc(maDanhMuc);
                sp.setGiaGoc(giaGoc);
                sp.setMoTa(moTa);
                sp.setTrangThai(trangThai);
                if (sp.getNgayTao() == null) sp.setNgayTao(new Date());

                // XỬ LÝ UPLOAD ẢNH
                Part filePart = request.getPart("file");
                if (filePart != null && filePart.getSize() > 0) {
                    // Nếu sửa, xóa ảnh cũ
                    if (!isNew) deleteOldImage(sp.getAnhDaiDien(), request);
                    
                    String fileName = System.currentTimeMillis() + "_" + filePart.getSubmittedFileName();
                    String uploadPath = getServletContext().getRealPath("") + File.separator + UPLOAD_DIR;
                    
                    File uploadDir = new File(uploadPath);
                    if (!uploadDir.exists()) uploadDir.mkdirs();
                    
                    filePart.write(uploadPath + File.separator + fileName);
                    sp.setAnhDaiDien(fileName);
                } else if (isNew && (sp.getAnhDaiDien() == null)) {
                    sp.setAnhDaiDien("default.png");
                }

                if (isNew) dao.insert(sp);
                else dao.update(sp);

                response.sendRedirect(contextPath + "/admin/product");
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Lỗi: " + e.getMessage());
            doGet(request, response);
        }
    }
    
    private void deleteOldImage(String fileName, HttpServletRequest request) {
        if (fileName != null && !fileName.equals("default.png")) {
            String uploadPath = request.getServletContext().getRealPath("") + File.separator + UPLOAD_DIR;
            File oldFile = new File(uploadPath + File.separator + fileName);
            if (oldFile.exists()) oldFile.delete();
        }
    }

    private Long parseLong(String val) {
        try { return Long.parseLong(val); } catch(Exception e) { return null; }
    }

    private BigDecimal parseBigDecimal(String val) {
        try { return new BigDecimal(val); } catch(Exception e) { return BigDecimal.ZERO; }
    }

    private int parseInt(String val, int def) {
        try { return Integer.parseInt(val); } catch(Exception e) { return def; }
    }
}