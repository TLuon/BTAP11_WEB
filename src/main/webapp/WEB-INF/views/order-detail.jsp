<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html>
<head>
    <title>Chi tiết đơn hàng #${order.orderId}</title>
</head>
<body>
<div class="container mt-4">
    <div class="d-flex justify-content-between align-items-center mb-4">
        <h2>Chi tiết đơn hàng <span class="text-primary">#${order.orderId}</span></h2>
        <a href="<c:url value='/orders'/>" class="btn btn-outline-secondary">Quay lại danh sách</a>
    </div>

    <div class="row">
        <div class="col-md-8">
            <div class="card shadow-sm mb-4">
                <div class="card-header bg-white">
                    <h5 class="mb-0">Danh sách sản phẩm</h5>
                </div>
                <div class="card-body p-0">
                    <table class="table mb-0">
                        <thead class="table-light">
                            <tr>
                                <th>Sản phẩm</th>
                                <th class="text-center">Số lượng</th>
                                <th class="text-end">Đơn giá</th>
                                <th class="text-end">Thành tiền</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="detail" items="${order.orderDetails}">
                                <tr>
                                    <td>
                                        <div class="d-flex align-items-center">
                                            <img src="${detail.product.images}" width="40" class="me-2 rounded">
                                            <span>${detail.product.productName}</span>
                                        </div>
                                    </td>
                                    <td class="text-center">${detail.quantity}</td>
                                    <td class="text-end"><fmt:formatNumber value="${detail.unitPrice}" pattern="#,###"/> đ</td>
                                    <td class="text-end fw-bold"><fmt:formatNumber value="${detail.unitPrice * detail.quantity}" pattern="#,###"/> đ</td>
                                </tr>
                            </c:forEach>
                        </tbody>
                        <tfoot class="bg-light">
                            <tr>
                                <td colspan="3" class="text-end fw-bold">Tổng cộng:</td>
                                <td class="text-end fw-bold text-danger fs-5"><fmt:formatNumber value="${order.totalAmount}" pattern="#,###"/> VNĐ</td>
                            </tr>
                        </tfoot>
                    </table>
                </div>
            </div>
        </div>

        <div class="col-md-4">
            <div class="card shadow-sm mb-4">
                <div class="card-header bg-white">
                    <h5 class="mb-0">Thông tin đơn hàng</h5>
                </div>
                <div class="card-body">
                    <p class="mb-2"><strong>Ngày đặt:</strong> <fmt:formatDate value="${order.orderDate}" pattern="dd/MM/yyyy HH:mm"/></p>
                    <p class="mb-2"><strong>Trạng thái:</strong> 
                        <c:choose>
                            <c:when test="${order.status == 'NEW'}"><span class="badge bg-primary">Đơn mới</span></c:when>
                            <c:when test="${order.status == 'CONFIRMED'}"><span class="badge bg-info text-dark">Đã xác nhận</span></c:when>
                            <c:when test="${order.status == 'PREPARING'}"><span class="badge bg-warning text-dark">Chuẩn bị hàng</span></c:when>
                            <c:when test="${order.status == 'SHIPPING'}"><span class="badge bg-secondary">Vận chuyển</span></c:when>
                            <c:when test="${order.status == 'DELIVERING'}"><span class="badge bg-primary">Đang giao</span></c:when>
                            <c:when test="${order.status == 'DELIVERED'}"><span class="badge bg-success">Đã giao</span></c:when>
                            <c:when test="${order.status == 'CANCELLED'}"><span class="badge bg-danger">Đã hủy</span></c:when>
                            <c:when test="${order.status == 'RETURNED'}"><span class="badge bg-dark">Hoàn trả</span></c:when>
                            <c:otherwise><span class="badge bg-secondary">${order.status}</span></c:otherwise>
                        </c:choose>
                    </p>
                    <p class="mb-2"><strong>Thanh toán:</strong> ${order.paymentMethod}</p>
                    <hr>
                    <h6 class="fw-bold">Thông tin người nhận</h6>
                    <p class="mb-1"><strong>Họ tên:</strong> ${order.fullName}</p>
                    <p class="mb-1"><strong>SĐT:</strong> ${order.phone}</p>
                    <p class="mb-1"><strong>Địa chỉ:</strong> ${order.address}</p>
                    <c:if test="${not empty order.note}">
                        <p class="mb-0"><strong>Ghi chú:</strong> ${order.note}</p>
                    </c:if>
                    
                    <c:if test="${order.status == 'NEW'}">
                        <hr>
                        <form action="<c:url value='/orders/cancel'/>" method="post" onsubmit="return confirm('Bạn có chắc chắn muốn hủy đơn hàng này?');">
                            <input type="hidden" name="orderId" value="${order.orderId}">
                            <button type="submit" class="btn btn-danger w-100">Hủy đơn hàng</button>
                        </form>
                    </c:if>
                </div>
            </div>
        </div>
    </div>
</div>
</body>
</html>
