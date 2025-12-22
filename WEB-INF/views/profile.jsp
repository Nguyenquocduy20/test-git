<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Hồ sơ Admin - YaMe Admin</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.0/font/bootstrap-icons.css">
    
    <link rel="stylesheet" href="${pageContext.request.contextPath}/Frontend-master/admin/css/style.css">
</head>

<body>

    <div class="sidebar" id="sidebar">
        <a href="${pageContext.request.contextPath}/admin?action=dashboard" class="sidebar-brand text-decoration-none">
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

        <div class="top-navbar sticky-top bg-white shadow-sm p-3 mb-4">
            <div class="container-fluid d-flex align-items-center justify-content-between">
                <div class="d-flex align-items-center">
                    <button class="btn border-0" id="menu-toggle"><i class="bi bi-list fs-4"></i></button>
                    <h5 class="mb-0 ms-3 fw-bold">Hồ sơ cá nhân</h5>
                </div>
                <div class="d-flex align-items-center gap-3">
                    <div class="dropdown">
                        <a href="#" class="text-dark text-decoration-none dropdown-toggle d-flex align-items-center" data-bs-toggle="dropdown">
                            <img src="https://ui-avatars.com/api/?name=Admin+YaMe&background=0D8ABC&color=fff" alt="Admin" class="rounded-circle" width="35">
                            <span class="ms-2 small fw-bold">Admin</span>
                        </a>
                        <ul class="dropdown-menu dropdown-menu-end shadow border-0">
                            <li><a class="dropdown-item" href="${pageContext.request.contextPath}/admin?action=profile"><i class="bi bi-person me-2"></i> Hồ sơ</a></li>
                            <li><hr class="dropdown-divider"></li>
                            <li><a class="dropdown-item text-danger" href="${pageContext.request.contextPath}/LogoutServlet"><i class="bi bi-box-arrow-right me-2"></i> Đăng xuất</a></li>
                        </ul>
                    </div>
                </div>
            </div>
        </div>

        <div class="container-fluid p-4">
            <div class="row g-4">
                <div class="col-lg-4">
                    <div class="card border-0 shadow-sm overflow-hidden">
                        <div class="profile-cover" style="background: linear-gradient(45deg, #212529, #495057); height: 100px;"></div>
                        <div class="card-body text-center pb-4 position-relative">
                            <img src="https://ui-avatars.com/api/?name=Huynh+Van+Hien&background=0D8ABC&color=fff&size=128" 
                                 alt="Avatar" class="rounded-circle shadow-sm mb-3" 
                                 style="margin-top: -50px; border: 5px solid #fff; width: 100px; height: 100px; object-fit: cover;">
                            
                            <h4 class="fw-bold mb-1">Huỳnh Văn Hiền</h4>
                            <p class="text-muted small mb-3">Super Administrator</p>
                            
                            <div class="d-flex justify-content-center gap-2 mb-4">
                                <span class="badge bg-success bg-opacity-10 text-success px-3 py-2 rounded-pill">Đang hoạt động</span>
                            </div>

                            <div class="text-start px-3 mt-4">
                                <div class="d-flex align-items-center mb-3 text-muted">
                                    <i class="bi bi-envelope me-3 fs-5"></i>
                                    <span>admin@yame.vn</span>
                                </div>
                                <div class="d-flex align-items-center mb-3 text-muted">
                                    <i class="bi bi-telephone me-3 fs-5"></i>
                                    <span>0909.123.456</span>
                                </div>
                                <div class="d-flex align-items-center mb-3 text-muted">
                                    <i class="bi bi-geo-alt me-3 fs-5"></i>
                                    <span>TP. Hồ Chí Minh</span>
                                </div>
                            </div>
                            <hr class="my-4">
                            <div class="d-flex justify-content-center gap-3">
                                <button class="btn btn-light rounded-circle shadow-sm"><i class="bi bi-facebook text-primary"></i></button>
                                <button class="btn btn-light rounded-circle shadow-sm"><i class="bi bi-twitter text-info"></i></button>
                                <button class="btn btn-light rounded-circle shadow-sm"><i class="bi bi-linkedin text-primary"></i></button>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="col-lg-8">
                    <div class="card border-0 shadow-sm">
                        <div class="card-header bg-white border-bottom-0 pt-4 px-4">
                            <ul class="nav nav-tabs card-header-tabs" id="myTab" role="tablist">
                                <li class="nav-item">
                                    <button class="nav-link active text-dark fw-bold border-0 border-bottom border-dark" id="info-tab" data-bs-toggle="tab" data-bs-target="#info" type="button">Thông tin chung</button>
                                </li>
                                <li class="nav-item">
                                    <button class="nav-link text-muted border-0" id="password-tab" data-bs-toggle="tab" data-bs-target="#password" type="button">Đổi mật khẩu</button>
                                </li>
                            </ul>
                        </div>

                        <div class="card-body p-4">
                            <div class="tab-content" id="myTabContent">
                                <div class="tab-pane fade show active" id="info" role="tabpanel">
                                    <form action="${pageContext.request.contextPath}/admin?action=updateProfile" method="POST">
                                        <div class="row g-3">
                                            <div class="col-md-6">
                                                <label class="form-label small text-muted fw-bold">Họ và tên đệm</label>
                                                <input type="text" name="firstName" class="form-control bg-light" value="Huỳnh Văn">
                                            </div>
                                            <div class="col-md-6">
                                                <label class="form-label small text-muted fw-bold">Tên</label>
                                                <input type="text" name="lastName" class="form-control bg-light" value="Hiền">
                                            </div>
                                            <div class="col-md-6">
                                                <label class="form-label small text-muted fw-bold">Email</label>
                                                <input type="email" class="form-control bg-light" value="admin@yame.vn" disabled>
                                            </div>
                                            <div class="col-md-6">
                                                <label class="form-label small text-muted fw-bold">Số điện thoại</label>
                                                <input type="text" name="phone" class="form-control bg-light" value="0909.123.456">
                                            </div>
                                            <div class="col-12">
                                                <label class="form-label small text-muted fw-bold">Địa chỉ</label>
                                                <input type="text" name="address" class="form-control bg-light" value="766 Sư Vạn Hạnh, Quận 10, TP.HCM">
                                            </div>
                                            <div class="col-12 mt-4 text-end">
                                                <button type="submit" class="btn btn-dark px-4 py-2 fw-bold shadow-sm">Lưu thay đổi</button>
                                            </div>
                                        </div>
                                    </form>
                                </div>

                                <div class="tab-pane fade" id="password" role="tabpanel">
                                    <form action="${pageContext.request.contextPath}/admin?action=changePassword" method="POST">
                                        <div class="mb-3">
                                            <label class="form-label small text-muted fw-bold">Mật khẩu hiện tại</label>
                                            <input type="password" name="oldPass" class="form-control bg-light">
                                        </div>
                                        <div class="mb-3">
                                            <label class="form-label small text-muted fw-bold">Mật khẩu mới</label>
                                            <input type="password" name="newPass" class="form-control bg-light">
                                        </div>
                                        <div class="mb-3">
                                            <label class="form-label small text-muted fw-bold">Nhập lại mật khẩu mới</label>
                                            <input type="password" name="reNewPass" class="form-control bg-light">
                                        </div>
                                        <div class="text-end mt-4">
                                            <button type="submit" class="btn btn-warning fw-bold text-white px-4 py-2 shadow-sm">Cập nhật mật khẩu</button>
                                        </div>
                                    </form>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script src="${pageContext.request.contextPath}/Frontend-master/admin/js/script.js"></script>
</body>
</html>