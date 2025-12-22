<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Quản lý Khuyến Mãi - YaMe Admin</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.0/font/bootstrap-icons.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/Frontend-master/admin/css/style.css">
</head>

<body>

<!-- SIDEBAR -->
<div class="sidebar">
    <a href="#" class="sidebar-brand">
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

<div class="main-content">

<!-- TOP BAR -->
<div class="top-navbar sticky-top">
    <div class="d-flex align-items-center">
        <h5 class="mb-0 ms-3">Khuyến mãi & Mã giảm giá</h5>
    </div>
</div>

<div class="container-fluid p-4">

<!-- FILTER -->
<form method="get" action="${pageContext.request.contextPath}/admin/promotion">
    <div class="card border-0 shadow-sm mb-4 filter-bar">
        <div class="card-body p-3">
            <div class="row g-3">

                <!-- SEARCH -->
                <div class="col-md-4">
                    <div class="input-group">
                        <span class="input-group-text bg-white border-end-0">
                            <i class="bi bi-search"></i>
                        </span>
                        <input type="text"
                               class="form-control border-start-0 ps-0"
                               placeholder="Tên chương trình, Mã code..."
                               name="keyword"
                               value="${param.keyword}">
                    </div>
                </div>

                <!-- FILTER STATUS -->
                <div class="col-md-3">
                    <select class="form-select" name="status">
                        <option value="">-- Trạng thái --</option>
                        <option value="running" ${param.status=='running'?'selected':''}>
                            Đang diễn ra
                        </option>
                        <option value="upcoming" ${param.status=='upcoming'?'selected':''}>
                            Sắp diễn ra
                        </option>
                        <option value="expired" ${param.status=='expired'?'selected':''}>
                            Đã kết thúc
                        </option>
                    </select>
                </div>

                <!-- BUTTON FILTER -->
                <div class="col-md-5 text-end">
                    <button type="submit" class="btn btn-dark fw-bold">
                        <i class="bi bi-funnel me-1"></i> Lọc
                    </button>

                    <!-- NÚT THÊM -->
                    <button type="button"
                            class="btn btn-success fw-bold ms-2"
                            data-bs-toggle="modal"
                            data-bs-target="#promotionModal">
                        <i class="bi bi-plus-circle me-1"></i> Tạo mã giảm giá
                    </button>
                </div>

            </div>
        </div>
    </div>
</form>

<!-- TABLE -->
<div class="card border-0 shadow-sm">
<div class="card-body p-0">
<div class="table-responsive">

<table class="table table-hover align-middle mb-0">
<thead class="bg-light">
<tr>
    <th class="ps-4">Tên chương trình</th>
    <th>Mã Code</th>
    <th>Mức giảm</th>
    <th>Thời gian áp dụng</th>
    <th>Trạng thái</th>
    <th class="text-end pe-4">Hành động</th>
</tr>
</thead>

<tbody>
<c:forEach var="p" items="${promotions}">
<tr>
    <td class="ps-4">
        <div class="fw-bold">${p.tenKhuyenMai}</div>
    </td>

    <td><span class="coupon-code">KM${p.maKhuyenMai}</span></td>

    <td class="text-danger fw-bold">
        -<fmt:formatNumber value="${p.giaTriGiam}" maxFractionDigits="0"/>%
    </td>

    <td class="small text-muted">
        <fmt:formatDate value="${p.ngayBatDau}" pattern="dd/MM"/> -
        <fmt:formatDate value="${p.ngayKetThuc}" pattern="dd/MM"/>
    </td>

    <td>
        <span class="badge bg-success bg-opacity-10 text-success">Đang chạy</span>
    </td>

    <td class="text-end pe-4">

        <!-- EDIT -->
        <button class="btn btn-light btn-sm border"
                data-bs-toggle="modal"
                data-bs-target="#promotionModal"
                onclick="
                    document.getElementById('action').value='edit';
                    document.getElementById('id').value='${p.maKhuyenMai}';
                    document.getElementById('ten').value='${p.tenKhuyenMai}';
                    document.getElementById('giam').value='${p.giaTriGiam}';
                ">
            <i class="bi bi-pencil-square"></i>
        </button>

        <!-- DELETE -->
        <form method="post"
              action="${pageContext.request.contextPath}/admin/promotion"
              style="display:inline">
            <input type="hidden" name="action" value="delete">
            <input type="hidden" name="id" value="${p.maKhuyenMai}">
            <button class="btn btn-light btn-sm border text-danger"
                    onclick="return confirm('Xóa khuyến mãi này?')">
                <i class="bi bi-trash"></i>
            </button>
        </form>

    </td>
</tr>
</c:forEach>
</tbody>
</table>

<c:if test="${empty promotions}">
    <div class="p-4 text-center text-muted">Chưa có khuyến mãi</div>
</c:if>

</div>
</div>
</div>

</div>
</div>

<!-- MODAL ADD / EDIT -->
<div class="modal fade" id="promotionModal">
<div class="modal-dialog">
<div class="modal-content">

<form method="post" action="${pageContext.request.contextPath}/admin/promotion">

<div class="modal-header">
    <h5 class="modal-title">Khuyến mãi</h5>
</div>

<div class="modal-body">
    <input type="hidden" name="action" id="action" value="add">
    <input type="hidden" name="id" id="id">

    <div class="mb-3">
        <label class="fw-bold">Tên chương trình</label>
        <input class="form-control" name="tenKhuyenMai" id="ten" required>
    </div>

    <div class="mb-3">
        <label class="fw-bold">Giá trị giảm (%)</label>
        <input type="number" class="form-control" name="giaTriGiam" id="giam" required>
    </div>

    <div class="mb-3">
        <label class="fw-bold">Ngày bắt đầu</label>
        <input type="date" class="form-control" name="ngayBatDau" required>
    </div>

    <div class="mb-3">
        <label class="fw-bold">Ngày kết thúc</label>
        <input type="date" class="form-control" name="ngayKetThuc" required>
    </div>

</div>

<div class="modal-footer">
    <button class="btn btn-secondary" data-bs-dismiss="modal">Hủy</button>
    <button class="btn btn-dark">Lưu</button>
</div>

</form>

</div>
</div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
