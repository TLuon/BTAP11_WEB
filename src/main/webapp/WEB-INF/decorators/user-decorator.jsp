<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><sitemesh:write property="title">WebExam Đề Số 05 - Trần Thanh Luôn</sitemesh:write></title>
    
    <!-- Bootstrap 5.3 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Bootstrap Icons -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css" rel="stylesheet">
    <!-- Google Fonts Plus Inter & Outfit -->
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&family=Outfit:wght@500;600;700;800&display=swap" rel="stylesheet">

    <style>
        :root {
            --primary-gradient: linear-gradient(135deg, #2563eb 0%, #1d4ed8 50%, #1e40af 100%);
            --accent-gradient: linear-gradient(135deg, #f59e0b 0%, #d97706 100%);
            --dark-card: #0f172a;
        }

        body {
            font-family: 'Inter', sans-serif;
            background-color: #f8fafc;
            color: #334155;
            min-height: 100vh;
            display: flex;
            flex-direction: column;
        }

        h1, h2, h3, h4, .navbar-brand {
            font-family: 'Outfit', 'Inter', sans-serif;
        }

        .navbar-custom {
            background: var(--primary-gradient);
            backdrop-filter: blur(10px);
        }

        .navbar-brand {
            font-weight: 800;
            letter-spacing: -0.5px;
        }

        .main-content {
            flex: 1;
        }

        .product-card {
            transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
            border: 1px solid #e2e8f0;
            border-radius: 16px;
            overflow: hidden;
            background: #ffffff;
        }

        .product-card:hover {
            transform: translateY(-6px);
            box-shadow: 0 20px 25px -5px rgba(0, 0, 0, 0.1), 0 8px 10px -6px rgba(0, 0, 0, 0.1) !important;
            border-color: #cbd5e1;
        }

        .product-card img {
            transition: transform 0.5s ease;
        }

        .product-card:hover img {
            transform: scale(1.05);
        }

        .badge-pill-custom {
            border-radius: 50rem;
            padding: 6px 14px;
            font-weight: 600;
            font-size: 0.75rem;
            letter-spacing: 0.3px;
        }

        .footer-custom {
            background-color: #0f172a;
            color: #94a3b8;
        }
        
        .footer-badge {
            background: rgba(255, 255, 255, 0.08);
            border: 1px solid rgba(255, 255, 255, 0.15);
            backdrop-filter: blur(5px);
        }
    </style>
    <sitemesh:write property="head"/>
</head>
<body>

    <!-- Header Navigation -->
    <nav class="navbar navbar-expand-lg navbar-dark navbar-custom shadow-sm sticky-top py-3">
        <div class="container">
            <a class="navbar-brand d-flex align-items-center gap-2 text-white" href="${pageContext.request.contextPath}/home">
                <span class="bg-warning text-dark rounded-3 px-2 py-1 fs-4 fw-bold">
                    <i class="bi bi-bag-check-fill"></i>
                </span>
                <span>LUÔN MARKET <span class="badge bg-warning text-dark fs-6 ms-1 align-middle">Đề 05</span></span>
            </a>

            <button class="navbar-toggler border-0" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                <span class="navbar-toggler-icon"></span>
            </button>

            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav me-auto mb-2 mb-lg-0 fw-semibold ms-lg-4">
                    <li class="nav-item">
                        <a class="nav-link text-white px-3" href="${pageContext.request.contextPath}/home">
                            <i class="bi bi-house-door-fill me-1 opacity-75"></i>Trang Chủ
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link text-white px-3" href="${pageContext.request.contextPath}/products">
                            <i class="bi bi-grid-3x3-gap-fill me-1 opacity-75"></i>Sản phẩm
                        </a>
                    </li>
                    
                    <c:if test="${not empty sessionScope.sellerId}">
                        <li class="nav-item">
                            <a class="nav-link text-warning fw-bold px-3" href="${pageContext.request.contextPath}/seller/home">
                                <i class="bi bi-shop-window me-1"></i>Kênh Seller
                            </a>
                        </li>
                    </c:if>

                    <!-- Trang quản trị (chỉ hiển thị khi tài khoản đăng nhập là Admin) -->
                    <c:if test="${sessionScope.roleId == 1}">
                        <li class="nav-item">
                            <a class="nav-link text-warning fw-bold px-3" href="${pageContext.request.contextPath}/admin/category">
                                <i class="bi bi-speedometer2 me-1"></i>Trang quản trị
                            </a>
                        </li>
                    </c:if>
                </ul>

                <div class="d-flex align-items-center gap-2">
                    <c:choose>
                        <c:when test="${not empty sessionScope.account}">
                            <div class="dropdown">
                                <button class="btn btn-light rounded-pill dropdown-toggle d-flex align-items-center gap-2 px-3 fw-semibold shadow-sm" type="button" data-bs-toggle="dropdown">
                                    <i class="bi bi-person-circle fs-5 text-primary"></i>
                                    <span>${sessionScope.fullname}</span>
                                    <span class="badge bg-primary rounded-pill">${sessionScope.roleName}</span>
                                </button>
                                <ul class="dropdown-menu dropdown-menu-end shadow-lg border-0 rounded-3 mt-2">
                                    <li><a class="dropdown-item py-2" href="${pageContext.request.contextPath}/cart"><i class="bi bi-cart-fill text-warning me-2"></i>Giỏ hàng</a></li>
                                    <li><a class="dropdown-item py-2" href="${pageContext.request.contextPath}/orders"><i class="bi bi-card-checklist text-info me-2"></i>Lịch sử đơn hàng</a></li>
                                    <li><hr class="dropdown-divider"></li>
                                    <c:if test="${sessionScope.roleId == 1}">
                                        <li><a class="dropdown-item py-2" href="${pageContext.request.contextPath}/admin/category"><i class="bi bi-gear-fill text-primary me-2"></i>Trang quản trị</a></li>
                                        <li><hr class="dropdown-divider"></li>
                                    </c:if>
                                    <c:if test="${not empty sessionScope.sellerId}">
                                        <li><a class="dropdown-item py-2" href="${pageContext.request.contextPath}/seller/home"><i class="bi bi-store text-success me-2"></i>Quản lý Shop</a></li>
                                        <li><hr class="dropdown-divider"></li>
                                    </c:if>
                                    <li><a class="dropdown-item py-2 text-danger fw-bold" href="${pageContext.request.contextPath}/logout"><i class="bi bi-box-arrow-right me-2"></i>Đăng xuất</a></li>
                                </ul>
                            </div>
                        </c:when>
                        <c:otherwise>
                            <a href="${pageContext.request.contextPath}/login" class="btn btn-outline-light rounded-pill px-4 fw-semibold">
                                <i class="bi bi-box-arrow-in-right me-1"></i>Đăng nhập
                            </a>
                            <a href="${pageContext.request.contextPath}/register" class="btn btn-warning rounded-pill px-4 fw-bold text-dark shadow-sm">
                                <i class="bi bi-person-plus-fill me-1"></i>Đăng Ký
                            </a>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
        </div>
    </nav>

    <!-- Main Content Body -->
    <main class="main-content py-4">
        <sitemesh:write property="body"/>
    </main>

    <!-- Footer đồng bộ toàn site (Họ tên, MSSV, Mã đề) -->
    <footer class="footer-custom py-4 border-top border-secondary">
        <div class="container text-center text-md-between d-flex flex-column flex-md-row align-items-center justify-content-between gap-3">
            <div>
                <h6 class="text-white fw-bold mb-1 d-flex align-items-center gap-2 justify-content-center justify-content-md-start">
                    <i class="bi bi-code-slash text-warning fs-5"></i>
                    HỆ THỐNG QUẢN LÝ BÁN HÀNG
                </h6>
                <p class="small text-muted mb-0">Đồ án thi quá trình môn Lập trình Web</p>
            </div>
            <div class="text-md-end">
                <div class="d-flex gap-2 justify-content-center justify-content-md-end mb-1">
                    <span class="badge footer-badge text-warning fs-6">Họ tên: Trần Thanh Luôn</span>
                    <span class="badge footer-badge text-info fs-6">MSSV: 24110280</span>
                    <span class="badge footer-badge text-success fs-6">Mã đề: Đề Số 05</span>
                </div>
            </div>
        </div>
    </footer>

    <!-- Bootstrap 5 JS Bundle -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
