<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Danh Sách Sản Phẩm Gom Nhóm Theo Seller - Câu 3</title>
    <!-- Bootstrap 5.3 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Bootstrap Icons -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css" rel="stylesheet">
    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&family=Outfit:wght@500;600;700;800&display=swap" rel="stylesheet">

    <style>
        body { font-family: 'Inter', sans-serif; background-color: #f8fafc; color: #334155; }
        h1, h2, h3, h4, .brand-font { font-family: 'Outfit', sans-serif; }
        .seller-header-banner {
            background: linear-gradient(135deg, #0f172a 0%, #1e293b 100%);
            border-radius: 16px;
        }
        .product-card-seller {
            transition: all 0.3s ease;
            border: 1px solid #e2e8f0;
            border-radius: 16px;
            background: #ffffff;
        }
        .product-card-seller:hover {
            transform: translateY(-5px);
            box-shadow: 0 15px 30px rgba(0,0,0,0.08) !important;
            border-color: #cbd5e1;
        }
    </style>
</head>
<body>

<div class="container py-4">
    <!-- Title Card -->
    <div class="bg-gradient-primary text-white p-4 rounded-4 shadow-sm mb-5 border-0">
        <div class="d-flex align-items-center justify-content-between">
            <div>
                <span class="badge bg-warning text-dark px-3 py-1 rounded-pill fw-bold mb-2">ĐỀ BÀI CÂU 3 (2.0 ĐIỂM)</span>
                <h2 class="fw-bold mb-1"><i class="bi bi-grid-3x3-gap-fill me-2"></i>Danh Sách Sản Phẩm Gom Nhóm Theo Seller</h2>
                <p class="text-light mb-0 opacity-90">Hiển thị đầy đủ thông tin mã cửa hàng, ảnh sản phẩm, tên, mã SP, danh mục, giá và amount.</p>
            </div>
            <a href="${pageContext.request.contextPath}/home" class="btn btn-outline-light rounded-pill fw-bold px-4">
                <i class="bi bi-house-door me-1"></i>Trang Chủ
            </a>
        </div>
    </div>

    <!-- Iterate each Seller Group -->
    <c:forEach var="entry" items="${groupedProducts}">
        <c:set var="seller" value="${entry.key}"/>
        <c:set var="productList" value="${entry.value}"/>

        <div class="card border-0 shadow-sm rounded-4 mb-5 overflow-hidden">
            <!-- Seller Header Banner -->
            <div class="seller-header-banner text-white p-4 d-flex align-items-center justify-content-between">
                <div class="d-flex align-items-center gap-3">
                    <img src="${seller.images}" class="rounded-circle border border-3 border-warning shadow-sm" style="width: 60px; height: 60px; object-fit: cover;">
                    <div>
                        <h4 class="mb-1 fw-bold text-warning">${seller.sellername}</h4>
                        <div class="d-flex gap-2 align-items-center">
                            <span class="badge bg-primary rounded-pill font-monospace fs-6">Mã cửa hàng: STORE0${seller.sellerId}</span>
                            <span class="badge bg-dark border border-secondary text-light">sellerId = ${seller.sellerId}</span>
                        </div>
                    </div>
                </div>
                <span class="badge bg-warning text-dark fs-6 rounded-pill px-3 py-2 fw-bold">
                    <i class="bi bi-box-seam me-1"></i>${productList.size()} Sản phẩm
                </span>
            </div>

            <!-- Seller Products Cards Grid -->
            <div class="card-body p-4 bg-light">
                <div class="row row-cols-1 row-cols-md-2 row-cols-lg-3 g-4">
                    <c:forEach var="p" items="${productList}">
                        <div class="col">
                            <div class="card h-100 product-card-seller p-3 shadow-sm">
                                <div class="row g-3 h-100">
                                    <!-- Left: Image -->
                                    <div class="col-5 d-flex align-items-center">
                                        <div class="position-relative w-100 rounded-3 overflow-hidden shadow-sm" style="height: 130px;">
                                            <img src="${p.images}" class="w-100 h-100" alt="${p.productName}" style="object-fit: cover;">
                                        </div>
                                    </div>

                                    <!-- Right: Product Info Strictly Following Prompt -->
                                    <div class="col-7 d-flex flex-column justify-content-between">
                                        <div>
                                            <!-- 1. Mã cửa hàng -->
                                            <div class="mb-1">
                                                <small class="text-muted fw-bold">Mã cửa hàng:</small> 
                                                <span class="badge bg-dark font-monospace">STORE0${p.seller.sellerId}</span>
                                            </div>

                                            <!-- 2. [imageLink] Tên sản phẩm (Link bấm được) -->
                                            <h6 class="fw-bold mb-2">
                                                <a href="${pageContext.request.contextPath}/product/detail?id=${p.productId}" class="text-decoration-none text-primary text-hover-underline">
                                                    Tên sản phẩm: ${p.productName}
                                                </a>
                                            </h6>

                                            <!-- 3. Mã sản phẩm -->
                                            <div class="small mb-1">
                                                <span class="text-muted fw-semibold">Mã sản phẩm:</span> 
                                                <span class="font-monospace text-dark fw-bold">${p.productCode}</span>
                                            </div>

                                            <!-- 4. Danh mục -->
                                            <div class="small mb-1">
                                                <span class="text-muted fw-semibold">Danh mục:</span> 
                                                <span class="badge bg-info-subtle text-info-emphasis rounded-pill">${p.category.categoryName}</span>
                                            </div>

                                            <!-- 5. Giá -->
                                            <div class="small mb-1">
                                                <span class="text-muted fw-semibold">Giá:</span> 
                                                <span class="fw-bold text-danger fs-6"><fmt:formatNumber value="${p.price}" pattern="#,##0"/>đ</span>
                                            </div>

                                            <!-- 6. Amount -->
                                            <div class="small">
                                                <span class="text-muted fw-semibold">Amount:</span> 
                                                <span class="badge bg-secondary-subtle text-secondary-emphasis rounded-pill">${p.amount}</span>
                                            </div>
                                        </div>

                                        <div class="mt-2">
                                            <a href="${pageContext.request.contextPath}/product/detail?id=${p.productId}" class="btn btn-sm btn-outline-primary rounded-pill w-100 fw-bold">
                                                Xem Chi Tiết <i class="bi bi-chevron-right ms-1"></i>
                                            </a>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </div>
        </div>
    </c:forEach>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
