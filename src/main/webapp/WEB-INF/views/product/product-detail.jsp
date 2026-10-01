<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Chi Tiết Sản Phẩm - ${product.productName}</title>
    <!-- Bootstrap 5.3 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Bootstrap Icons -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css" rel="stylesheet">
    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&family=Outfit:wght@500;600;700;800&display=swap" rel="stylesheet">

    <style>
        body { font-family: 'Inter', sans-serif; background-color: #f8fafc; color: #334155; }
        h1, h2, h3, h4, .brand-font { font-family: 'Outfit', sans-serif; }
        .detail-card {
            border: 1px solid #e2e8f0;
            border-radius: 24px;
            background: #ffffff;
            box-shadow: 0 20px 25px -5px rgba(0, 0, 0, 0.05);
            overflow: hidden;
        }
        .img-container {
            background: #f1f5f9;
            border-radius: 20px;
            overflow: hidden;
            border: 1px solid #e2e8f0;
        }
        .price-tag-box {
            background: linear-gradient(135deg, #fef2f2 0%, #ffe4e6 100%);
            border: 1px solid #fecdd3;
            border-radius: 16px;
        }
    </style>
</head>
<body>

<div class="container py-4">
    <!-- Top Navigation Row -->
    <div class="d-flex justify-content-between align-items-center mb-4">
        <a href="${pageContext.request.contextPath}/products" class="btn btn-outline-secondary rounded-pill fw-semibold px-4">
            <i class="bi bi-arrow-left me-2"></i> Quay lại danh sách sản phẩm (Câu 3)
        </a>
        <span class="badge bg-primary text-white rounded-pill px-3 py-2 fw-bold fs-6">
            <i class="bi bi-info-circle me-1"></i> TRANG CHI TIẾT SẢN PHẨM (CÂU 4 - 2.0Đ)
        </span>
    </div>

    <!-- Main Detail Card -->
    <div class="card detail-card border-0 p-3 p-md-4">
        <div class="row g-4 align-items-center">
            <!-- Left Column: [imageLink] Image Preview -->
            <div class="col-lg-5">
                <div class="img-container p-3 d-flex align-items-center justify-content-center" style="min-height: 380px;">
                    <img src="${product.images}" class="img-fluid rounded-3 shadow-sm" alt="${product.productName}" style="max-height: 360px; object-fit: cover; width: 100%;">
                </div>
            </div>

            <!-- Right Column: Product Attributes (Strictly obeying prompt template) -->
            <div class="col-lg-7">
                <div class="ps-lg-3">
                    <div class="d-flex flex-wrap gap-2 mb-3">
                        <span class="badge bg-dark rounded-pill px-3 py-2 font-monospace">Mã cửa hàng: STORE0${product.seller.sellerId}</span>
                        <span class="badge bg-info-subtle text-info-emphasis rounded-pill px-3 py-2 fw-semibold">${product.category.categoryName}</span>
                        <span class="badge bg-success-subtle text-success-emphasis rounded-pill px-3 py-2 fw-semibold">${product.seller.sellername}</span>
                    </div>

                    <!-- Tên sản phẩm -->
                    <h2 class="fw-bold text-dark mb-3">Tên sản phẩm: ${product.productName}</h2>

                    <!-- Price Box -->
                    <div class="price-tag-box p-3 mb-4">
                        <small class="text-muted d-block fw-semibold mb-1">Giá bán niêm yết:</small>
                        <span class="fs-2 fw-extrabold text-danger">
                            <fmt:formatNumber value="${product.price}" pattern="#,##0"/> VNĐ
                        </span>
                    </div>

                    <!-- Attributes Table Box -->
                    <div class="bg-light p-3 rounded-4 mb-4 border">
                        <div class="row g-3">
                            <div class="col-6 col-md-4">
                                <small class="text-muted d-block fw-semibold">Mã sản phẩm:</small>
                                <span class="font-monospace text-dark fw-bold fs-6">${product.productCode}</span>
                            </div>
                            <div class="col-6 col-md-4">
                                <small class="text-muted d-block fw-semibold">Danh mục:</small>
                                <span class="text-dark fw-semibold">${product.category.categoryName}</span>
                            </div>
                            <div class="col-6 col-md-4">
                                <small class="text-muted d-block fw-semibold">Amount (Số lượng):</small>
                                <span class="badge bg-primary rounded-pill px-3 py-1 fs-6">${product.amount}</span>
                            </div>
                        </div>
                    </div>

                    <!-- Description -->
                    <div class="mb-4">
                        <h5 class="fw-bold text-dark mb-2"><i class="bi bi-file-text-fill text-primary me-2"></i>Description:</h5>
                        <div class="p-3 bg-white rounded-3 border text-secondary leading-relaxed" style="white-space: pre-line;">
                            ${product.description}
                        </div>
                    </div>

                    <!-- Action Buttons -->
                    <div class="d-flex gap-3">
                        <a href="${pageContext.request.contextPath}/products" class="btn btn-primary rounded-pill px-4 py-2 fw-bold shadow-sm">
                            <i class="bi bi-cart-plus me-1"></i> Tiếp tục mua sắm
                        </a>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
