<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="vi">

<head>
    <meta charset="UTF-8">
    <title>Quản lý hệ thống - YaMe Admin</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.0/font/bootstrap-icons.css" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/Frontend-master/admin/css/style.css">
    
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <style>
        .product-img-circle {
            width: 45px;
            height: 45px;
            object-fit: cover;
            border: 1px solid #dee2e6;
        }
        .stat-card {
            transition: transform 0.2s;
        }
        .stat-card:hover {
            transform: translateY(-5px);
        }
    </style>
</head>

<body>
    <div class="sidebar">
        <a href="${pageContext.request.contextPath}/admin/dashboard" class="sidebar-brand text-decoration-none">
            <i class="bi bi-shield-check text-warning"></i> YaMe Admin
        </a>

        <ul class="sidebar-menu">
            <li class="menu-header">Tổng quan</li>
            <li><a href="${pageContext.request.contextPath}/admin/dashboard" class="active"><i class="bi bi-speedometer2"></i> Dashboard</a></li>

            <li class="menu-header">Bán hàng</li>
            <li><a href="${pageContext.request.contextPath}/admin/product"><i class="bi bi-box-seam"></i> Quản lý Sản phẩm</a></li>
            <li><a href="${pageContext.request.contextPath}/admin/orders"><i class="bi bi-cart3"></i> Quản lý Đơn hàng</a></li>
            <li><a href="${pageContext.request.contextPath}/admin/promotion-list.html"><i class="bi bi-tags"></i> Quản lý Khuyến mãi</a></li>
            <li><a href="${pageContext.request.contextPath}/admin/customer-list.html"><i class="bi bi-people"></i> Khách hàng</a></li>
            
            <li class="menu-header">Quản trị</li>
            <li><a href="${pageContext.request.contextPath}/admin/employee-list.html"><i class="bi bi-person-badge"></i> Quản lý Nhân viên</a></li>
            <li><a href="${pageContext.request.contextPath}/admin/payment.html"><i class="bi bi-credit-card"></i> Hệ thống Thanh toán</a></li>
            
            <li class="menu-header">Hệ thống</li>
            <li><a href="${pageContext.request.contextPath}/index.jsp"><i class="bi bi-box-arrow-right"></i> Xem Trang chủ</a></li>
        </ul>
    </div>

    <div class="main-content" id="mainContent">
        <div class="top-navbar sticky-top bg-white border-bottom">
            <div class="d-flex align-items-center justify-content-between px-3 py-2">
                <div class="d-flex align-items-center">
                    <button class="btn border-0" id="menu-toggle"><i class="bi bi-list fs-4"></i></button>
                    <h5 class="mb-0 ms-3 fw-bold">Dashboard</h5>
                </div>
                <div class="dropdown me-4">
                    <a href="#" class="text-dark text-decoration-none dropdown-toggle" data-bs-toggle="dropdown">
                        <img src="https://ui-avatars.com/api/?name=Admin+YaMe&background=0D8ABC&color=fff" alt="Admin" class="rounded-circle" width="35">
                        <span class="ms-2 small fw-bold">Admin</span>
                    </a>
                    <ul class="dropdown-menu dropdown-menu-end">
<a href="${pageContext.request.contextPath}/admin?action=profile">Hồ sơ cá nhân</a>                      <li><a class="dropdown-item text-danger" href="#">Đăng xuất</a></li>
                    </ul>
                </div>
            </div>
        </div>

        <div class="container-fluid p-4">
            <div class="row g-3 mb-4">
                <div class="col-md-3">
                    <div class="card border-0 shadow-sm p-3 stat-card">
                        <div class="d-flex justify-content-between align-items-center">
                            <div>
                                <p class="text-muted small mb-1">Tổng doanh thu</p>
                                <h4 class="fw-bold mb-0">
                                    <fmt:formatNumber value="${totalRevenue}" type="number" groupingUsed="true"/>đ
                                </h4>
                            </div>
                            <div class="icon-box bg-success bg-opacity-10 text-success p-2 rounded">
                                <i class="bi bi-currency-dollar fs-4"></i>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-md-3">
                    <div class="card border-0 shadow-sm p-3 stat-card">
                        <div class="d-flex justify-content-between align-items-center">
                            <div>
                                <p class="text-muted small mb-1">Đơn hàng mới</p>
                                <h4 class="fw-bold mb-0">${newOrders}</h4>
                            </div>
                            <div class="icon-box bg-primary bg-opacity-10 text-primary p-2 rounded">
                                <i class="bi bi-cart fs-4"></i>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-md-3">
                    <div class="card border-0 shadow-sm p-3 stat-card">
                        <div class="d-flex justify-content-between align-items-center">
                            <div>
                                <p class="text-muted small mb-1">Sản phẩm</p>
                                <h4 class="fw-bold mb-0">${totalProducts}</h4>
                            </div>
                            <div class="icon-box bg-warning bg-opacity-10 text-warning p-2 rounded">
                                <i class="bi bi-box fs-4"></i>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-md-3">
                    <div class="card border-0 shadow-sm p-3 stat-card">
                        <div class="d-flex justify-content-between align-items-center">
                            <div>
                                <p class="text-muted small mb-1">Khách hàng</p>
                                <h4 class="fw-bold mb-0">${totalCustomers}</h4>
                            </div>
                            <div class="icon-box bg-info bg-opacity-10 text-info p-2 rounded">
                                <i class="bi bi-people fs-4"></i>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <div class="card border-0 shadow-sm mb-4">
                <div class="card-header bg-white py-3 d-flex justify-content-between align-items-center border-bottom">
                    <h6 class="mb-0 fw-bold">Sản phẩm mới cập nhật</h6>
                    <a href="${pageContext.request.contextPath}/admin/product" class="btn btn-dark btn-sm rounded-0 px-3">
                        <i class="bi bi-eye me-1"></i> Xem tất cả
                    </a>
                </div>
                <div class="card-body p-0">
                    <div class="table-responsive">
                        <table class="table table-hover align-middle mb-0">
                            <thead class="table-light">
                                <tr>
                                    <th class="ps-4">Sản phẩm</th>
                                    <th>Giá gốc</th>
                                    <th>Kho</th>
                                    <th>Trạng thái</th>
                                    <th class="text-end pe-4">Hành động</th>
                                </tr>
                            </thead>
                          <tbody>
    <c:forEach var="sp" items="${latestProducts}">
        <tr>
            <td class="ps-4">
                <div class="d-flex align-items-center">
                    <img src="${pageContext.request.contextPath}/Frontend-master/img/${sp.anhDaiDien}" 
                         class="product-img-sm me-3 rounded border" 
                         style="width:45px; height:45px; object-fit:cover"
                         onerror="this.src='https://placehold.co/50x50?text=No+Img'">
                    <div>
                        <div class="fw-bold small">${sp.tenSanPham}</div>
                        <small class="text-muted">Mã: ${sp.maSanPham}</small>
                    </div>
                </div>
            </td>
            <td class="fw-bold text-danger">
                <fmt:formatNumber value="${sp.giaGoc}" type="number" groupingUsed="true"/>đ
            </td>
            <td>
                ${sp.tongSoLuongTon}
            </td>
            <td>
                <c:choose>
                    <c:when test="${sp.tongSoLuongTon > 10}">
                        <span class="badge bg-success bg-opacity-10 text-success">Còn hàng</span>
                    </c:when>
                    <c:when test="${sp.tongSoLuongTon > 0}">
                        <span class="badge bg-warning bg-opacity-10 text-warning">Sắp hết</span>
                    </c:when>
                    <c:otherwise>
                        <span class="badge bg-secondary bg-opacity-10 text-secondary">Hết hàng</span>
                    </c:otherwise>
                </c:choose>
            </td>
            <td class="text-end pe-4">
                <a href="product?action=prepareEdit&id=${sp.maSanPham}" class="btn btn-light btn-sm">
                    <i class="bi bi-pencil"></i>
                </a>
		            </td>
		        </tr>
		    </c:forEach>
			</tbody>
                        </table>
                    </div>
                </div>
            </div>

            <div class="row g-3">
                <div class="col-lg-8">
                    <div class="card border-0 shadow-sm h-100">
                        <div class="card-header bg-white py-3 border-bottom">
                            <h6 class="mb-0 fw-bold">Phân tích doanh thu 2025</h6>
                        </div>
                        <div class="card-body">
                            <canvas id="revenueChart" style="max-height: 300px;"></canvas>
                        </div>
                    </div>
                </div>
                <div class="col-lg-4">
                    <div class="card border-0 shadow-sm h-100">
                        <div class="card-header bg-white py-3 border-bottom">
                            <h6 class="mb-0 fw-bold">Cơ cấu sản phẩm</h6>
                        </div>
                        <div class="card-body d-flex justify-content-center align-items-center">
                            <div style="width: 250px;">
                                <canvas id="categoryChart"></canvas>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        // Toggle Sidebar
        document.getElementById('menu-toggle').addEventListener('click', function() {
            document.querySelector('.sidebar').classList.toggle('active');
            document.getElementById('mainContent').classList.toggle('active');
        });

        // Revenue Chart
        const ctxRevenue = document.getElementById('revenueChart').getContext('2d');
        new Chart(ctxRevenue, {
            type: 'line',
            data: {
                labels: ['T1', 'T2', 'T3', 'T4', 'T5', 'T6'],
                datasets: [{
                    label: 'Doanh thu (triệu)',
                    data: ${not empty revenueDataJson ? revenueDataJson : '[15, 25, 18, 30, 22, 35]'},
                    borderColor: '#0D8ABC',
                    backgroundColor: 'rgba(13, 138, 188, 0.1)',
                    fill: true,
                    tension: 0.4
                }]
            }
        });

        // Category Chart
        const ctxCategory = document.getElementById('categoryChart').getContext('2d');
        new Chart(ctxCategory, {
            type: 'doughnut',
            data: {
                labels: ['Đang bán', 'Ngừng bán'],
                datasets: [{
                    data: [${totalProducts}, 5],
                    backgroundColor: ['#0D8ABC', '#dee2e6']
                }]
            }
        });
    </script>
</body>
</html>