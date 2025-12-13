<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="vi">

<head>
    <meta charset="UTF-8">
    <title>Quản lý sản phẩm - YaMe Admin</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.0/font/bootstrap-icons.css" rel="stylesheet">

    <link rel="stylesheet" href="${pageContext.request.contextPath}/Frontend-master/admin/css/style.css">
</head>

<body>

<div class="sidebar">
    <a href="${pageContext.request.contextPath}/admin/dashboard" class="sidebar-brand">
        <i class="bi bi-shield-check text-warning"></i> YaMe Admin
    </a>

    <ul class="sidebar-menu">
        <li class="menu-header">Tổng quan</li>
        <li><a href="${pageContext.request.contextPath}/admin/dashboard"><i class="bi bi-speedometer2"></i> Dashboard</a></li>

        <li class="menu-header">Bán hàng</li>
        <li>
            <a class="active" href="${pageContext.request.contextPath}/admin/product">
                <i class="bi bi-box-seam"></i> Quản lý Sản phẩm
            </a>
        </li>
        <li><a href="${pageContext.request.contextPath}/admin/order-list.html"><i class="bi bi-cart3"></i> Quản lý Đơn hàng</a></li>
        <li><a href="${pageContext.request.contextPath}/admin/promotion-list.html"><i class="bi bi-tags"></i> Quản lý Khuyến mãi</a></li>
        
        <li><a href="${pageContext.request.contextPath}/admin/customer-list.html"><i class="bi bi-people"></i> Khách hàng</a></li>
        
        <li class="menu-header">Quản trị</li>
        <li><a href="${pageContext.request.contextPath}/admin/employee-list.html"><i class="bi bi-person-badge"></i> Quản lý Nhân viên</a></li>
        <li><a href="${pageContext.request.contextPath}/admin/payment.html"><i class="bi bi-credit-card"></i> Hệ thống Thanh toán</a></li>
        
        <li class="menu-header">Hệ thống</li>
        <li><a href="${pageContext.request.contextPath}/index.jsp">
            <i class="bi bi-box-arrow-right"></i> Xem Trang chủ
        </a></li>
    </ul>
</div>

<div class="main-content">

    <div class="top-navbar sticky-top">
        <div class="d-flex align-items-center">
            <h5 class="mb-0 ms-3">Sản phẩm</h5>
        </div>
        
        <div class="dropdown me-4">
            <a href="#" class="text-dark text-decoration-none dropdown-toggle" data-bs-toggle="dropdown">
                <img src="https://ui-avatars.com/api/?name=Admin+YaMe&background=0D8ABC&color=fff"
                     class="rounded-circle" width="35">
                <span class="ms-2 small fw-bold">Admin</span>
            </a>
            <ul class="dropdown-menu dropdown-menu-end">
                <li><a class="dropdown-item" href="#">Hồ sơ</a></li>
                <li><a class="dropdown-item text-danger" href="#">Đăng xuất</a></li>
            </ul>
        </div>
    </div>
    
	
    <div class="container-fluid p-4">
    
        <div class="card border-0 shadow-sm mb-4 filter-bar">
            <div class="card-body p-3">
                <div class="row g-3">
                    
                    <div class="col-md-4">
                        <div class="input-group">
                            <span class="input-group-text bg-white border-end-0"><i class="bi bi-search"></i></span>
                            <input type="text" class="form-control border-start-0 ps-0"
                                   placeholder="Tìm theo tên, mã sản phẩm..."
                                   name="searchKeyword">
                        </div>
                    </div>

                    <div class="col-md-3">
                        <select class="form-select" name="filterCategory">
                            <option value="" selected>-- Tất cả danh mục --</option>
                            <option value="1">Áo Thun</option>
                            <option value="2">Áo Khoác</option>
                            <option value="3">Quần Jean</option>
                            <option value="4">Phụ Kiện</option>
                             </select>
                    </div>

                    <div class="col-md-3">
                        <select class="form-select" name="filterStatus">
                            <option value="" selected>-- Trạng thái --</option>
                            <option value="1">Đang bán</option>
                            <option value="2">Hết hàng</option>
                            <option value="0">Ngừng kinh doanh</option>
                        </select>
                    </div>

                    <div class="col-md-2 text-end">
                        <button id="btnAdd" class="btn btn-dark w-100 fw-bold"
                                data-bs-toggle="modal"
                                data-bs-target="#productModal">
                            <i class="bi bi-plus-lg me-1"></i> Thêm mới
                        </button>
                    </div>
                </div>
            </div>
        </div>
        <div class="card shadow-sm">
            <div class="card-body p-0">
                <table class="table table-hover align-middle mb-0">
                    <thead class="bg-light">
                        <tr>
                            <th class="ps-4" style="width: 40%;">Tên sản phẩm</th>
                            <th>Danh mục</th>
                            <th>Giá bán</th>
                            <th>Tồn kho</th>
                            <th>Trạng thái</th>
                            <th class="text-end pe-4">Thao tác</th>
                        </tr>
                    </thead>
                    <tbody>

                    <c:forEach var="sp" items="${products}">
                        <tr>
                            <td class="ps-4">
                                <div class="d-flex align-items-center">
                                    <img src="${pageContext.request.contextPath}/Frontend-master/img/${sp.anhDaiDien}"
                                         style="width:50px;height:50px;object-fit:cover"
                                         onerror="this.onerror=null; this.src='${pageContext.request.contextPath}/Frontend-master/img/default.png';"
                                         class="me-3 rounded">
                                    <div>
                                        <div class="fw-bold">${sp.tenSanPham}</div>
                                        <small class="text-muted">Mã: ${sp.maSanPham}</small>
                                    </div>
                                </div>
                            </td>
                            <td>${sp.maDanhMuc}</td>
                            <td>
                                <fmt:formatNumber value="${sp.giaGoc}" type="currency" currencySymbol="VNĐ" maxFractionDigits="0"/>
                            </td>
                            <td>${sp.tongSoLuongTon}</td>
                            <td>
                                <c:choose>
                                    <c:when test="${sp.trangThai == 1}">
                                        <span class="badge text-bg-success">Đang bán</span>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="badge text-bg-secondary">Ẩn</span>
                                    </c:otherwise>
                                </c:choose>
                            </td>
                            <td class="text-end pe-4">
                                <button class="btn btn-sm btn-light border btn-edit-product"
                                        data-bs-toggle="modal"
                                        data-bs-target="#productModal"
                                        data-id="${sp.maSanPham}">
                                    <i class="bi bi-pencil-square"></i>
                                </button>
                                
                                <form action="${pageContext.request.contextPath}/admin/product" method="post" style="display:inline-block;">
                                    <input type="hidden" name="action" value="delete"/>
                                    <input type="hidden" name="maSanPham" value="${sp.maSanPham}"/>
                                    <button type="submit" class="btn btn-sm btn-light border text-danger"
                                            onclick="return confirm('Bạn có chắc chắn muốn xóa sản phẩm ${sp.maSanPham} không? Hành động này không thể hoàn tác.')">
                                        <i class="bi bi-trash"></i>
                                    </button>
                                </form>
                            </td>
                        </tr>
                    </c:forEach>

                    </tbody>
                </table>
                
                <c:if test="${empty products}">
                     <div class="p-4 text-center text-muted">Chưa có sản phẩm nào được thêm vào.</div>
                </c:if>
            </div>
        </div>
    </div>
</div>

<div class="modal fade" id="productModal">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">

            <form id="productForm" method="post"
                  enctype="multipart/form-data"
                  action="${pageContext.request.contextPath}/admin/product">

                <div class="modal-header bg-dark text-white">
                    <h5 class="modal-title" id="modalTitle">Thêm sản phẩm</h5>
                    <button class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
                </div>

                <div class="modal-body">
                    <input type="hidden" name="action" id="modalAction" value="add">
                    <input type="hidden" name="maSanPham" id="modalMaSanPham">

                    <c:if test="${not empty errorMessage}">
                        <div class="alert alert-danger">${errorMessage}</div>
                    </c:if>

                    <div class="mb-3">
                        <label class="fw-bold">Tên sản phẩm</label>
                        <input name="tenSanPham" id="modalTenSanPham" class="form-control" required>
                    </div>

                    <div class="row">
                        <div class="col-md-6 mb-3">
                            <label class="fw-bold">Danh mục</label>
                            <input name="maDanhMuc" id="modalMaDanhMuc" class="form-control" required>
                        </div>
                        <div class="col-md-6 mb-3">
                            <label class="fw-bold">Giá bán</label>
                            <input name="giaGoc" type="number" id="modalGiaGoc" class="form-control" min="0" required>
                        </div>
                    </div>

                    <div class="mb-3">
                        <label class="fw-bold">Mô tả</label>
                        <textarea name="moTa" id="modalMoTa" class="form-control" rows="3"></textarea>
                    </div>

                    <div class="mb-3">
                        <label class="fw-bold">Ảnh đại diện</label>
                        <input type="file" name="file" id="modalFile" class="form-control">
                        <img id="previewImg" src="#" style="max-height: 100px; margin-top: 10px; display:none;">
                    </div>
                    
                    <div class="mb-3">
                        <label class="fw-bold">Trạng thái</label>
                        <select name="trangThai" id="modalTrangThai" class="form-select">
                            <option value="1">Đang bán</option>
                            <option value="0">Ẩn</option>
                        </select>
                    </div>
                </div>

                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Hủy</button>
                    <button type="submit" class="btn btn-dark">Lưu</button>
                </div>
            </form>

        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

<script>
    document.addEventListener('DOMContentLoaded', function () {
        const productModal = new bootstrap.Modal(document.getElementById('productModal'));
        const modalTitle = document.getElementById('modalTitle');
        const modalForm = document.getElementById('productForm');
        
        // Hàm reset form
        function resetModal() {
            modalTitle.innerText = 'Thêm sản phẩm';
            modalForm.reset();
            document.getElementById('modalAction').value = 'add';
            document.getElementById('modalMaSanPham').value = '';
            document.getElementById('previewImg').style.display = 'none';
        }

        // --- 1. XỬ LÝ KHI NHẤN NÚT "THÊM MỚI" ---
        document.getElementById('btnAdd').addEventListener('click', resetModal); // Sử dụng ID btnAdd
        
        // Bắt sự kiện khi Modal đóng để reset form
        document.getElementById('productModal').addEventListener('hidden.bs.modal', resetModal);

        // Xử lý nút EDIT (Dùng AJAX để lấy dữ liệu)
        document.querySelectorAll('.btn-edit-product').forEach(button => {
            button.addEventListener('click', function() {
                const id = this.getAttribute('data-id');
                
                // ĐƯỜNG DẪN API TRẢ VỀ JSON ĐÃ ĐƯỢC ÁNH XẠ ĐÚNG
                fetch('${pageContext.request.contextPath}/admin/product?action=getJson&id=' + id) 
                    .then(response => response.json())
                    .then(sp => {
                        modalTitle.innerText = 'Sửa sản phẩm';
                        document.getElementById('modalAction').value = 'edit';
                        
                        // Đổ dữ liệu vào form
                        document.getElementById('modalMaSanPham').value = sp.maSanPham;
                        document.getElementById('modalTenSanPham').value = sp.tenSanPham;
                        document.getElementById('modalMaDanhMuc').value = sp.maDanhMuc;
                        document.getElementById('modalGiaGoc').value = sp.giaGoc;
                        document.getElementById('modalMoTa').value = sp.moTa;
                        document.getElementById('modalTrangThai').value = sp.trangThai;
                        
                        // Hiển thị ảnh cũ (ĐƯỜNG DẪN ẢNH ĐÃ ĐƯỢC ÁNH XẠ ĐÚNG)
                        const imgSrc = `${pageContext.request.contextPath}/Frontend-master/img/${sp.anhDaiDien}`;
                        const preview = document.getElementById('previewImg');
                        preview.src = imgSrc;
                        preview.style.display = 'block';

                        productModal.show();
                    })
                    .catch(error => console.error('Lỗi khi lấy dữ liệu sản phẩm:', error));
            });
        });
        
        // --- XỬ LÝ TỰ ĐỘNG MỞ MODAL KHI CÓ LỖI (Dùng JSTL) ---
        <c:if test="${editProduct != null || not empty errorMessage}">
            // Đổ lại dữ liệu cũ vào Modal khi có lỗi xác thực từ Server
            document.getElementById('modalTitle').innerText = '${editProduct != null ? "Sửa sản phẩm" : "Thêm sản phẩm"}';
            document.getElementById('modalAction').value = '${editProduct != null ? "edit" : "add"}';
            document.getElementById('modalMaSanPham').value = '${editProduct.maSanPham}';
            document.getElementById('modalTenSanPham').value = '${editProduct.tenSanPham}';
            document.getElementById('modalMaDanhMuc').value = '${editProduct.maDanhMuc}';
            document.getElementById('modalGiaGoc').value = '${editProduct.giaGoc}';
            document.getElementById('modalMoTa').value = '${editProduct.moTa}';
            document.getElementById('modalTrangThai').value = '${editProduct.trangThai}';
            
            // Đường dẫn ảnh cũ khi lỗi (ĐÃ ĐƯỢC ÁNH XẠ ĐÚNG)
            const currentImg = '${editProduct.anhDaiDien}';
            if(currentImg) {
                 document.getElementById('previewImg').src = '${pageContext.request.contextPath}/Frontend-master/img/' + currentImg;
                 document.getElementById('previewImg').style.display = 'block';
            }

            productModal.show();
        </c:if>
    });
</script>

</body>
</html>