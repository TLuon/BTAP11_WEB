<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Đặt hàng thành công</title>
</head>
<body>
<div class="container mt-5">
    <div class="row justify-content-center">
        <div class="col-md-6">
            <div class="card shadow text-center py-5">
                <div class="card-body">
                    <i class="bi bi-check-circle-fill text-success" style="font-size: 5rem;"></i>
                    <h2 class="mt-4">Đặt hàng thành công!</h2>
                    <p class="lead mt-3">Cảm ơn bạn đã mua sắm. Đơn hàng của bạn đã được ghi nhận.</p>
                    <p class="text-muted">Mã đơn hàng của bạn là: <strong>#${orderId}</strong></p>
                    
                    <div class="mt-4">
                        <a href="<c:url value='/orders/detail?orderId=${orderId}'/>" class="btn btn-outline-primary me-2">Xem đơn hàng</a>
                        <a href="<c:url value='/home'/>" class="btn btn-primary">Tiếp tục mua sắm</a>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
</body>
</html>
