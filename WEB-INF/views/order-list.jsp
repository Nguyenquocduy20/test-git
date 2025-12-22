<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="vi">

<head>
    <meta charset="UTF-8">
    <title>Quản lý đơn hàng - YaMe Admin</title>
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
                <h5 class="mb-0 ms-3">Đơn hàng</h5>
            </div>
            <div class="d-flex align-items-center gap-3">
                <div class="dropdown">
                    <a href="#" class="text-dark text-decoration-none dropdown-toggle" data-bs-toggle="dropdown">
                        <img src="https://ui-avatars.com/api/?name=Admin+YaMe&background=0D8ABC&color=fff" alt="Admin" class="rounded-circle" width="35">
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
                    <form action="${pageContext.request.contextPath}/admin/orders" method="GET" class="row g-3">
                        <div class="col-md-4">
                            <div class="input-group">
                                <span class="input-group-text bg-white border-end-0"><i class="bi bi-search"></i></span>
                                <input type="text" class="form-control border-start-0 ps-0" name="keyword"
                                    placeholder="Mã đơn, Tên khách, SĐT..." value="${keyword}">
                            </div>
                        </div>
                        <div class="col-md-3">
                            <input type="date" class="form-control text-muted" name="date" value="${date}">
                        </div>
                        <div class="col-md-3">
                            <select class="form-select" name="status">
                                <option value="" <c:if test="${status == null || status == ''}">selected</c:if>>-- Trạng thái đơn --</option>
                                <option value="Chờ xác nhận" <c:if test="${status == 'Chờ xác nhận'}">selected</c:if>>Chờ xác nhận</option>
                                <option value="Đang giao hàng" <c:if test="${status == 'Đang giao hàng'}">selected</c:if>>Đang giao hàng</option>
                                <option value="Đã giao" <c:if test="${status == 'Đã giao'}">selected</c:if>>Đã giao</option>
                                <option value="Đã hủy" <c:if test="${status == 'Đã hủy'}">selected</c:if>>Đã hủy</option>
                            </select>
                        </div>
                        <div class="col-md-2 text-end d-flex gap-2">
                             <button type="submit" class="btn btn-primary w-50 fw-bold">Lọc</button>
                           <button type="button" class="btn btn-success w-50 fw-bold" onclick="exportExcel()">
						    <i class="bi bi-file-earmark-excel me-1"></i> Xuất Excel
						</button>
						  </div>
                    </form>
                </div>
            </div>

            <div class="card border-0 shadow-sm">
                <div class="card-body p-0">
                    <div class="table-responsive">
                        <table class="table table-hover table-custom mb-0 align-middle">
                            <thead class="bg-light text-center">
                                <tr>
                                    <th class="ps-4">Mã đơn</th>
                                    <th>Khách hàng</th>
                                    <th>Ngày đặt</th>
                                    <th>Tổng tiền</th>
                                    <th>Thanh toán</th>
                                    <th>Trạng thái</th>
                                    <th class="text-end pe-4">Thao tác</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="order" items="${orderList}">
                                    <tr>
                                        <td class="ps-4 fw-bold text-primary text-center">#YM-${order.maDonHang}</td>
                                        <td>
                                            <div class="fw-bold small">${order.tenKhachHang}</div>
                                            <small class="text-muted">${order.soDienThoaiKhachHang}</small>
                                        </td>
                                        <td class="text-muted small text-center">
                                            <fmt:formatDate value="${order.ngayDatHang}" pattern="dd/MM/yyyy" /><br> 
                                            <fmt:formatDate value="${order.ngayDatHang}" pattern="HH:mm" />
                                        </td>
                                        <td class="fw-bold text-center">
                                            <fmt:formatNumber value="${order.tongTien}" pattern="#,###"/>đ
                                        </td>
                                        <td class="text-center"><span class="badge border text-dark fw-normal">COD</span></td>
                                        <td class="text-center">
                                            <c:choose>
                                                <c:when test="${order.trangThai eq 'Chờ xác nhận'}">
                                                    <span class="badge bg-warning text-dark">${order.trangThai}</span>
                                                </c:when>
                                                <c:when test="${order.trangThai eq 'Đang giao hàng'}">
                                                    <span class="badge bg-primary bg-opacity-10 text-primary">${order.trangThai}</span>
                                                </c:when>
                                                <c:when test="${order.trangThai eq 'Đã giao'}">
                                                    <span class="badge bg-success bg-opacity-10 text-success">Hoàn thành</span>
                                                </c:when>
                                                <c:otherwise>
                                                    <span class="badge bg-secondary bg-opacity-10 text-secondary">${order.trangThai}</span>
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                                        <td class="text-end pe-4">
                                            <%-- GỌI HÀM JS VỚI 2 THAM SỐ: ID VÀ TỔNG TIỀN ĐÃ FORMAT --%>
                                            <button type="button" class="btn btn-light btn-sm border" 
                                                    onclick="moChiTiet(${order.maDonHang}, '<fmt:formatNumber value="${order.tongTien}" pattern="#,###"/>')" title="Xem chi tiết">
                                                <i class="bi bi-eye"></i>
                                            </button>
                                            <c:if test="${order.trangThai ne 'Đã hủy'}">
                                               <button type="button" class="btn btn-light btn-sm border text-danger" 
												        onclick="inHoaDon(${order.maDonHang})" title="In hóa đơn">
												    <i class="bi bi-printer"></i>
												</button>
                                            </c:if>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </div>

                <div class="card-footer bg-white py-3">
                    <nav>
                        <ul class="pagination justify-content-end mb-0">
                            <li class="page-item disabled"><a class="page-link" href="#"><i
                                        class="bi bi-chevron-left"></i></a></li>
                            <li class="page-item active"><a class="page-link bg-dark border-dark" href="#">1</a></li>
                            <li class="page-item"><a class="page-link text-dark" href="#">2</a></li>
                            <li class="page-item"><a class="page-link text-dark" href="#"><i
                                        class="bi bi-chevron-right"></i></a></li>
                        </ul>
                    </nav>
                </div>

            </div>
        </div>
    </div>

    <%-- MODAL: GIỮ NGUYÊN ID orderDetailModal CỦA BẠN --%>
    <div class="modal fade" id="orderDetailModal" tabindex="-1" aria-hidden="true">
        <div class="modal-dialog modal-lg">
            <div class="modal-content border-0">
                <div class="modal-header" style="background: #1a1a1a; color: white;">
                    <h5 class="modal-title">Chi tiết đơn hàng <span id="md-order-id"></span></h5>
                    <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body" id="modal-content-body">
                    <%-- Nơi chứa nội dung AJAX --%>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
    function moChiTiet(id, formattedTotal) {
        // 1. Gán mã đơn hàng lên tiêu đề ngay lập tức
        const label = document.getElementById('md-order-id-label');
        if(label) label.innerText = "#YM-" + id;
        
        // 2. Kích hoạt hiện Modal (Đảm bảo ID là orderDetailModal khớp với HTML)
        var modalElem = document.getElementById('orderDetailModal');
        var myModal = new bootstrap.Modal(modalElem);
        myModal.show();

        // 3. Hiệu ứng loading trong khi chờ
        const body = document.getElementById('modal-content-body');
        body.innerHTML = '<div class="text-center p-5"><div class="spinner-border text-dark"></div></div>';

        // 4. Gọi Server lấy dữ liệu
        fetch('${pageContext.request.contextPath}/admin/orders?action=viewDetail&id=' + id)
            .then(response => {
                if (!response.ok) throw new Error('Không tìm thấy trang chi tiết');
                return response.text();
            })
            .then(html => {
                // Đổ dữ liệu bảng vào modal
                body.innerHTML = html;

                // 5. Sau khi dữ liệu đã vào Body, mới có thể tìm thấy ID 'modal-final-total'
                const finalTotalSpan = document.getElementById('modal-final-total');
                if (finalTotalSpan) {
                    finalTotalSpan.innerText = formattedTotal;
                }
            })
            .catch(err => {
                body.innerHTML = '<p class="text-danger text-center p-3">Lỗi: ' + err.message + '</p>';
            });
    }
    function inHoaDon(id) {
        // Mở một tab mới trỏ đến action print trong Servlet
        const url = '${pageContext.request.contextPath}/admin/orders?action=print&id=' + id;
        const printWindow = window.open(url, '_blank', 'width=900,height=800');
    }
    function exportExcel() {
        var table2excel = new Table2Excel();
        table2excel.export(document.querySelector(".table"), "DanhSachDonHang");
    }
    </script>
    <script src="https://cdn.jsdelivr.net/npm/table2excel@1.0.4/dist/table2excel.min.js"></script>
</body>
</html>