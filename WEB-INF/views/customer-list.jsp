<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quản lý Khách hàng - YaMe Admin</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.0/font/bootstrap-icons.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/Frontend-master/admin/css/style.css">
    <style>
        .grayscale { filter: grayscale(100%); opacity: 0.6; }
        .vip-badge { 
            background: linear-gradient(45deg, #ffd700, #ffa500); 
            color: #000; padding: 2px 8px; border-radius: 4px; 
            font-weight: bold; font-size: 0.8rem;
        }
    </style>
</head>

<body>
    <div class="sidebar" id="sidebar">
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
    <li>
    
</li>
    
    <li class="menu-header">Hệ thống</li>
    <li><a href="${pageContext.request.contextPath}/index.jsp"><i class="bi bi-box-arrow-right"></i> Xem Trang chủ</a></li>
</ul>
    </div>

    <div class="main-content" id="mainContent">
        <div class="top-navbar sticky-top">
            <div class="d-flex align-items-center">
                <button class="btn border-0" id="menu-toggle"><i class="bi bi-list fs-4"></i></button>
                <h5 class="mb-0 ms-3">Danh sách khách hàng</h5>
            </div>
            <div class="d-flex align-items-center gap-3">
                <div class="dropdown">
                    <a href="#" class="text-dark text-decoration-none dropdown-toggle" data-bs-toggle="dropdown">
                        <img src="https://ui-avatars.com/api/?name=Admin+YaMe&background=0D8ABC&color=fff" class="rounded-circle" width="35">
                        <span class="ms-2 small fw-bold">Admin</span>
                    </a>
                    <ul class="dropdown-menu dropdown-menu-end">
                        <li><a class="dropdown-item" href="#">Hồ sơ</a></li>
                        <li><a class="dropdown-item text-danger" href="#">Đăng xuất</a></li>
                    </ul>
                </div>
            </div>
        </div>

        <div class="container-fluid p-4">
            <div class="card border-0 shadow-sm mb-4 filter-bar">
                <div class="card-body p-3">
                    <form action="${pageContext.request.contextPath}/admin/customers" method="GET" class="row g-3">
                        <div class="col-md-4">
                            <div class="input-group">
                                <span class="input-group-text bg-white border-end-0"><i class="bi bi-search"></i></span>
                                <input type="text" name="keyword" class="form-control border-start-0 ps-0"
                                    placeholder="Tên, Email, SĐT khách hàng..." value="${keyword}">
                            </div>
                        </div>
                        <div class="col-md-3">
                            <select class="form-select" name="hang">
                                <option value="">-- Hạng thành viên --</option>
                                <option value="Member" ${hang == 'Member' ? 'selected' : ''}>Thành viên Mới</option>
                                <option value="Silver" ${hang == 'Silver' ? 'selected' : ''}>Thân thiết (Silver)</option>
                                <option value="Gold" ${hang == 'Gold' ? 'selected' : ''}>VIP (Gold)</option>
                                <option value="Diamond" ${hang == 'Diamond' ? 'selected' : ''}>Kim Cương (Diamond)</option>
                            </select>
                        </div>
                        <div class="col-md-2">
                            <select class="form-select" name="trangThai">
                                <option value="">-- Trạng thái --</option>
                                <option value="Active" ${trangThai == 'Active' ? 'selected' : ''}>Hoạt động</option>
                                <option value="Locked" ${trangThai == 'Locked' ? 'selected' : ''}>Bị khóa</option>
                            </select>
                        </div>
                        <div class="col-md-3 text-end">
                            <button type="button" class="btn btn-outline-success fw-bold me-1" onclick="exportCustomerExcel()">
                                <i class="bi bi-file-earmark-spreadsheet"></i> Xuất Excel
                            </button>
                            <button type="button" class="btn btn-dark fw-bold" data-bs-toggle="modal" data-bs-target="#addCustomerModal">
                                <i class="bi bi-plus-lg"></i> Thêm Khách
                            </button>
                        </div>
                    </form>
                </div>
            </div>

            <div class="card border-0 shadow-sm">
                <div class="card-body p-0">
                    <div class="table-responsive">
                        <table class="table table-hover table-custom mb-0 align-middle" id="customerTable">
                            <thead class="bg-light">
                                <tr>
                                    <th class="ps-4">Khách hàng</th>
                                    <th>Liên hệ</th>
                                    <th>Hạng</th>
                                    <th>Tổng chi tiêu</th>
                                    <th class="text-center">Đơn hàng</th>
                                    <th>Ngày tham gia</th>
                                    <th>Trạng thái</th>
                                    <th class="text-end pe-4 action-col">Hành động</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="kh" items="${customerList}">
                                    <tr>
                                        <td class="ps-4">
                                            <div class="d-flex align-items-center">
                                                <img src="https://ui-avatars.com/api/?name=${kh.ten}&background=random"
                                                    class="customer-avatar me-3 ${kh.trangThai eq 'Locked' ? 'grayscale' : ''}" 
                                                    width="40" height="40" style="border-radius: 50%;">
                                                <div>
                                                    <div class="fw-bold ${kh.trangThai eq 'Locked' ? 'text-muted' : 'text-dark'}">${kh.ten}</div>
                                                    <small class="text-muted">ID: YM-${kh.maKhachHang}</small>
                                                </div>
                                            </div>
                                        </td>
                                        <td>
                                            <div class="small"><i class="bi bi-envelope me-1"></i> ${kh.email}</div>
                                            <div class="small text-muted"><i class="bi bi-phone me-1"></i> ${kh.soDienThoai}</div>
                                        </td>
                                        <td>
                                            <c:choose>
                                                <c:when test="${kh.hang eq 'Gold' || kh.hang eq 'Diamond'}">
                                                    <span class="vip-badge"><i class="bi bi-gem me-1"></i>${kh.hang.toUpperCase()} VIP</span>
                                                </c:when>
                                                <c:otherwise>
                                                    <span class="badge bg-secondary fw-normal">${kh.hang}</span>
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                                        <td class="fw-bold text-success">
                                            <fmt:formatNumber value="${kh.tongChiTieu}" pattern="#,###"/>đ
                                        </td>
                                        <td class="text-center">
                                            <span class="badge bg-light text-dark border">${kh.soDonHang}</span>
                                        </td>
                                        <td class="small text-muted">21/12/2025</td>
                                        <td>
                                            <span class="badge ${kh.trangThai eq 'Active' ? 'bg-success' : 'bg-danger'} bg-opacity-10 ${kh.trangThai eq 'Active' ? 'text-success' : 'text-danger'} rounded-pill px-2">
                                                ${kh.trangThai}
                                            </span>
                                        </td>
                                        <td class="text-end pe-4 action-col">
												<button class="btn btn-light btn-sm border" 
												        title="Xem chi tiết"
												        onclick="viewDetail('${kh.ten}', '${kh.email}', '${kh.soDienThoai}', '${kh.hang}', '${kh.diaChi}', '${kh.trangThai}')">
												    <i class="bi bi-eye"></i>
												</button>
												<c:if test="${kh.trangThai eq 'Active'}">
													    <a href="mailto:${kh.email}?subject=YaMe.vn - Thông báo ưu đãi&body=Chào ${kh.ten}," 
													       class="btn btn-light btn-sm border text-primary" 
													       title="Gửi Email">
													        <i class="bi bi-envelope"></i>
													    </a>
													</c:if>            
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div class="modal fade" id="addCustomerModal" tabindex="-1">
        <div class="modal-dialog">
            <div class="modal-content border-0 shadow">
                <form action="${pageContext.request.contextPath}/admin/customers" method="POST">
                    <div class="modal-header bg-dark text-white">
                        <h5 class="modal-title">Thêm khách hàng mới</h5>
                        <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
                    </div>
                    <div class="modal-body">
                        <div class="mb-3">
                            <label class="form-label fw-bold">Tên khách hàng</label>
                            <input type="text" name="ten" class="form-control" placeholder="Nhập họ tên..." required>
                        </div>
                        <div class="row">
                            <div class="col-md-6 mb-3">
                                <label class="form-label fw-bold">Email</label>
                                <input type="email" name="email" class="form-control" placeholder="yame@gmail.com" required>
                            </div>
                            <div class="col-md-6 mb-3">
                                <label class="form-label fw-bold">Số điện thoại</label>
                                <input type="text" name="soDienThoai" class="form-control" placeholder="090..." required>
                            </div>
                        </div>
                        <div class="mb-3">
                            <label class="form-label fw-bold">Hạng thành viên</label>
                            <select class="form-select" name="hang">
                                <option value="Member">Thành viên Mới (Member)</option>
                                <option value="Silver">Thân thiết (Silver)</option>
                                <option value="Gold">VIP (Gold)</option>
                                <option value="Diamond">Kim Cương (Diamond)</option>
                            </select>
                        </div>
                        <div class="mb-3">
                            <label class="form-label fw-bold">Địa chỉ</label>
                            <textarea name="diaChi" class="form-control" rows="2" placeholder="Số nhà, tên đường, phường/xã..."></textarea>
                        </div>
                    </div>
                    <div class="modal-footer bg-light">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Đóng</button>
                        <button type="submit" class="btn btn-dark px-4">Lưu thông tin</button>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/table2excel@1.0.4/dist/table2excel.min.js"></script>
    <script>
        function exportCustomerExcel() {
            var table2excel = new Table2Excel();
            // Loại bỏ các nút hành động (cột cuối) trước khi xuất để Excel đẹp hơn
            table2excel.export(document.querySelector("#customerTable"), "DanhSachKhachHang_YaMe");
        }
        function viewDetail(ten, email, sdt, hang, diachi, trangthai) {
            document.getElementById('det-ten').innerText = ten;
            document.getElementById('det-email').innerText = email;
            document.getElementById('det-sdt').innerText = sdt;
            document.getElementById('det-hang').innerText = hang;
            document.getElementById('det-diachi').innerText = diachi || "Chưa cập nhật";
            document.getElementById('det-trangthai').innerText = trangthai;
            
            new bootstrap.Modal(document.getElementById('detailModal')).show();
        }
    </script>
    <div class="modal fade" id="detailModal" tabindex="-1">
    <div class="modal-dialog">
        <div class="modal-content border-0 shadow">
            <div class="modal-header bg-info text-white">
                <h5 class="modal-title"><i class="bi bi-person-vcard me-2"></i>Chi tiết khách hàng</h5>
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
            </div>
            <div class="modal-body">
                <ul class="list-group list-group-flush">
                    <li class="list-group-item d-flex justify-content-between"><span>Họ tên:</span> <strong id="det-ten"></strong></li>
                    <li class="list-group-item d-flex justify-content-between"><span>Email:</span> <span id="det-email"></span></li>
                    <li class="list-group-item d-flex justify-content-between"><span>Số điện thoại:</span> <span id="det-sdt"></span></li>
                    <li class="list-group-item d-flex justify-content-between"><span>Hạng:</span> <span class="badge bg-warning text-dark" id="det-hang"></span></li>
                    <li class="list-group-item">
                        <div class="mb-1 text-muted small">Địa chỉ giao hàng:</div>
                        <div id="det-diachi" class="fw-bold"></div>
                    </li>
                    <li class="list-group-item d-flex justify-content-between"><span>Trạng thái:</span> <span id="det-trangthai"></span></li>
                </ul>
            </div>
        </div>
    </div>
</div>
</body>
</html>