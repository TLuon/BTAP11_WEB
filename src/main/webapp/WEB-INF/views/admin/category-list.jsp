<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quản Lý Danh Mục - Admin Panel</title>
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

<div class="container-fluid py-3">
    <div class="card border-0 shadow-sm rounded-4 overflow-hidden mb-4">
        <div class="card-header bg-white py-3 border-bottom d-flex justify-content-between align-items-center">
            <h5 class="mb-0 fw-bold text-dark"><i class="bi bi-folder-symlink-fill text-primary me-2"></i>QUẢN LÝ DANH MỤC (CÂU 5)</h5>
            <a href="${pageContext.request.contextPath}/admin/category/add" class="btn btn-primary rounded-pill fw-bold shadow-sm">
                <i class="bi bi-plus-circle me-1"></i> Thêm Danh Mục Mới
            </a>
        </div>

        <div class="card-body p-0">
            <c:if test="${param.message == 'saved'}">
                <div class="alert alert-success m-3 border-0 shadow-sm alert-dismissible fade show" role="alert">
                    <i class="bi bi-check-circle-fill me-2"></i>Đã lưu thông tin danh mục thành công!
                    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                </div>
            </c:if>
            <c:if test="${param.message == 'deleted'}">
                <div class="alert alert-warning m-3 border-0 shadow-sm alert-dismissible fade show" role="alert">
                    <i class="bi bi-trash-fill me-2"></i>Đã xóa danh mục khỏi hệ thống!
                    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                </div>
            </c:if>

            <div class="table-responsive">
                <table class="table table-striped table-hover align-middle mb-0">
                    <thead class="table-light">
                        <tr>
                            <th class="ps-4">ID</th>
                            <th>Hình Ảnh</th>
                            <th>Tên Danh Mục</th>
                            <th>Trạng Thái</th>
                            <th class="text-end pe-4">Thao Tác</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="c" items="${categories}">
                            <tr>
                                <td class="ps-4 font-monospace fw-bold">#${c.categoryId}</td>
                                <td>
                                    <img src="${c.images}" class="rounded-3 shadow-sm" style="width: 55px; height: 42px; object-fit: cover;">
                                </td>
                                <td class="fw-bold text-dark">${c.categoryName}</td>
                                <td>
                                    <c:choose>
                                        <c:when test="${c.status == 1}"><span class="badge bg-success-subtle text-success-emphasis rounded-pill px-3 py-1">Hoạt động</span></c:when>
                                        <c:otherwise><span class="badge bg-secondary-subtle text-secondary-emphasis rounded-pill px-3 py-1">Tạm ẩn</span></c:otherwise>
                                    </c:choose>
                                </td>
                                <td class="text-end pe-4">
                                    <a href="${pageContext.request.contextPath}/admin/category/edit?id=${c.categoryId}" class="btn btn-sm btn-outline-warning rounded-pill fw-bold me-1">
                                        <i class="bi bi-pencil-square me-1"></i>Sửa
                                    </a>
                                    <a href="${pageContext.request.contextPath}/admin/category/delete?id=${c.categoryId}" 
                                       class="btn btn-sm btn-outline-danger rounded-pill fw-bold"
                                       onclick="return confirm('Bạn có chắc chắn muốn xóa danh mục này?');">
                                        <i class="bi bi-trash me-1"></i>Xóa
                                    </a>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>

        <!-- Pagination Controls -->
        <div class="card-footer bg-white py-3 border-top d-flex justify-content-between align-items-center">
            <span class="small text-muted">Hiển thị trang <b>${currentPage}</b> / <b>${totalPages}</b></span>
            
            <nav>
                <ul class="pagination pagination-sm mb-0">
                    <li class="page-item ${currentPage <= 1 ? 'disabled' : ''}">
                        <a class="page-link rounded-start-pill" href="${pageContext.request.contextPath}/admin/category?page=${currentPage - 1}">Trang Trước</a>
                    </li>
                    
                    <c:forEach var="i" begin="1" end="${totalPages}">
                        <li class="page-item ${i == currentPage ? 'active' : ''}">
                            <a class="page-link" href="${pageContext.request.contextPath}/admin/category?page=${i}">${i}</a>
                        </li>
                    </c:forEach>

                    <li class="page-item ${currentPage >= totalPages ? 'disabled' : ''}">
                        <a class="page-link rounded-end-pill" href="${pageContext.request.contextPath}/admin/category?page=${currentPage + 1}">Trang Sau</a>
                    </li>
                </ul>
            </nav>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
