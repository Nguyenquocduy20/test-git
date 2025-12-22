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
    <style>
        .image-preview-container {
            width: 100%;
            min-height: 140px;
            border: 2px dashed #cbd5e0;
            border-radius: 8px;
            display: flex;
            align-items: center;
            justify-content: center;
            background-color: #f8fafc;
            overflow: hidden;
            margin-top: 8px;
        }
        #imagePreview {
            max-width: 100%;
            max-height: 180px;
            display: none;
        }
        .preview-text { color: #a0aec0; font-size: 0.85rem; }
        .table thead { background-color: #f8f9fa; }
        .badge-stock { font-size: 0.9rem; padding: 0.5em 0.7em; }
    </style>
</head>

<body>
 <div class="sidebar">
    <a href="${pageContext.request.contextPath}/admin/dashboard" class="sidebar-brand">
        <i class="bi bi-shield-check text-warning"></i> YaMe Admin
    </a>

      <ul class="sidebar-menu">
    <li class="menu-header">Tổng quan</li>
    <li><a href="${pageContext.request.contextPath}/admin/dashboards"><i class="bi bi-speedometer2"></i> Dashboard</a></li>

    <li class="menu-header">Bán hàng</li>
    <li><a href="${pageContext.request.contextPath}/admin/product"><i class="bi bi-box-seam"></i> Quản lý Sản phẩm</a></li>
    
    <li><a href="${pageContext.request.contextPath}/admin/orders"><i class="bi bi-cart3"></i> Quản lý Đơn hàng</a></li>
    
    <li><a href="${pageContext.request.contextPath}/admin/promotion"><i class="bi bi-tags"></i> Quản lý Khuyến mãi</a></li>
    <li><a href="${pageContext.request.contextPath}/admin/customers"><i class="bi bi-people"></i> Khách hàng</a></li>
    
    <li class="menu-header">Quản trị</li>
    <li><a href="${pageContext.request.contextPath}/admin/employees"><i class="bi bi-person-badge"></i> Quản lý Nhân viên</a></li>
    
    <li class="menu-header">Hệ thống</li>
    <li><a href="${pageContext.request.contextPath}/index.jsp"><i class="bi bi-box-arrow-right"></i> Xem Trang chủ</a></li>
</ul>
</div>

    <div class="main-content" id="mainContent">

        <div class="top-navbar sticky-top">
            <div class="d-flex align-items-center">
                <button class="btn border-0" id="menu-toggle"><i class="bi bi-list fs-4"></i></button>
                <h5 class="mb-0 ms-3">Sản phẩm</h5>
            </div>
            <div class="d-flex align-items-center gap-3">
                <div class="dropdown me-4">
                    <a href="#" class="text-dark text-decoration-none dropdown-toggle" data-bs-toggle="dropdown">
                        <img src="https://ui-avatars.com/api/?name=Admin+YaMe&background=0D8ABC&color=fff" alt="Admin"
                            class="rounded-circle" width="35">
                        <span class="ms-2 small fw-bold">Admin</span>
                    </a>
                    <ul class="dropdown-menu dropdown-menu-end">
                        <li><a class="dropdown-item" href="profile.html">Hồ sơ</a></li>
                        <li><a class="dropdown-item text-danger" href="#">Đăng xuất</a></li>
                    </ul>
                </div>
            </div>
        </div>
    
    <div class="container-fluid p-4">
        <div class="card border-0 shadow-sm mb-4 filter-bar">
            <div class="card-body p-3">
                <form method="get" action="product">
                    <div class="row g-3 align-items-end">
                        <div class="col-md-3">
                            <label class="small fw-bold mb-1">Từ khóa</label>
                            <input type="text" class="form-control" placeholder="Tìm tên..." name="keyword" value="${param.keyword}">
                        </div>
                        <div class="col-md-2">
                            <label class="small fw-bold mb-1">Danh mục</label>
                            <select class="form-select" name="category">
                                <option value="">Tất cả</option>
                                <option value="1" ${param.category == '1' ? 'selected' : ''}>Áo Thun</option>
                                <option value="2" ${param.category == '2' ? 'selected' : ''}>Áo Khoác</option>
                            </select>
                        </div>
                        <div class="col-md-2">
                            <label class="small fw-bold mb-1">Trạng thái</label>
                            <select class="form-select" name="status">
                                <option value="">Tất cả</option>
                                <option value="1" ${param.status == '1' ? 'selected' : ''}>Đang bán</option>
                                <option value="0" ${param.status == '0' ? 'selected' : ''}>Ẩn</option>
                            </select>
                        </div>
                        <div class="col-md-5">
                            <div class="d-flex gap-2">
                                <button type="submit" class="btn btn-dark fw-bold w-50">
                                    <i class="bi bi-funnel"></i> Lọc dữ liệu
                                </button>
                                <button type="button" class="btn btn-primary fw-bold w-50 text-white" onclick="showAddForm()">
                                    <i class="bi bi-plus-lg"></i> Thêm sản phẩm
                                </button>
                            </div>
                        </div>
                    </div>
                </form>
            </div>
        </div>

        <div class="card shadow-sm">
            <div class="card-body p-0">
                <table class="table table-hover align-middle mb-0">
                    <thead>
                        <tr>
                            <th class="ps-4">Sản phẩm</th>
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
                                             style="width:45px;height:45px;object-fit:cover" onerror="this.src='https://placehold.co/50x50?text=No+Img'" class="me-3 rounded border">
                                        <div><div class="fw-bold">${sp.tenSanPham}</div><small class="text-muted">ID: ${sp.maSanPham}</small></div>
                                    </div>
                                </td>
                                <td>${sp.maDanhMuc}</td>
                                <td class="fw-bold"><fmt:formatNumber value="${sp.giaGoc}" type="currency" currencySymbol="đ"/></td>
                                <td>
                                    <span class="badge rounded-pill bg-light text-dark border badge-stock">
                                        ${sp.tongSoLuongTon}
                                    </span>
                                </td>
                                <td><span class="badge ${sp.trangThai == 1 ? 'text-bg-success' : 'text-bg-secondary'}">${sp.trangThai == 1 ? 'Đang bán' : 'Ẩn'}</span></td>
                                <td class="text-end pe-4">
                                    <a href="product?action=prepareEdit&id=${sp.maSanPham}" class="btn btn-sm btn-light border text-primary"><i class="bi bi-pencil-square"></i></a>
                                    <form action="product" method="post" style="display:inline-block;">
                                        <input type="hidden" name="action" value="delete"><input type="hidden" name="maSanPham" value="${sp.maSanPham}">
                                        <button type="submit" class="btn btn-sm btn-light border text-danger" onclick="return confirm('Bạn chắc chắn muốn xóa sản phẩm này?')"><i class="bi bi-trash"></i></button>
                                    </form>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>

<div class="modal fade" id="productModal" data-bs-backdrop="static" tabindex="-1">
    <div class="modal-dialog modal-lg">
        <div class="modal-content border-0 shadow-lg">
            <form id="productForm" method="post" enctype="multipart/form-data" action="product">
                <div class="modal-header bg-dark text-white">
                    <h5 class="modal-title" id="modalTitle">${editProduct != null ? "Chỉnh sửa sản phẩm" : "Thêm mới sản phẩm"}</h5>
                    <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" onclick="closeAndRefresh()"></button>
                </div>
                <div class="modal-body">
                    <input type="hidden" name="action" id="modalAction" value="${editProduct != null ? 'edit' : 'add'}">
                    <input type="hidden" name="maSanPham" id="modalMaSanPham" value="${editProduct.maSanPham}">
                    
                    <div class="row">
                        <div class="col-md-8 mb-3">
                            <label class="fw-bold mb-1">Tên sản phẩm</label>
                            <input name="tenSanPham" id="modalTen" class="form-control" value="${editProduct.tenSanPham}" required>
                        </div>
                        <div class="col-md-4 mb-3">
                            <label class="fw-bold mb-1">Danh mục</label>
                            <input name="maDanhMuc" id="modalDM" type="number" class="form-control" value="${editProduct.maDanhMuc}" required>
                        </div>
                    </div>
                    
                    <div class="row">
                        <div class="col-md-6 mb-3">
                            <label class="fw-bold mb-1">Giá bán (đ)</label>
                            <input name="giaGoc" id="modalGia" type="number" class="form-control" value="${editProduct.giaGoc}" required>
                        </div>
                        <div class="col-md-6 mb-3">
                            <label class="fw-bold mb-1">Số lượng tồn kho</label>
                            <input name="tongSoLuongTon" id="modalTonKho" type="number" class="form-control" value="${editProduct.tongSoLuongTon != null ? editProduct.tongSoLuongTon : 0}" required>
                        </div>
                    </div>

                    <div class="mb-3">
                        <label class="fw-bold mb-1">Mô tả sản phẩm</label>
                        <textarea name="moTa" id="modalMoTa" class="form-control" rows="3" placeholder="Nhập mô tả chi tiết...">${editProduct.moTa}</textarea>
                    </div>

                    <div class="mb-3">
                        <label class="fw-bold mb-1">Ảnh đại diện</label>
                        <input type="file" name="file" id="imageInput" class="form-control" accept="image/*">
                        <div class="image-preview-container">
                            <span class="preview-text" id="previewText">Chưa có ảnh nào được chọn</span>
                            <img id="imagePreview" src="${not empty editProduct.anhDaiDien ? pageContext.request.contextPath.concat('/Frontend-master/img/').concat(editProduct.anhDaiDien) : ''}" 
                                 style="${not empty editProduct.anhDaiDien ? 'display:block' : 'display:none'}">
                        </div>
                    </div>
                    
                    <div class="mb-3">
                        <label class="fw-bold mb-1">Trạng thái kinh doanh</label>
                        <select name="trangThai" id="modalTrangThai" class="form-select">
                            <option value="1" ${editProduct.trangThai == 1 ? 'selected' : ''}>Đang bán</option>
                            <option value="0" ${editProduct.trangThai == 0 ? 'selected' : ''}>Ẩn / Ngừng bán</option>
                        </select>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal" onclick="closeAndRefresh()">Hủy bỏ</button>
                    <button type="submit" class="btn btn-dark px-4">Lưu dữ liệu</button>
                </div>
            </form>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script>
    const productModal = new bootstrap.Modal(document.getElementById('productModal'));
    const imageInput = document.getElementById('imageInput');
    const imagePreview = document.getElementById('imagePreview');
    const previewText = document.getElementById('previewText');

    // Logic xem trước ảnh cực nhanh
    imageInput.addEventListener('change', function() {
        const file = this.files[0];
        if (file) {
            const reader = new FileReader();
            reader.onload = function(e) {
                imagePreview.src = e.target.result;
                imagePreview.style.display = 'block';
                previewText.style.display = 'none';
            }
            reader.readAsDataURL(file);
        }
    });

    // Mở form Thêm mới (Reset toàn bộ)
    function showAddForm() {
        document.getElementById('productForm').reset();
        document.getElementById('modalTitle').innerText = "Thêm mới sản phẩm";
        document.getElementById('modalAction').value = "add";
        document.getElementById('modalMaSanPham').value = "";
        document.getElementById('modalMoTa').value = "";
        document.getElementById('modalTonKho').value = "0"; 
        imagePreview.style.display = 'none';
        imagePreview.src = "";
        previewText.style.display = 'block';
        productModal.show();
    }

    // Đóng và làm sạch URL
    function closeAndRefresh() {
        window.location.href = 'product';
    }

    // Tự động bật Modal nếu Servlet yêu cầu sửa (Edit)
    document.addEventListener('DOMContentLoaded', function () {
        <c:if test="${shouldOpenModal == true}">
            if (imagePreview.getAttribute('src') !== "" && imagePreview.getAttribute('src') !== null) {
                imagePreview.style.display = 'block';
                previewText.style.display = 'none';
            }
            productModal.show();
        </c:if>
        
        // Menu toggle cho sidebar
        const menuToggle = document.getElementById('menu-toggle');
        if (menuToggle) {
            menuToggle.addEventListener('click', function() {
                document.querySelector('.sidebar').classList.toggle('active');
            });
        }
    });
</script>
</body>
</html>