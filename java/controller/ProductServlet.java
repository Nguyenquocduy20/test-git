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
import dao.ChiTietSanPhamDAO;
import dto.SanPhamDTO;
import model.SanPham;

@WebServlet("/admin/product")
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024, // 1MB
    maxFileSize = 1024 * 1024 * 5,   // 5MB
    maxRequestSize = 1024 * 1024 * 10 // 10MB
)
public class ProductServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    // Đảm bảo tên thư mục ảnh khớp với đường dẫn trong JSP (Frontend-master/img)
    private final String UPLOAD_DIR = "Frontend-master/img"; 
    
    private final SanPhamDAO dao = new SanPhamDAO();
    private final ChiTietSanPhamDAO ctDao = new ChiTietSanPhamDAO();

    /**
     * Xử lý hiển thị danh sách và tải dữ liệu cho modal chỉnh sửa.
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        String idParam = request.getParameter("id");
        
        // --- 1. Xử lý GET JSON (Cho AJAX Edit trong JSP) ---
        if ("getJson".equals(action) && idParam != null) {
            try {
                Long id = Long.parseLong(idParam);
                SanPhamDTO sp = dao.getByIdDTO(id);
                
                response.setContentType("application/json");
                response.setCharacterEncoding("UTF-8");
                // Giả định bạn có một hàm tiện ích để chuyển Object sang JSON
                response.getWriter().write(toJson(sp)); 
                return;
            } catch (Exception e) {
                // Xử lý lỗi nếu ID không hợp lệ hoặc không tìm thấy
                response.sendError(HttpServletResponse.SC_NOT_FOUND, "Product not found or invalid ID.");
                return;
            }
        }
        
        // --- 2. Xử lý GET/Hiển thị Danh sách ---
        List<SanPhamDTO> products = dao.getAll();
        request.setAttribute("products", products);
        
        // Về cơ bản, không cần dùng action=edit ở doGet nữa vì ta dùng AJAX trong JSP
        // Tuy nhiên, nếu muốn giữ lại logic cũ, bạn có thể giữ nguyên đoạn này.
        if ("edit".equals(action) && idParam != null) {
            Long id = parseLong(idParam);
            SanPhamDTO sp = dao.getByIdDTO(id);
            request.setAttribute("editProduct", sp); // Giữ lại dữ liệu cũ khi có lỗi
        }

        request.getRequestDispatcher("/WEB-INF/views/product-list.jsp").forward(request, response);
    }

    /**
     * Xử lý Thêm, Sửa và Xóa (POST request).
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        String action = request.getParameter("action");
        String contextPath = request.getContextPath();
        
        try {
            // --- 1. XỬ LÝ XÓA SẢN PHẨM ---
            if ("delete".equals(action)) {
                String idParam = request.getParameter("maSanPham");
                Long id = parseLong(idParam);
                if (id != null) {
                    SanPham sp = dao.getById(id);
                    if (sp != null) {
                        // Xóa file ảnh cũ trên server (tránh rác)
                        deleteOldImage(sp.getAnhDaiDien(), request);
                        
                        // Xóa trong DB
                        dao.delete(id); 
                    }
                }
                // Chuyển hướng sau khi xóa
                response.sendRedirect(contextPath + "/admin/product");
                return;
            }

            // --- 2. XỬ LÝ THÊM HOẶC SỬA SẢN PHẨM ---
            if ("add".equals(action) || "edit".equals(action)) {
                String idParam = request.getParameter("maSanPham");
                String tenSanPham = request.getParameter("tenSanPham");
                Long maDanhMuc = parseLong(request.getParameter("maDanhMuc"));
                BigDecimal giaGoc = parseBigDecimal(request.getParameter("giaGoc"));
                String moTa = request.getParameter("moTa");
                // chatLieu không có trong JSP, bỏ qua hoặc thêm nếu cần
                // String chatLieu = request.getParameter("chatLieu"); 
                int trangThai = parseInt(request.getParameter("trangThai"), 1);

                SanPham sp;
                boolean isNew = "add".equals(action);

                if (!isNew && idParam != null && !idParam.isEmpty()) {
                    sp = dao.getById(parseLong(idParam));
                } else {
                    sp = new SanPham();
                }

                // VALIDATION: Kiểm tra dữ liệu bắt buộc (ví dụ: tên, giá)
                if (tenSanPham == null || tenSanPham.trim().isEmpty() || giaGoc.compareTo(BigDecimal.ZERO) < 0) {
                    request.setAttribute("errorMessage", "Vui lòng nhập đầy đủ Tên sản phẩm và Giá bán hợp lệ.");
                    // Đặt lại đối tượng sp để giữ lại dữ liệu form (editProduct)
                    request.setAttribute("editProduct", dao.convertToDTO(sp)); 
                    // Chuyển hướng trở lại trang danh sách (giữ modal mở)
                    doGet(request, response);
                    return; 
                }

                sp.setTenSanPham(tenSanPham);
                sp.setMaDanhMuc(maDanhMuc);
                sp.setGiaGoc(giaGoc);
                sp.setMoTa(moTa);
                // sp.setChatLieu(chatLieu); 
                sp.setTrangThai(trangThai);
                if (sp.getNgayTao() == null) sp.setNgayTao(new Date());

                // Xử lý upload ảnh
                Part filePart = request.getPart("file");
                if (filePart != null && filePart.getSize() > 0) {
                    // Nếu là edit, xóa ảnh cũ trước khi upload ảnh mới
                    if (!isNew) deleteOldImage(sp.getAnhDaiDien(), request);
                    
                    String submittedFileName = filePart.getSubmittedFileName();
                    String fileExtension = submittedFileName.substring(submittedFileName.lastIndexOf('.'));
                    String fileName = System.currentTimeMillis() + fileExtension;
                    
                    String uploadPath = getServletContext().getRealPath("") + File.separator + UPLOAD_DIR;
                    File uploadDir = new File(uploadPath);
                    if (!uploadDir.exists()) uploadDir.mkdirs();
                    
                    filePart.write(uploadPath + File.separator + fileName);
                    sp.setAnhDaiDien(fileName);
                } else if (isNew && sp.getAnhDaiDien() == null) {
                    // Chỉ set default.png nếu là thêm mới và chưa có ảnh
                    sp.setAnhDaiDien("default.png");
                }

                if (isNew) dao.insert(sp);
                else dao.update(sp);

                // Chuyển hướng sau khi thành công
                response.sendRedirect(contextPath + "/admin/product");
            }
        } catch (Exception e) {
            e.printStackTrace();
            // Xử lý lỗi chung (ví dụ: lỗi DB, lỗi file upload)
            request.setAttribute("errorMessage", "Đã xảy ra lỗi trong quá trình xử lý: " + e.getMessage());
            doGet(request, response); // Quay lại trang danh sách kèm thông báo lỗi
        }
    }
    
    /**
     * Hàm tiện ích để xóa ảnh cũ trên Server (tránh rác)
     */
    private void deleteOldImage(String fileName, HttpServletRequest request) {
        if (fileName != null && !fileName.equals("default.png")) {
            String uploadPath = request.getServletContext().getRealPath("") + File.separator + UPLOAD_DIR;
            File oldFile = new File(uploadPath + File.separator + fileName);
            if (oldFile.exists()) {
                oldFile.delete();
            }
        }
    }


    /* ========== HÀM TIỆN ÍCH PARSE DỮ LIỆU ========== */

    private Long parseLong(String val) {
        try { return Long.parseLong(val); } catch(Exception e) { return null; }
    }

    private BigDecimal parseBigDecimal(String val) {
        try { return new BigDecimal(val); } catch(Exception e) { return BigDecimal.ZERO; }
    }

    private int parseInt(String val, int def) {
        try { return Integer.parseInt(val); } catch(Exception e) { return def; }
    }
    
    // Hàm tiện ích toJson (Cần thiết cho AJAX trong JSP đã sửa)
    private String toJson(SanPhamDTO sp) {
        // Đây là đoạn code giả lập, bạn cần sử dụng thư viện như Gson hoặc Jackson 
        // để chuyển đổi đối tượng Java thành JSON String thực tế.
        return String.format(
            "{\"maSanPham\":%d, \"tenSanPham\":\"%s\", \"maDanhMuc\":%d, \"giaGoc\":%.2f, \"moTa\":\"%s\", \"trangThai\":%d, \"anhDaiDien\":\"%s\"}",
            sp.getMaSanPham(), sp.getTenSanPham(), sp.getMaDanhMuc(), sp.getGiaGoc(), 
            sp.getMoTa() != null ? sp.getMoTa().replace("\"", "\\\"") : "", 
            sp.getTrangThai(), sp.getAnhDaiDien()
        );
    }
}