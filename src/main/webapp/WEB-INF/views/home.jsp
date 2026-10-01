<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Trang Chủ - Luôn Market Đề 05</title>
    <!-- Bootstrap 5.3 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Bootstrap Icons -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css" rel="stylesheet">
    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&family=Outfit:wght@500;600;700;800&display=swap" rel="stylesheet">

    <style>
        body { font-family: 'Inter', sans-serif; background-color: #f8fafc; color: #334155; }
        h1, h2, h3, h4, .brand-font { font-family: 'Outfit', sans-serif; }
        .hero-section {
            background: linear-gradient(135deg, #1e3a8a 0%, #2563eb 50%, #3b82f6 100%);
            border-radius: 24px;
            box-shadow: 0 20px 25px -5px rgba(37, 99, 235, 0.25);
        }
        .product-card {
            transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
            border: 1px solid #e2e8f0;
            border-radius: 18px;
            overflow: hidden;
            background: #ffffff;
        }
        .product-card:hover {
            transform: translateY(-8px);
            box-shadow: 0 20px 25px -5px rgba(0, 0, 0, 0.1), 0 8px 10px -6px rgba(0, 0, 0, 0.1) !important;
            border-color: #cbd5e1;
        }
        .product-card img {
            transition: transform 0.5s ease;
        }
        .product-card:hover img {
            transform: scale(1.06);
        }
        .btn-gradient-primary {
            background: linear-gradient(135deg, #2563eb 0%, #1d4ed8 100%);
            color: #fff;
            border: none;
        }
        .btn-gradient-primary:hover {
            background: linear-gradient(135deg, #1d4ed8 0%, #1e40af 100%);
            color: #fff;
        }
    </style>
</head>
<body>

<div class="container py-4">
    <!-- Hero Banner Premium -->
    <div class="p-5 mb-5 hero-section text-white position-relative overflow-hidden">
        <div class="row align-items-center">
            <div class="col-lg-8 py-2">
                <span class="badge bg-warning text-dark px-3 py-2 rounded-pill fw-bold mb-3 shadow-sm">
                    <i class="bi bi-star-fill me-1"></i> ĐỀ THI QUÁ TRÌNH — ĐỀ SỐ 05
                </span>
                <h1 class="display-4 fw-extrabold mb-3">Chào mừng đến với Luôn Market</h1>
                <p class="fs-5 text-light opacity-90 mb-4 leading-relaxed">
                    Hệ thống Thương mại Điện tử đa cửa hàng (Multi-Seller Marketplace) xây dựng theo kiến trúc 3 tầng chuẩn mực trên Java 21, Jakarta EE 10 & Hibernate JPA.
                </p>
                <div class="d-flex flex-wrap gap-3">
                    <a href="${pageContext.request.contextPath}/products" class="btn btn-warning btn-lg rounded-pill fw-bold text-dark px-4 shadow">
                        <i class="bi bi-grid-3x3-gap-fill me-2"></i>Xem Gom Nhóm Seller (Câu 3)
                    </a>
                    <c:if test="${sessionScope.roleId == 1}">
                        <a href="${pageContext.request.contextPath}/admin/category" class="btn btn-outline-light btn-lg rounded-pill fw-bold px-4">
                            <i class="bi bi-speedometer2 me-2"></i>Trang Quản Trị Admin (Câu 5)
                        </a>
                    </c:if>
                </div>
            </div>
            <div class="col-lg-4 d-none d-lg-block text-center position-relative">
                <div class="bg-white bg-opacity-10 p-4 rounded-4 backdrop-blur border border-white border-opacity-20 text-start">
                    <h6 class="text-warning fw-bold mb-3"><i class="bi bi-person-badge-fill me-2"></i>THÔNG TIN SINH VIÊN</h6>
                    <p class="mb-1 text-white"><b>Họ tên:</b> Trần Thanh Luôn</p>
                    <p class="mb-1 text-white"><b>MSSV:</b> 24110280</p>
                    <p class="mb-1 text-white"><b>Mã đề:</b> Đề Số 05</p>
                    <p class="mb-0 text-white-50 small">Giáo viên: Nguyễn Hữu Trung</p>
                </div>
            </div>
        </div>
    </div>

    <!-- Product Grid Section Header -->
    <div class="d-flex justify-content-between align-items-end mb-4">
        <div>
            <span class="badge bg-primary-subtle text-primary fw-bold px-3 py-1 rounded-pill mb-2">DANH SÁCH MỚI NHẤT</span>
            <h2 class="fw-bold mb-0 text-dark"><i class="bi bi-fire text-danger me-2"></i>Sản Phẩm Nổi Bật</h2>
        </div>
        <a href="${pageContext.request.contextPath}/products" class="btn btn-outline-primary rounded-pill fw-bold px-4">
            Xem Tất Cả Gom Nhóm <i class="bi bi-arrow-right ms-1"></i>
        </a>
    </div>

    <!-- Product Grid Cards -->
    <div class="row row-cols-1 row-cols-md-3 row-cols-lg-4 g-4">
        <c:forEach var="p" items="${products}">
            <div class="col">
                <div class="card h-100 product-card shadow-sm">
                    <div class="position-relative overflow-hidden bg-light" style="height: 220px;">
                        <img src="${p.images}" class="card-img-top w-100 h-100" alt="${p.productName}" style="object-fit: cover;">
                        <span class="position-absolute top-0 start-0 m-3 badge bg-dark bg-opacity-75 backdrop-blur rounded-pill px-3 py-2 small">
                            ${p.category.categoryName}
                        </span>
                    </div>

                    <div class="card-body d-flex flex-column p-4">
                        <div class="mb-2">
                            <span class="badge bg-info-subtle text-info-emphasis rounded-pill px-3 py-1 text-truncate d-inline-block max-w-100">
                                <i class="bi bi-shop me-1"></i>${p.seller.sellername}
                            </span>
                        </div>
                        <h6 class="card-title fw-bold text-dark mb-2">
                            <a href="${pageContext.request.contextPath}/product/detail?id=${p.productId}" class="text-decoration-none text-dark hover-primary">
                                ${p.productName}
                            </a>
                        </h6>
                        <div class="mt-auto pt-3 border-top">
                            <div class="d-flex justify-content-between align-items-center mb-3">
                                <div>
                                    <small class="text-muted d-block">Giá bán</small>
                                    <span class="fs-5 fw-extrabold text-danger">
                                        <fmt:formatNumber value="${p.price}" pattern="#,##0"/>đ
                                    </span>
                                </div>
                                <span class="badge bg-secondary-subtle text-secondary-emphasis rounded-pill px-2 py-1 small">
                                    SL: ${p.amount}
                                </span>
                            </div>
                            <a href="${pageContext.request.contextPath}/product/detail?id=${p.productId}" class="btn btn-gradient-primary w-100 rounded-pill fw-bold py-2 shadow-sm">
                                <i class="bi bi-eye me-1"></i>Xem Chi Tiết
                            </a>
                        </div>
                    </div>
                </div>
            </div>
        </c:forEach>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
