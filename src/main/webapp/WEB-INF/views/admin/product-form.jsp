<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${product.productId != null ? 'Chỉnh Sửa' : 'Thêm'} Sản Phẩm - Admin Panel</title>
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

<div class="container py-4">
    <div class="row justify-content-center">
        <div class="col-md-10">
            <div class="card border-0 shadow-sm rounded-4 overflow-hidden">
                <div class="card-header bg-white py-3 border-bottom">
                    <h5 class="mb-0 fw-bold text-dark">
                        <i class="bi bi-pencil-square text-primary me-2"></i>
                        ${product.productId != null ? 'CHỈNH SỬA SẢN PHẨM' : 'THÊM SẢN PHẨM MỚI'}
                    </h5>
                </div>

                <div class="card-body p-4">
                    <c:if test="${not empty error}">
                        <div class="alert alert-danger border-0 shadow-sm alert-dismissible fade show" role="alert">
                            <i class="bi bi-exclamation-triangle-fill me-2"></i>${error}
                            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                        </div>
                    </c:if>

                    <form action="${pageContext.request.contextPath}/admin/product/save" method="post">
                        <input type="hidden" name="productId" value="${product.productId}">

                        <div class="row g-3 mb-3">
                            <div class="col-md-8">
                                <label class="form-label fw-semibold text-dark">Tên sản phẩm <span class="text-danger">*</span></label>
                                <input type="text" name="productName" class="form-control bg-light py-2" value="${product.productName}" placeholder="Nhập tên sản phẩm..." required>
                            </div>
                            <div class="col-md-4">
                                <label class="form-label fw-semibold text-dark">Mã sản phẩm (BigInt Code) <span class="text-danger">*</span></label>
                                <input type="number" name="productCode" class="form-control bg-light py-2" value="${product.productCode}" placeholder="Ví dụ: 1000000099" required>
                            </div>
                        </div>

                        <div class="row g-3 mb-3">
                            <div class="col-md-6">
                                <!-- Dropdown Category từ DB (Bắt buộc theo Câu 5) -->
                                <label class="form-label fw-semibold text-dark">Danh mục (Category) <span class="text-danger">*</span></label>
                                <select name="categoryId" class="form-select bg-light py-2" required>
                                    <option value="">-- Chọn Danh Mục --</option>
                                    <c:forEach var="cat" items="${categories}">
                                        <option value="${cat.categoryId}" ${product.category != null && product.category.categoryId == cat.categoryId ? 'selected' : ''}>
                                            ${cat.categoryName}
                                        </option>
                                    </c:forEach>
                                </select>
                            </div>

                            <div class="col-md-6">
                                <!-- Dropdown Seller từ DB (Bắt buộc theo Câu 5) -->
                                <label class="form-label fw-semibold text-dark">Cửa hàng (Seller) <span class="text-danger">*</span></label>
                                <select name="sellerId" class="form-select bg-light py-2" required>
                                    <option value="">-- Chọn Seller --</option>
                                    <c:forEach var="s" items="${sellers}">
                                        <option value="${s.sellerId}" ${product.seller != null && product.seller.sellerId == s.sellerId ? 'selected' : ''}>
                                            ${s.sellername} (STORE0${s.sellerId})
                                        </option>
                                    </c:forEach>
                                </select>
                            </div>
                        </div>

                        <div class="row g-3 mb-3">
                            <div class="col-md-4">
                                <label class="form-label fw-semibold text-dark">Giá bán (VNĐ) <span class="text-danger">*</span></label>
                                <input type="number" step="0.01" min="1" name="price" class="form-control bg-light py-2" value="${product.price}" placeholder="Giá tiền..." required>
                            </div>
                            <div class="col-md-4">
                                <label class="form-label fw-semibold text-dark">Số lượng (Amount)</label>
                                <input type="number" min="0" name="amount" class="form-control bg-light py-2" value="${product.amount != null ? product.amount : 0}" required>
                            </div>
                            <div class="col-md-4">
                                <label class="form-label fw-semibold text-dark">Hàng trong kho (Stock)</label>
                                <input type="number" min="0" name="stock" class="form-control bg-light py-2" value="${product.stock != null ? product.stock : 0}" required>
                            </div>
                        </div>

                        <div class="mb-3">
                            <label class="form-label fw-semibold text-dark">Link đường dẫn hình ảnh (URL)</label>
                            <input type="url" name="images" class="form-control bg-light py-2" value="${product.images}" placeholder="https://picsum.photos/id/1/500/400">
                        </div>

                        <div class="mb-3">
                            <label class="form-label fw-semibold text-dark">Mô tả sản phẩm (Description)</label>
                            <textarea name="description" class="form-control bg-light" rows="4" placeholder="Nhập chi tiết mô tả sản phẩm...">${product.description}</textarea>
                        </div>

                        <div class="mb-4">
                            <label class="form-label fw-semibold text-dark">Trạng thái kinh doanh</label>
                            <select name="status" class="form-select bg-light py-2">
                                <option value="1" ${product.status == 1 ? 'selected' : ''}>Mở bán (Active)</option>
                                <option value="0" ${product.status == 0 ? 'selected' : ''}>Ngừng bán (Inactive)</option>
                            </select>
                        </div>

                        <div class="d-flex justify-content-between pt-3 border-top">
                            <a href="${pageContext.request.contextPath}/admin/product" class="btn btn-outline-secondary rounded-pill fw-semibold px-4">
                                <i class="bi bi-arrow-left me-1"></i>Hủy Bỏ
                            </a>
                            <button type="submit" class="btn btn-primary rounded-pill fw-bold px-4 shadow-sm">
                                <i class="bi bi-save me-1"></i> Lưu Sản Phẩm
                            </button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
