<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html>
<head>
    <title>Thanh toán</title>
</head>
<body>
<div class="container mt-4">
    <h2>Thanh toán (Checkout)</h2>
    
    <c:if test="${not empty error}">
        <div class="alert alert-danger">${error}</div>
    </c:if>

    <div class="row mt-4">
        <div class="col-md-7">
            <div class="card shadow-sm mb-4">
                <div class="card-header bg-white">
                    <h5 class="mb-0">Thông tin nhận hàng</h5>
                </div>
                <div class="card-body">
                    <form action="<c:url value='/checkout/place-order'/>" method="post" id="checkoutForm">
                        <div class="mb-3">
                            <label class="form-label">Họ tên người nhận <span class="text-danger">*</span></label>
                            <input type="text" name="fullName" class="form-control" value="${sessionScope.user.fullname}" required>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Số điện thoại <span class="text-danger">*</span></label>
                            <input type="text" name="phone" class="form-control" value="${sessionScope.user.phone}" required>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Địa chỉ giao hàng chi tiết <span class="text-danger">*</span></label>
                            <textarea name="address" class="form-control" rows="3" required placeholder="Nhập địa chỉ nhận hàng của bạn"></textarea>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Ghi chú đơn hàng (Tùy chọn)</label>
                            <textarea name="note" class="form-control" rows="2" placeholder="Ví dụ: Giao vào giờ hành chính"></textarea>
                        </div>
                        
                        <h5 class="mt-4 mb-3">Phương thức thanh toán</h5>
                        <div class="form-check border p-3 rounded bg-light">
                            <input class="form-check-input" type="radio" name="paymentMethod" id="paymentCOD" value="COD" checked>
                            <label class="form-check-label fw-bold" for="paymentCOD">
                                Thanh toán khi nhận hàng (COD)
                            </label>
                            <div class="text-muted small mt-1">Quý khách sẽ thanh toán bằng tiền mặt cho nhân viên giao hàng.</div>
                        </div>
                    </form>
                </div>
            </div>
        </div>
        
        <div class="col-md-5">
            <div class="card shadow-sm">
                <div class="card-header bg-white">
                    <h5 class="mb-0">Tóm tắt đơn hàng</h5>
                </div>
                <div class="card-body">
                    <ul class="list-group list-group-flush mb-3">
                        <c:forEach var="item" items="${cartItems}">
                            <li class="list-group-item d-flex justify-content-between lh-sm px-0">
                                <div>
                                    <h6 class="my-0">${item.product.productName}</h6>
                                    <small class="text-muted">SL: ${item.quantity} x <fmt:formatNumber value="${item.unitPrice}" pattern="#,###"/> VNĐ</small>
                                </div>
                                <span class="text-muted"><fmt:formatNumber value="${item.unitPrice * item.quantity}" pattern="#,###"/></span>
                            </li>
                        </c:forEach>
                    </ul>
                    <hr>
                    <div class="d-flex justify-content-between mb-2">
                        <span>Tạm tính:</span>
                        <strong><fmt:formatNumber value="${subtotal}" pattern="#,###"/> VNĐ</strong>
                    </div>
                    <div class="d-flex justify-content-between mb-4">
                        <span>Phí vận chuyển:</span>
                        <strong>0 VNĐ</strong>
                    </div>
                    <div class="d-flex justify-content-between bg-light p-3 border rounded mb-4">
                        <h5 class="mb-0">Tổng cộng:</h5>
                        <h5 class="text-danger mb-0"><strong><fmt:formatNumber value="${subtotal}" pattern="#,###"/> VNĐ</strong></h5>
                    </div>
                    <button type="button" class="btn btn-success w-100 btn-lg" onclick="document.getElementById('checkoutForm').submit();">Đặt hàng ngay</button>
                    <div class="text-center mt-3">
                        <a href="<c:url value='/cart'/>" class="text-decoration-none">Quay lại giỏ hàng</a>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
</body>
</html>
