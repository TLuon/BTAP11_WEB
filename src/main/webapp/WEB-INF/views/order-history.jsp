<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html>
<head>
    <title>Lịch sử đơn hàng</title>
</head>
<body>
<div class="container mt-4">
    <h2>Lịch sử đơn hàng của bạn</h2>
    
    <!-- Filter Tabs -->
    <ul class="nav nav-tabs mt-4 mb-4">
        <li class="nav-item">
            <a class="nav-link ${empty currentStatus ? 'active fw-bold' : ''}" href="<c:url value='/orders'/>">Tất cả</a>
        </li>
        <li class="nav-item">
            <a class="nav-link ${currentStatus == 'NEW' ? 'active fw-bold text-primary' : ''}" href="<c:url value='/orders?status=NEW'/>">Đơn hàng mới</a>
        </li>
        <li class="nav-item">
            <a class="nav-link ${currentStatus == 'CONFIRMED' ? 'active fw-bold text-info' : ''}" href="<c:url value='/orders?status=CONFIRMED'/>">Đã xác nhận</a>
        </li>
        <li class="nav-item">
            <a class="nav-link ${currentStatus == 'PREPARING' ? 'active fw-bold text-warning' : ''}" href="<c:url value='/orders?status=PREPARING'/>">Chuẩn bị hàng</a>
        </li>
        <li class="nav-item">
            <a class="nav-link ${currentStatus == 'SHIPPING' ? 'active fw-bold text-secondary' : ''}" href="<c:url value='/orders?status=SHIPPING'/>">Vận chuyển</a>
        </li>
        <li class="nav-item">
            <a class="nav-link ${currentStatus == 'DELIVERING' ? 'active fw-bold text-primary' : ''}" href="<c:url value='/orders?status=DELIVERING'/>">Giao hàng</a>
        </li>
        <li class="nav-item">
            <a class="nav-link ${currentStatus == 'DELIVERED' ? 'active fw-bold text-success' : ''}" href="<c:url value='/orders?status=DELIVERED'/>">Đã giao</a>
        </li>
        <li class="nav-item">
            <a class="nav-link ${currentStatus == 'CANCELLED' ? 'active fw-bold text-danger' : ''}" href="<c:url value='/orders?status=CANCELLED'/>">Đã hủy</a>
        </li>
        <li class="nav-item">
            <a class="nav-link ${currentStatus == 'RETURNED' ? 'active fw-bold text-dark' : ''}" href="<c:url value='/orders?status=RETURNED'/>">Hoàn trả</a>
        </li>
    </ul>

    <c:if test="${empty orders}">
        <div class="alert alert-info">Bạn không có đơn hàng nào trong trạng thái này.</div>
    </c:if>

    <c:if test="${not empty orders}">
        <div class="table-responsive">
            <table class="table table-hover align-middle">
                <thead class="table-light">
                    <tr>
                        <th>Mã ĐH</th>
                        <th>Ngày đặt</th>
                        <th>Người nhận</th>
                        <th>Tổng tiền</th>
                        <th>Trạng thái</th>
                        <th>Thao tác</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="order" items="${orders}">
                        <tr>
                            <td><strong>#${order.orderId}</strong></td>
                            <td><fmt:formatDate value="${order.orderDate}" pattern="dd/MM/yyyy HH:mm"/></td>
                            <td>${order.fullName}</td>
                            <td><fmt:formatNumber value="${order.totalAmount}" pattern="#,###"/> VNĐ</td>
                            <td>
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
                            </td>
                            <td>
                                <a href="<c:url value='/orders/detail?orderId=${order.orderId}'/>" class="btn btn-sm btn-outline-info">Chi tiết</a>
                                <c:if test="${order.status == 'NEW'}">
                                    <form action="<c:url value='/orders/cancel'/>" method="post" class="d-inline" onsubmit="return confirm('Bạn có chắc chắn muốn hủy đơn hàng này? Số lượng tồn kho sẽ được hoàn lại.');">
                                        <input type="hidden" name="orderId" value="${order.orderId}">
                                        <button type="submit" class="btn btn-sm btn-outline-danger">Hủy đơn</button>
                                    </form>
                                </c:if>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
    </c:if>
</div>
</body>
</html>
