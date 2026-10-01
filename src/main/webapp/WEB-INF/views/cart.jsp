<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html>
<head>
    <title>Giỏ hàng của bạn</title>
</head>
<body>
<div class="container mt-4">
    <h2>Giỏ hàng của bạn</h2>
    
    <c:if test="${empty cartItems}">
        <div class="alert alert-info mt-3">Giỏ hàng của bạn đang trống!</div>
        <a href="<c:url value='/home'/>" class="btn btn-primary">Tiếp tục mua sắm</a>
    </c:if>

    <c:if test="${not empty cartItems}">
        <div class="row mt-4">
            <div class="col-md-8">
                <table class="table table-bordered table-hover">
                    <thead class="table-light">
                        <tr>
                            <th>Sản phẩm</th>
                            <th>Đơn giá</th>
                            <th width="150">Số lượng</th>
                            <th>Thành tiền</th>
                            <th>Thao tác</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="item" items="${cartItems}">
                            <tr>
                                <td>
                                    <div class="d-flex align-items-center">
                                        <img src="${item.product.images}" alt="product" width="50" class="me-2 rounded">
                                        <a href="<c:url value='/product/detail?id=${item.product.productId}'/>" class="text-decoration-none">
                                            ${item.product.productName}
                                        </a>
                                    </div>
                                </td>
                                <td><fmt:formatNumber value="${item.unitPrice}" pattern="#,###"/> VNĐ</td>
                                <td>
                                    <form action="<c:url value='/cart/update'/>" method="post" class="d-flex">
                                        <input type="hidden" name="cartItemId" value="${item.cartItemId}">
                                        <input type="number" name="quantity" value="${item.quantity}" min="1" max="${item.product.stock}" class="form-control form-control-sm text-center" onchange="this.form.submit()">
                                    </form>
                                    <small class="text-muted">Kho: ${item.product.stock}</small>
                                </td>
                                <td><fmt:formatNumber value="${item.unitPrice * item.quantity}" pattern="#,###"/> VNĐ</td>
                                <td>
                                    <a href="<c:url value='/cart/delete?cartItemId=${item.cartItemId}'/>" class="btn btn-sm btn-danger" onclick="return confirm('Xóa khỏi giỏ hàng?')">Xóa</a>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
                <div class="d-flex justify-content-between">
                    <a href="<c:url value='/cart/clear'/>" class="btn btn-outline-danger" onclick="return confirm('Bạn có chắc muốn xóa toàn bộ giỏ hàng?')">Xóa toàn bộ giỏ hàng</a>
                    <a href="<c:url value='/home'/>" class="btn btn-outline-primary">Tiếp tục mua sắm</a>
                </div>
            </div>
            
            <div class="col-md-4">
                <div class="card shadow-sm">
                    <div class="card-body">
                        <h5 class="card-title mb-4">Tóm tắt đơn hàng</h5>
                        <div class="d-flex justify-content-between mb-2">
                            <span>Tạm tính:</span>
                            <strong><fmt:formatNumber value="${subtotal}" pattern="#,###"/> VNĐ</strong>
                        </div>
                        <div class="d-flex justify-content-between mb-4">
                            <span>Phí giao hàng:</span>
                            <strong>Miễn phí</strong>
                        </div>
                        <hr>
                        <div class="d-flex justify-content-between mb-4">
                            <h5>Tổng cộng:</h5>
                            <h5 class="text-danger"><fmt:formatNumber value="${subtotal}" pattern="#,###"/> VNĐ</h5>
                        </div>
                        <a href="<c:url value='/checkout'/>" class="btn btn-success w-100">Tiến hành thanh toán</a>
                    </div>
                </div>
            </div>
        </div>
    </c:if>
</div>
</body>
</html>
