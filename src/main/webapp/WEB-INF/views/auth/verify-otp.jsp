<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Xác Thực Mã OTP - WebExam De05</title>
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
            background: linear-gradient(135deg, #10b981 0%, #059669 100%);
            color: #ffffff;
            border-radius: 50%;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            box-shadow: 0 10px 15px -3px rgba(16, 185, 129, 0.3);
        }
    </style>
</head>
<body>

<div class="container py-5">
    <div class="row justify-content-center">
        <div class="col-md-6 col-lg-5">
            <div class="card auth-card border-0 p-3 p-md-4 text-center">
                <div class="card-body">
                    <div class="auth-icon-circle mb-3">
                        <i class="bi bi-shield-check fs-1"></i>
                    </div>
                    <h3 class="fw-bold text-dark mb-1">Xác Thực Mã OTP</h3>
                    <p class="text-muted small">Mã OTP 6 số đã được gửi tới Email đăng ký của bạn</p>

                    <c:if test="${not empty error}">
                        <div class="alert alert-danger border-0 shadow-sm alert-dismissible fade show text-start" role="alert">
                            <i class="bi bi-exclamation-triangle-fill me-2"></i>${error}
                            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                        </div>
                    </c:if>

                    <c:if test="${not empty successMessage}">
                        <div class="alert alert-info border-0 shadow-sm alert-dismissible fade show text-start" role="alert">
                            <i class="bi bi-info-circle-fill me-2"></i>${successMessage}
                            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                        </div>
                    </c:if>

                    <c:if test="${not empty demoOtp}">
                        <div class="p-3 bg-warning-subtle text-warning-emphasis border border-warning rounded-4 mb-3 text-center">
                            <p class="small mb-1 fw-bold"><i class="bi bi-key-fill me-1"></i>MÃ OTP KÍCH HOẠT THỬ NGHIỆM:</p>
                            <span class="fs-2 font-monospace fw-bold text-danger px-3 py-1 bg-white rounded-3 shadow-sm d-inline-block">${demoOtp}</span>
                        </div>
                    </c:if>

                    <form action="${pageContext.request.contextPath}/verify-otp" method="post" class="mt-4">
                        <input type="hidden" name="username" value="${pendingUsername}">

                        <div class="mb-4">
                            <label class="form-label fw-semibold text-dark">Tài khoản kích hoạt: <span class="text-primary fw-bold">${pendingUsername}</span></label>
                            <input type="text" name="otpCode" class="form-control form-control-lg text-center fw-bold fs-2 letter-spacing-2 bg-light rounded-3 py-2" placeholder="000000" maxlength="6" required autofocus>
                        </div>

                        <button type="submit" class="btn btn-success w-100 py-2 rounded-pill fw-bold shadow-sm fs-6">
                            <i class="bi bi-check2-circle me-1"></i> Kích Hoạt Tài Khoản
                        </button>
                    </form>

                    <div class="mt-4 text-muted small">
                        Chưa nhận được mã? <a href="${pageContext.request.contextPath}/register" class="text-primary text-decoration-none fw-semibold">Đăng ký lại</a>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
