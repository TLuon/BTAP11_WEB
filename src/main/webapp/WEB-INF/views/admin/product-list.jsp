<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quản Lý Sản Phẩm - Admin Panel</title>
    <!-- Bootstrap 5.3 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Bootstrap Icons -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css" rel="stylesheet">
    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&family=Outfit:wght@500;600;700;800&display=swap" rel="stylesheet">

    <style>
        body { font-family: 'Inter', sans-serif; background-color: #f8fafc; color: #334155; }
        h1, h2, h3, h4, .brand-font { font-family: 'Outfit', sans-serif; }
    </style>
</head>
<body>

<div class="container-fluid py-3">
    <div class="card border-0 shadow-sm rounded-4 overflow-hidden mb-4">
        <div class="card-header bg-white py-3 border-bottom d-flex justify-content-between align-items-center">
            <h5 class="mb-0 fw-bold text-dark"><i class="bi bi-box-seam-fill text-primary me-2"></i>QUẢN LÝ SẢN PHẨM (CÂU 5)</h5>
            <a href="${pageContext.request.contextPath}/admin/product/add" class="btn btn-primary rounded-pill fw-bold shadow-sm">
                <i class="bi bi-plus-circle me-1"></i> Thêm Sản Phẩm Mới
            </a>
        </div>

        <div class="card-body p-0">
            <c:if test="${param.message == 'saved'}">
                <div class="alert alert-success m-3 border-0 shadow-sm alert-dismissible fade show" role="alert">
                    <i class="bi bi-check-circle-fill me-2"></i>Đã lưu thông tin sản phẩm thành công!
                    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                </div>
            </c:if>
            <c:if test="${param.message == 'deleted'}">
                <div class="alert alert-warning m-3 border-0 shadow-sm alert-dismissible fade show" role="alert">
                    <i class="bi bi-trash-fill me-2"></i>Đã xóa sản phẩm khỏi cơ sở dữ liệu!
                    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                </div>
            </c:if>

            <div class="table-responsive">
                <table class="table table-striped table-hover align-middle mb-0">
                    <thead class="table-light">
                        <tr>
                            <th class="ps-4">ID</th>
                            <th>Hình Ảnh</th>
                            <th>Tên Sản Phẩm</th>
                            <th>Mã SP (Code)</th>
                            <th>Danh Mục</th>
                            <th>Cửa Hàng (Seller)</th>
                            <th>Giá Bán</th>
                            <th>Số Lượng</th>
                            <th class="text-end pe-4">Thao Tác</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="p" items="${products}">
                            <tr>
                                <td class="ps-4 font-monospace fw-bold text-secondary">#${p.productId}</td>
                                <td>
                                    <img src="${p.images}" class="rounded-3 shadow-sm" style="width: 55px; height: 42px; object-fit: cover;">
                                </td>
                                <td class="fw-bold text-dark">
                                    <a href="${pageContext.request.contextPath}/product/detail?id=${p.productId}" class="text-decoration-none text-dark" target="_blank">
                                        ${p.productName}
                                    </a>
                                </td>
                                <td class="font-monospace small">${p.productCode}</td>
                                <td><span class="badge bg-info-subtle text-info-emphasis rounded-pill px-3 py-1">${p.category.categoryName}</span></td>
                                <td><span class="badge bg-dark rounded-pill px-3 py-1">${p.seller.sellername}</span></td>
                                <td class="fw-bold text-danger"><fmt:formatNumber value="${p.price}" pattern="#,##0"/>đ</td>
                                <td><span class="badge bg-secondary-subtle text-secondary-emphasis rounded-pill">${p.amount}</span></td>
                                <td class="text-end pe-4">
                                    <a href="${pageContext.request.contextPath}/admin/product/edit?id=${p.productId}" class="btn btn-sm btn-outline-warning rounded-pill fw-bold me-1">
                                        <i class="bi bi-pencil-square me-1"></i>Sửa
                                    </a>
                                    <a href="${pageContext.request.contextPath}/admin/product/delete?id=${p.productId}" 
                                       class="btn btn-sm btn-outline-danger rounded-pill fw-bold"
                                       onclick="return confirm('Bạn có chắc chắn muốn xóa sản phẩm [${p.productName}]?');">
                                        <i class="bi bi-trash me-1"></i>Xóa
                                    </a>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>

        <!-- Pagination Controls -->
        <div class="card-footer bg-white py-3 border-top d-flex justify-content-between align-items-center">
            <span class="small text-muted">Hiển thị trang <b>${currentPage}</b> / <b>${totalPages}</b></span>
            
            <nav>
                <ul class="pagination pagination-sm mb-0">
                    <li class="page-item ${currentPage <= 1 ? 'disabled' : ''}">
                        <a class="page-link rounded-start-pill" href="${pageContext.request.contextPath}/admin/product?page=${currentPage - 1}">Trang Trước</a>
                    </li>
                    
                    <c:forEach var="i" begin="1" end="${totalPages}">
                        <li class="page-item ${i == currentPage ? 'active' : ''}">
                            <a class="page-link" href="${pageContext.request.contextPath}/admin/product?page=${i}">${i}</a>
                        </li>
                    </c:forEach>

                    <li class="page-item ${currentPage >= totalPages ? 'disabled' : ''}">
                        <a class="page-link rounded-end-pill" href="${pageContext.request.contextPath}/admin/product?page=${currentPage + 1}">Trang Sau</a>
                    </li>
                </ul>
            </nav>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
