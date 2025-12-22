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
            <tr>
                <td colspan="4" class="text-end fw-bold">Tổng tiền hàng:</td>
                <td class="text-end fw-bold"><fmt:formatNumber value="${tongTienHang}" pattern="#,###"/>đ</td>
            </tr>

            <%-- ÁNH XẠ: CỨ 1 SẢN PHẨM GIẢM 10,000đ --%>
            <c:set var="donGiaGiam" value="0" />
            <c:choose>
                <c:when test="${order.maKhuyenMai == 1}">
                    <c:set var="donGiaGiam" value="10000" />
                </c:when>
                <c:when test="${order.maKhuyenMai == 2}">
                    <c:set var="donGiaGiam" value="20000" />
                </c:when>
            </c:choose>

            <c:if test="${donGiaGiam > 0}">
                <c:set var="tongGiam" value="${tongSoLuong * donGiaGiam}" />
                <tr>
                    <td colspan="4" class="text-end text-success fw-bold">
                        Khuyến mãi (Giảm <fmt:formatNumber value="${donGiaGiam}" pattern="#,###"/>đ x ${tongSoLuong} sản phẩm):
                    </td>
                    <td class="text-end text-success fw-bold">
                        - <fmt:formatNumber value="${tongGiam}" pattern="#,###"/>đ
                    </td>
                </tr>
            </c:if>

            <tr class="table-warning">
                <td colspan="4" class="text-end fw-bold text-danger">TỔNG THANH TOÁN:</td>
                <td class="text-end fw-bold text-danger fs-5">
                    <%-- Kết quả sẽ là 650k - (2 sản phẩm * 10k) = 630k --%>
                    <fmt:formatNumber value="${tongTienHang - (tongSoLuong * donGiaGiam)}" pattern="#,###"/>đ
                </td>
            </tr>
        </tfoot>
    </table>
</div>