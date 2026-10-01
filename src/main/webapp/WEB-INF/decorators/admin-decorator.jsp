<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><sitemesh:write property="title">Trang Quản Trị Admin - WebExam De05</sitemesh:write></title>
    
    <!-- Bootstrap 5.3 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Bootstrap Icons -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css" rel="stylesheet">
    <!-- Google Fonts Inter -->
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">

    <style>
        body {
            font-family: 'Inter', sans-serif;
            background-color: #f1f5f9;
        }
        .sidebar {
            width: 260px;
            min-height: 100vh;
            background-color: #0f172a;
            color: #94a3b8;
        }
        .sidebar .nav-link {
            color: #94a3b8;
            padding: 12px 20px;
            border-radius: 8px;
            margin-bottom: 4px;
            font-weight: 500;
        }
        .sidebar .nav-link:hover, .sidebar .nav-link.active {
            color: #ffffff;
            background-color: #1e293b;
        }
        .sidebar .nav-link.active {
            background-color: #0d6efd;
        }
        .admin-content {
            flex: 1;
            padding: 30px;
        }
        .card-custom {
            border: none;
            border-radius: 12px;
            box-shadow: 0 4px 12px rgba(0,0,0,0.05);
        }
    </style>
    <sitemesh:write property="head"/>
</head>
<body>

<div class="d-flex">
    <!-- Sidebar Admin -->
    <div class="sidebar p-3 d-flex flex-column justify-content-between">
        <div>
            <div class="d-flex align-items-center gap-2 mb-4 px-2 pt-2">
                <i class="bi bi-shield-lock-fill text-warning fs-3"></i>
                <div>
                    <h6 class="text-white mb-0 fw-bold">ADMIN PANEL</h6>
                    <small class="text-muted">Mã đề: Đề Số 05</small>
                </div>
            </div>
            
            <hr class="border-secondary mb-3">

            <ul class="nav nav-pills flex-column">
                <li class="nav-item">
                    <a class="nav-link ${pageContext.request.requestURI.contains('/admin/category') ? 'active' : ''}" href="${pageContext.request.contextPath}/admin/category">
                        <i class="bi bi-folder-symlink me-2"></i>Quản Lý Danh Mục
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link ${pageContext.request.requestURI.contains('/admin/product') ? 'active' : ''}" href="${pageContext.request.contextPath}/admin/product">
                        <i class="bi bi-box-seam me-2"></i>Quản Lý Sản Phẩm
                    </a>
                </li>
                <li class="nav-item mt-3">
                    <a class="nav-link text-info" href="${pageContext.request.contextPath}/home" target="_blank">
                        <i class="bi bi-globe me-2"></i>Xem Website Client
                    </a>
                </li>
            </ul>
        </div>

        <div>
            <hr class="border-secondary">
            <div class="px-2 mb-3">
                <p class="small text-white mb-0 fw-bold"><i class="bi bi-person-circle me-1"></i>${sessionScope.fullname}</p>
                <span class="badge bg-warning text-dark">Admin</span>
            </div>
            <a href="${pageContext.request.contextPath}/logout" class="btn btn-outline-danger w-100 btn-sm fw-bold">
                <i class="bi bi-box-arrow-right me-1"></i>Đăng Xuất
            </a>
        </div>
    </div>

    <!-- Main Content Area -->
    <div class="admin-content">
        <!-- Top Banner / Header -->
        <div class="d-flex justify-content-between align-items-center mb-4 bg-white p-3 rounded-3 shadow-sm border">
            <div>
                <h5 class="mb-1 fw-bold text-dark"><i class="bi bi-speedometer2 text-primary me-2"></i>Trang Quản Trị Hệ Thống</h5>
                <nav class="nav nav-pills small">
                    <a class="nav-link py-1 px-2 text-primary fw-semibold" href="${pageContext.request.contextPath}/home"><i class="bi bi-house-door me-1"></i>Trang Chủ</a>
                    <a class="nav-link py-1 px-2 text-primary fw-semibold" href="${pageContext.request.contextPath}/products"><i class="bi bi-grid-3x3-gap me-1"></i>Sản phẩm</a>
                    <a class="nav-link py-1 px-2 active fw-semibold" href="${pageContext.request.contextPath}/admin/category"><i class="bi bi-gear-fill me-1"></i>Trang quản trị</a>
                </nav>
            </div>
            <div class="text-end">
                <span class="badge bg-dark fs-6 px-3 py-2">Mã đề: Đề Số 05</span>
            </div>
        </div>

        <sitemesh:write property="body"/>

        <!-- Footer Admin (Họ tên, MSSV, Mã đề) -->
        <footer class="mt-5 pt-3 border-top text-center text-muted small">
            <div class="d-flex justify-content-center gap-3">
                <span><b>Họ tên:</b> Trần Thanh Luôn</span>
                <span>|</span>
                <span><b>MSSV:</b> 24110280</span>
                <span>|</span>
                <span><b>Mã đề:</b> Đề Số 05</span>
            </div>
        </footer>
    </div>
</div>

<!-- Bootstrap 5 JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
