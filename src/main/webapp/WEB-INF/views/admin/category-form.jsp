<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${category.categoryId != null ? 'Chỉnh Sửa' : 'Thêm'} Danh Mục - Admin Panel</title>
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
        <div class="col-md-8">
            <div class="card border-0 shadow-sm rounded-4 overflow-hidden">
                <div class="card-header bg-white py-3 border-bottom">
                    <h5 class="mb-0 fw-bold text-dark">
                        <i class="bi bi-pencil-square text-primary me-2"></i>
                        ${category.categoryId != null ? 'CHỈNH SỬA DANH MỤC' : 'THÊM DANH MỤC MỚI'}
                    </h5>
                </div>

                <div class="card-body p-4">
                    <c:if test="${not empty error}">
                        <div class="alert alert-danger border-0 shadow-sm alert-dismissible fade show" role="alert">
                            <i class="bi bi-exclamation-triangle-fill me-2"></i>${error}
                            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                        </div>
                    </c:if>

                    <form action="${pageContext.request.contextPath}/admin/category/save" method="post">
                        <input type="hidden" name="categoryId" value="${category.categoryId}">

                        <div class="mb-3">
                            <label class="form-label fw-semibold text-dark">Tên danh mục <span class="text-danger">*</span></label>
                            <input type="text" name="categoryName" class="form-control bg-light py-2" value="${category.categoryName}" placeholder="Nhập tên danh mục..." required>
                        </div>

                        <div class="mb-3">
                            <label class="form-label fw-semibold text-dark">Link đường dẫn hình ảnh (URL)</label>
                            <input type="url" name="images" class="form-control bg-light py-2" value="${category.images}" placeholder="https://picsum.photos/id/1/300/200">
                        </div>

                        <div class="mb-4">
                            <label class="form-label fw-semibold text-dark">Trạng thái</label>
                            <select name="status" class="form-select bg-light py-2">
                                <option value="1" ${category.status == 1 ? 'selected' : ''}>Hoạt động</option>
                                <option value="0" ${category.status == 0 ? 'selected' : ''}>Tạm ẩn</option>
                            </select>
                        </div>

                        <div class="d-flex justify-content-between pt-3 border-top">
                            <a href="${pageContext.request.contextPath}/admin/category" class="btn btn-outline-secondary rounded-pill fw-semibold px-4">
                                <i class="bi bi-arrow-left me-1"></i>Hủy Bỏ
                            </a>
                            <button type="submit" class="btn btn-primary rounded-pill fw-bold px-4 shadow-sm">
                                <i class="bi bi-save me-1"></i> Lưu Danh Mục
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
