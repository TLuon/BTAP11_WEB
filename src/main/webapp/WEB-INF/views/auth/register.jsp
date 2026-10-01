<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đăng Ký Tài Khoản - WebExam De05</title>
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
            background: linear-gradient(135deg, #f59e0b 0%, #d97706 100%);
            color: #ffffff;
            border-radius: 50%;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            box-shadow: 0 10px 15px -3px rgba(245, 158, 11, 0.3);
        }
    </style>
</head>
<body>

<div class="container py-5">
    <div class="row justify-content-center">
        <div class="col-md-7 col-lg-6">
            <div class="card auth-card border-0 p-3 p-md-4">
                <div class="card-body">
                    <div class="text-center mb-4">
                        <div class="auth-icon-circle mb-3">
                            <i class="bi bi-person-plus-fill fs-1"></i>
                        </div>
                        <h3 class="fw-bold text-dark mb-1">Tạo Tài Khoản Mới</h3>
                        <p class="text-muted small">Đăng ký tài khoản và nhận mã xác thực OTP qua Email</p>
                    </div>

                    <c:if test="${not empty error}">
                        <div class="alert alert-danger border-0 shadow-sm alert-dismissible fade show" role="alert">
                            <i class="bi bi-exclamation-triangle-fill me-2"></i>${error}
                            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                        </div>
                    </c:if>

                    <form action="${pageContext.request.contextPath}/register" method="post">
                        <div class="row g-3">
                            <div class="col-md-6">
                                <label class="form-label fw-semibold text-dark">Tên đăng nhập</label>
                                <input type="text" name="username" class="form-control bg-light py-2" value="${username}" placeholder="Username..." required>
                            </div>
                            <div class="col-md-6">
                                <label class="form-label fw-semibold text-dark">Họ và tên</label>
                                <input type="text" name="fullname" class="form-control bg-light py-2" value="${fullname}" placeholder="Họ và tên..." required>
                            </div>
                            <div class="col-md-12">
                                <label class="form-label fw-semibold text-dark">Địa chỉ Email (Nhận mã OTP)</label>
                                <input type="email" name="email" class="form-control bg-light py-2" value="${email}" placeholder="example@email.com" required>
                            </div>
                            <div class="col-md-6">
                                <label class="form-label fw-semibold text-dark">Số điện thoại</label>
                                <input type="tel" name="phone" class="form-control bg-light py-2" value="${phone}" placeholder="0901234567">
                            </div>
                            <div class="col-md-6">
                                <label class="form-label fw-semibold text-dark">Mật khẩu</label>
                                <input type="password" name="password" class="form-control bg-light py-2" placeholder="Mật khẩu..." required>
                            </div>
                        </div>

                        <button type="submit" class="btn btn-warning w-100 py-2 rounded-pill fw-bold text-dark mt-4 shadow-sm fs-6">
                            <i class="bi bi-send-check me-1"></i> Đăng Ký & Gửi Mã OTP Email
                        </button>
                    </form>

                    <hr class="my-4 text-muted">

                    <div class="text-center">
                        <p class="mb-0 text-muted small">Đã có tài khoản? 
                            <a href="${pageContext.request.contextPath}/login" class="fw-bold text-primary text-decoration-none ms-1">Đăng nhập ngay</a>
                        </p>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
