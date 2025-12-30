<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<div class="table-responsive">
    <table class="table table-bordered align-middle mb-0">
        <thead class="bg-light text-center">
            <tr>
                <th>Mã SP</th>
                <th>Tên Sản Phẩm</th>
                <th>SL</th>
                <th>Đơn giá</th>
                <th>Thành tiền</th>
            </tr>
        </thead>
        <tbody>
            <c:set var="tongTienHang" value="0" />
            <c:set var="tongSoLuong" value="0" />
            
            <c:forEach var="ct" items="${details}">
                <c:set var="thanhTien" value="${ct.soLuong * ct.donGia}" />
                <c:set var="tongTienHang" value="${tongTienHang + thanhTien}" />
                <c:set var="tongSoLuong" value="${tongSoLuong + ct.soLuong}" />
                <tr>
                    <td class="text-center fw-bold">#${ct.maChiTietSP}</td>
                    <td>${ct.tenSanPham}</td>
                    <td class="text-center">${ct.soLuong}</td>
                    <td class="text-end"><fmt:formatNumber value="${ct.donGia}" pattern="#,###"/>đ</td>
                    <td class="text-end fw-bold"><fmt:formatNumber value="${thanhTien}" pattern="#,###"/>đ</td>
                </tr>
            </c:forEach>
        </tbody>
        
        <tfoot class="border-top">
    <%-- 1. Dòng Tổng tiền hàng (trước khi giảm) --%>
    <tr>
        <td colspan="4" class="text-end fw-bold">Tổng tiền hàng:</td>
        <td class="text-end fw-bold"><fmt:formatNumber value="${tongTienHang}" pattern="#,###"/>đ</td>
    </tr>

    <%-- 2. Tính toán Logic giảm giá --%>
    <c:set var="tongGiam" value="0" />
    <c:choose>
        <%-- Nếu mã KM là 1: Giảm 10% trên tổng tiền hàng --%>
        <c:when test="${order.maKhuyenMai == 1}">
            <c:set var="tongGiam" value="${tongTienHang * 0.1}" />
        </c:when>
        <%-- Nếu mã KM là 2: Giảm cố định 20,000đ --%>
        <c:when test="${order.maKhuyenMai == 2}">
            <c:set var="tongGiam" value="${tongTienHang * 0.2}" />
        </c:when>
    </c:choose>

    <%-- 3. Hiển thị dòng Khuyến mãi nếu có --%>
    <c:if test="${tongGiam > 0}">
        <tr>
            <td colspan="4" class="text-end text-success fw-bold">
                Khuyến mãi:
                <c:if test="${order.maKhuyenMai == 1}">(Giảm 10%)</c:if>
                <c:if test="${order.maKhuyenMai == 2}">(Giảm 20%)</c:if>
            </td>
            <td class="text-end text-success fw-bold">
                - <fmt:formatNumber value="${tongGiam}" pattern="#,###"/>đ
            </td>
        </tr>
    </c:if>

    <%-- 4. Dòng Tổng thanh toán cuối cùng (đã trừ giảm giá) --%>
    <tr class="table-warning">
        <td colspan="4" class="text-end fw-bold text-danger">TỔNG THANH TOÁN:</td>
        <td class="text-end fw-bold text-danger fs-5">
            <fmt:formatNumber value="${tongTienHang - tongGiam}" pattern="#,###"/>đ
        </td>
    </tr>
</tfoot>
    </table>

</div>
