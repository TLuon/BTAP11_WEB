<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đăng Nhập - WebExam De05</title>
    <!-- Bootstrap 5.3 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Bootstrap Icons -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css" rel="stylesheet">
    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&family=Outfit:wght@500;600;700;800&display=swap" rel="stylesheet">

    <style>
        body { font-family: 'Inter', sans-serif; background-color: #f8fafc; color: #334155; }
        h1, h2, h3, h4, .brand-font { font-family: 'Outfit', sans-serif; }
        .auth-card {
            border: 1px solid #e2e8f0;
            border-radius: 24px;
            background: #ffffff;
            box-shadow: 0 20px 25px -5px rgba(0, 0, 0, 0.05);
        }
        .auth-icon-circle {
            width: 70px;
            height: 70px;
            background: linear-gradient(135deg, #2563eb 0%, #1d4ed8 100%);
            color: #ffffff;
            border-radius: 50%;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            box-shadow: 0 10px 15px -3px rgba(37, 99, 235, 0.3);
        }
    </style>
</head>
<body>

<div class="container py-5">
    <div class="row justify-content-center">
        <div class="col-md-6 col-lg-5">
            <div class="card auth-card border-0 p-3 p-md-4">
                <div class="card-body">
                    <!-- Icon & Header -->
                    <div class="text-center mb-4">
                        <div class="auth-icon-circle mb-3">
                            <i class="bi bi-person-fill fs-1"></i>
                        </div>
                        <h3 class="fw-bold text-dark mb-1">Đăng Nhập System</h3>
                        <p class="text-muted small">Hệ thống Quản lý Bán hàng — Đề Số 05</p>
                    </div>

                    <c:if test="${not empty error}">
                        <div class="alert alert-danger border-0 shadow-sm alert-dismissible fade show" role="alert">
                            <i class="bi bi-exclamation-triangle-fill me-2"></i>${error}
                            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                        </div>
                    </c:if>

                    <c:if test="${not empty successMessage}">
                        <div class="alert alert-success border-0 shadow-sm alert-dismissible fade show" role="alert">
                            <i class="bi bi-check-circle-fill me-2"></i>${successMessage}
                            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                        </div>
                    </c:if>

                    <form action="${pageContext.request.contextPath}/login" method="post">
                        <div class="mb-3">
                            <label class="form-label fw-semibold text-dark">Tên đăng nhập (Username)</label>
                            <div class="input-group">
                                <span class="input-group-text bg-light border-end-0"><i class="bi bi-person text-secondary"></i></span>
                                <input type="text" name="username" class="form-control bg-light border-start-0 py-2" value="${username}" placeholder="Nhập username..." required>
                            </div>
                        </div>

                        <div class="mb-4">
                            <label class="form-label fw-semibold text-dark">Mật khẩu (Password)</label>
                            <div class="input-group">
                                <span class="input-group-text bg-light border-end-0"><i class="bi bi-lock text-secondary"></i></span>
                                <input type="password" name="password" class="form-control bg-light border-start-0 py-2" placeholder="Nhập mật khẩu..." required>
                            </div>
                        </div>

                        <button type="submit" class="btn btn-primary w-100 py-2 rounded-pill fw-bold shadow-sm fs-6">
                            <i class="bi bi-box-arrow-in-right me-1"></i> Đăng Nhập Hệ Thống
                        </button>
                    </form>

                    <hr class="my-4 text-muted">

                    <div class="text-center mb-4">
                        <p class="mb-0 text-muted small">Chưa có tài khoản? 
                            <a href="${pageContext.request.contextPath}/register" class="fw-bold text-primary text-decoration-none ms-1">Đăng ký mới</a>
                        </p>
                    </div>

                    <!-- Ghi chú tài khoản test mẫu cho Thầy/Giám khảo -->
                    <div class="p-3 bg-light rounded-4 border text-start small">
                        <p class="fw-bold mb-2 text-dark"><i class="bi bi-key-fill text-warning me-1"></i>Tài khoản Test Mẫu (Pass mặc định: <b>123456</b>):</p>
                        <ul class="mb-0 ps-3">
                            <li>Admin: <code class="bg-white px-2 py-1 rounded text-primary font-monospace">admin</code></li>
                            <li>Seller: <code class="bg-white px-2 py-1 rounded text-success font-monospace">seller1</code></li>
                            <li>User: <code class="bg-white px-2 py-1 rounded text-secondary font-monospace">user1</code></li>
                        </ul>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
