<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="vi">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quản lý Nhân viên - YaMe Admin</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.0/font/bootstrap-icons.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/Frontend-master/admin/css/style.css">
    <style>
        .emp-avatar { width: 40px; height: 40px; border-radius: 50%; object-fit: cover; }
        .role-badge { font-size: 0.85rem; font-weight: 500; }
        .grayscale { filter: grayscale(100%); opacity: 0.6; }
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
    
    <li class="menu-header">Hệ thống</li>
    <li><a href="${pageContext.request.contextPath}/index.jsp"><i class="bi bi-box-arrow-right"></i> Xem Trang chủ</a></li>
</ul>
    </div>

    <div class="main-content" id="mainContent">
        <div class="top-navbar sticky-top">
            <div class="d-flex align-items-center">
                <button class="btn border-0" id="menu-toggle"><i class="bi bi-list fs-4"></i></button>
                <h5 class="mb-0 ms-3">Danh sách nhân sự</h5>
            </div>
        </div>

        <div class="container-fluid p-4">
            <div class="card border-0 shadow-sm mb-4 filter-bar">
                <div class="card-body p-3">
                    <form action="${pageContext.request.contextPath}/admin/employees" method="GET" class="row g-3">
                        <div class="col-md-4">
                            <div class="input-group">
                                <span class="input-group-text bg-white border-end-0"><i class="bi bi-search"></i></span>
                                <input type="text" name="keyword" class="form-control border-start-0 ps-0"
                                    placeholder="Tên nhân viên, Mã NV, Email..." value="${param.keyword}">
                            </div>
                        </div>
                        <div class="col-md-3">
                            <select class="form-select" name="phongBan">
                                <option value="">-- Phòng ban --</option>
                                <option value="Kinh Doanh">Phòng Kinh Doanh</option>
                                <option value="Marketing">Phòng Marketing</option>
                                <option value="Kho Van">Kho Vận</option>
                                <option value="IT">IT & Kỹ thuật</option>
                            </select>
                        </div>
                        <div class="col-md-3">
                            <select class="form-select" name="chucVu">
                                <option value="">-- Chức vụ --</option>
                                <option value="Manager">Quản lý (Manager)</option>
                                <option value="Staff">Nhân viên (Staff)</option>
                            </select>
                        </div>
                        <div class="col-md-2 text-end">
                            <button type="button" class="btn btn-dark w-100 fw-bold" onclick="resetModalForAdd()" data-bs-toggle="modal" data-bs-target="#addEmployeeModal">
                                <i class="bi bi-person-plus-fill me-1"></i> Thêm NV
                            </button>
                        </div>
                    </form>
                </div>
            </div>

            <div class="card border-0 shadow-sm">
                <div class="card-body p-0">
                    <div class="table-responsive">
                        <table class="table table-hover table-custom mb-0 align-middle">
                            <thead class="bg-light">
                                <tr>
                                    <th class="ps-4">Nhân viên</th>
                                    <th>Chức vụ</th>
                                    <th>Liên hệ</th>
                                    <th>Phòng ban</th>
                                    <th>Ngày vào làm</th>
                                    <th>Trạng thái</th>
                                    <th class="text-end pe-4">Thao tác</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="nv" items="${employeeList}">
                                    <tr>
                                        <td class="ps-4">
                                            <div class="d-flex align-items-center">
                                                <img src="https://ui-avatars.com/api/?name=${nv.hoTen}&background=random"
                                                    class="emp-avatar me-3 ${nv.trangThai eq 'Nghỉ việc' ? 'grayscale' : ''}" alt="Avatar">
                                                <div>
                                                    <div class="fw-bold text-dark">${nv.hoTen}</div>
                                                    <small class="text-muted">MNV: YM-${nv.maNhanVien}</small>
                                                </div>
                                            </div>
                                        </td>
                                        <td>${nv.chucVu}</td>
                                        <td>
                                            <div class="small">${nv.email}</div>
                                            <div class="small text-muted">${nv.soDienThoai}</div>
                                        </td>
                                        <td><span class="badge bg-light text-dark border">${nv.phongBan}</span></td>
                                        <td class="small text-muted">
                                            <fmt:formatDate value="${nv.ngayVaoLam}" pattern="dd/MM/yyyy"/>
                                        </td>
                                        <td>
                                            <span class="badge bg-success bg-opacity-10 text-success rounded-pill px-2">
                                                ${nv.trangThai}
                                            </span>
                                        </td>
                                        <td class="text-end pe-4">
                                            <button class="btn btn-light btn-sm border" title="Sửa" 
                                                onclick="prepareEdit('${nv.maNhanVien}', '${nv.hoTen}', '${nv.email}', '${nv.soDienThoai}', '${nv.phongBan}', '${nv.chucVu}', '${nv.trangThai}', '<fmt:formatDate value="${nv.ngayVaoLam}" pattern="yyyy-MM-dd"/>')">
                                                <i class="bi bi-pencil-square"></i>
                                            </button>
                                            
                                            <form action="employees" method="post" style="display:inline;">
                                                <input type="hidden" name="action" value="lock">
                                                <input type="hidden" name="maTaiKhoan" value="${nv.maTaiKhoan}">
                                                <button type="submit" class="btn btn-light btn-sm border text-danger" title="Khóa" 
                                                        onclick="return confirm('Bạn có chắc chắn muốn khóa tài khoản này?')">
                                                    <i class="bi bi-lock"></i>
                                                </button>
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
    </div>

    <div class="modal fade" id="addEmployeeModal" tabindex="-1">
        <div class="modal-dialog">
            <div class="modal-content border-0 shadow">
                <form action="${pageContext.request.contextPath}/admin/employees" method="POST" id="employeeForm">
                    <input type="hidden" name="action" id="modalAction" value="add">
                    <input type="hidden" name="maNhanVien" id="modalMaNhanVien">

                    <div class="modal-header bg-dark text-white">
                        <h5 class="modal-title" id="modalTitle">Thêm nhân viên mới</h5>
                        <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
                    </div>
                    <div class="modal-body">
                        <div class="mb-3">
                            <label class="form-label fw-bold">Họ và tên</label>
                            <input type="text" name="hoTen" class="form-control" required>
                        </div>
                        <div class="row">
                            <div class="col-md-6 mb-3">
                                <label class="form-label fw-bold">Email</label>
                                <input type="email" name="email" class="form-control" required>
                            </div>
                            <div class="col-md-6 mb-3">
                                <label class="form-label fw-bold">Số điện thoại</label>
                                <input type="text" name="soDienThoai" class="form-control" required>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-6 mb-3">
                                <label class="form-label fw-bold">Phòng ban</label>
                                <select class="form-select" name="phongBan">
                                    <option value="Bán lẻ">Bán lẻ</option>
                                    <option value="Kho vận">Kho vận</option>
                                    <option value="Marketing">Marketing</option>
                                    <option value="IT">IT & Kỹ thuật</option>
                                </select>
                            </div>
                            <div class="col-md-6 mb-3">
                                <label class="form-label fw-bold">Chức vụ</label>
                                <input type="text" name="chucVu" class="form-control">
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-6 mb-3">
                                <label class="form-label fw-bold">Ngày Vào Làm</label>
                                <input type="date" name="ngayVaoLam" class="form-control" required>
                            </div>
                            <div class="col-md-6 mb-3">
                                <label class="form-label fw-bold">Trạng Thái</label>
                                <select name="trangThai" class="form-control">
                                    <option value="Đang làm việc">Đang làm việc</option>
                                    <option value="Đã nghỉ việc">Đã nghỉ việc</option>
                                    <option value="Thử việc">Thử việc</option>
                                </select>
                            </div>
                        </div>
                    </div>
                    <div class="modal-footer bg-light">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Hủy</button>
                        <button type="submit" class="btn btn-dark px-4">Lưu nhân sự</button>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script src="${pageContext.request.contextPath}/Frontend-master/admin/js/script.js"></script>

    <script>
        // Hàm đổ dữ liệu vào Modal khi nhấn Sửa
        function prepareEdit(id, hoTen, email, sdt, phongBan, chucVu, trangThai, ngayVaoLam) {
            // Đổi tiêu đề Modal và Action
            document.getElementById('modalTitle').innerText = "Cập nhật nhân sự";
            document.getElementById('modalAction').value = "update";
            document.getElementById('modalMaNhanVien').value = id;

            // Đổ dữ liệu vào các ô input
            document.querySelector('input[name="hoTen"]').value = hoTen;
            document.querySelector('input[name="email"]').value = email;
            document.querySelector('input[name="soDienThoai"]').value = sdt;
            document.querySelector('select[name="phongBan"]').value = phongBan;
            document.querySelector('input[name="chucVu"]').value = chucVu;
            document.querySelector('select[name="trangThai"]').value = trangThai;
            
            // Xử lý ngày cho input type="date" (yyyy-MM-dd)
            if (ngayVaoLam && ngayVaoLam !== 'null') {
                document.querySelector('input[name="ngayVaoLam"]').value = ngayVaoLam;
            }

            // Hiển thị Modal
            var myModal = new bootstrap.Modal(document.getElementById('addEmployeeModal'));
            myModal.show();
        }

        // Hàm reset Modal về trạng thái Thêm mới
        function resetModalForAdd() {
            document.getElementById('modalTitle').innerText = "Thêm nhân viên mới";
            document.getElementById('modalAction').value = "add";
            document.getElementById('modalMaNhanVien').value = "";
            document.getElementById('employeeForm').reset();
        }
    </script>
</body>
</html>