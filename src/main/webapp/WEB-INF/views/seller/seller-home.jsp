<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Kênh Seller - ${seller.sellername}</title>
    <!-- Bootstrap 5.3 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Bootstrap Icons -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css" rel="stylesheet">
    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&family=Outfit:wght@500;600;700;800&display=swap" rel="stylesheet">

    <style>
        body { font-family: 'Inter', sans-serif; background-color: #f8fafc; color: #334155; }
        h1, h2, h3, h4, .brand-font { font-family: 'Outfit', sans-serif; }
        .seller-card-hero {
            background: linear-gradient(135deg, #0f172a 0%, #1e293b 50%, #334155 100%);
            border-radius: 24px;
        }
    </style>
</head>
<body>

<div class="container py-4">
    <!-- Seller Header Banner Card -->
    <div class="card border-0 shadow-sm mb-4 seller-card-hero text-white">
        <div class="card-body p-4 p-md-5 d-flex align-items-center gap-4">
            <img src="${seller.images}" class="rounded-circle border border-4 border-warning shadow" style="width: 110px; height: 110px; object-fit: cover;">
            <div>
                <span class="badge bg-warning text-dark font-monospace fw-bold mb-2 fs-6">KÊNH CHỦ CỬA HÀNG (SELLER)</span>
                <h2 class="fw-bold mb-1 text-white">${seller.sellername}</h2>
                <p class="mb-0 text-light opacity-90"><i class="bi bi-shop me-1 text-warning"></i>Mã Cửa Hàng: <b>STORE0${seller.sellerId}</b> (sellerId = ${seller.sellerId})</p>
            </div>
        </div>
    </div>

    <div class="d-flex justify-content-between align-items-center mb-4">
        <div>
            <h4 class="fw-bold mb-0 text-dark"><i class="bi bi-box-seam-fill me-2 text-primary"></i>Danh Sách Sản Phẩm Thuộc Cửa Hàng</h4>
            <small class="text-muted">Quản lý và theo dõi danh mục hàng hóa kinh doanh</small>
        </div>
        <span class="badge bg-primary rounded-pill px-3 py-2 fs-6 fw-bold">Tổng số: ${products.size()} sản phẩm</span>
    </div>

    <!-- Products Table Card -->
    <div class="card border-0 shadow-sm rounded-4 overflow-hidden">
        <div class="card-body p-0">
            <div class="table-responsive">
                <table class="table table-hover align-middle mb-0">
                    <thead class="table-light">
                        <tr>
                            <th class="ps-4">Mã SP</th>
                            <th>Hình Ảnh</th>
                            <th>Tên Sản Phẩm</th>
                            <th>Danh Mục</th>
                            <th>Giá Bán</th>
                            <th>Số Lượng (Amount)</th>
                            <th>Kho (Stock)</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="p" items="${products}">
                            <tr>
                                <td class="ps-4 font-monospace fw-bold text-secondary">#${p.productId}</td>
                                <td>
                                    <img src="${p.images}" class="rounded-3 shadow-sm" style="width: 60px; height: 50px; object-fit: cover;">
                                </td>
                                <td>
                                    <a href="${pageContext.request.contextPath}/product/detail?id=${p.productId}" class="fw-bold text-decoration-none text-dark">
                                        ${p.productName}
                                    </a>
                                </td>
                                <td><span class="badge bg-info-subtle text-info-emphasis rounded-pill">${p.category.categoryName}</span></td>
                                <td class="fw-bold text-danger"><fmt:formatNumber value="${p.price}" pattern="#,##0"/>đ</td>
                                <td><span class="badge bg-secondary-subtle text-secondary-emphasis rounded-pill">${p.amount}</span></td>
                                <td><span class="badge bg-success-subtle text-success-emphasis rounded-pill">${p.stock}</span></td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
