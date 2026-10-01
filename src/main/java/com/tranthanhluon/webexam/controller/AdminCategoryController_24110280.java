package com.tranthanhluon.webexam.controller;

import com.tranthanhluon.webexam.entity.Category_24110280;
import com.tranthanhluon.webexam.service.CategoryServiceImpl_24110280;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

@WebServlet(name = "AdminCategoryController_24110280", urlPatterns = {"/admin/category", "/admin/category/add", "/admin/category/edit", "/admin/category/delete", "/admin/category/save"})
public class AdminCategoryController_24110280 extends HttpServlet {

    private final CategoryServiceImpl_24110280 categoryService = new CategoryServiceImpl_24110280();
    private static final int PAGE_SIZE = 5;

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String path = req.getServletPath();

        switch (path) {
            case "/admin/category/add":
                req.setAttribute("category", new Category_24110280());
                req.getRequestDispatcher("/WEB-INF/views/admin/category-form.jsp").forward(req, resp);
                break;
            case "/admin/category/edit":
                handleEdit(req, resp);
                break;
            case "/admin/category/delete":
                handleDelete(req, resp);
                break;
            case "/admin/category":
            default:
                handleList(req, resp);
                break;
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        String path = req.getServletPath();

        if ("/admin/category/save".equals(path)) {
            handleSave(req, resp);
        }
    }

    private void handleList(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int page = 1;
        String pageParam = req.getParameter("page");
        if (pageParam != null && !pageParam.isEmpty()) {
            try {
                page = Math.max(1, Integer.parseInt(pageParam));
            } catch (NumberFormatException ignored) {}
        }

        List<Category_24110280> categories = categoryService.getCategoriesWithPage(page, PAGE_SIZE);
        int totalPages = categoryService.getTotalPages(PAGE_SIZE);

        req.setAttribute("categories", categories);
        req.setAttribute("currentPage", page);
        req.setAttribute("totalPages", Math.max(1, totalPages));
        req.setAttribute("pageSize", PAGE_SIZE);
        req.getRequestDispatcher("/WEB-INF/views/admin/category-list.jsp").forward(req, resp);
    }

    private void handleEdit(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String idStr = req.getParameter("id");
        if (idStr != null) {
            try {
                Integer categoryId = Integer.parseInt(idStr);
                Category_24110280 category = categoryService.getCategoryById(categoryId);
                if (category != null) {
                    req.setAttribute("category", category);
                    req.getRequestDispatcher("/WEB-INF/views/admin/category-form.jsp").forward(req, resp);
                    return;
                }
            } catch (NumberFormatException ignored) {}
        }
        resp.sendRedirect(req.getContextPath() + "/admin/category");
    }

    private void handleDelete(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String idStr = req.getParameter("id");
        if (idStr != null) {
            try {
                Integer categoryId = Integer.parseInt(idStr);
                categoryService.deleteCategory(categoryId);
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        resp.sendRedirect(req.getContextPath() + "/admin/category?message=deleted");
    }

    private void handleSave(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String idStr = req.getParameter("categoryId");
        String categoryName = req.getParameter("categoryName");
        String images = req.getParameter("images");
        String statusStr = req.getParameter("status");

        Category_24110280 category = new Category_24110280();
        if (idStr != null && !idStr.isEmpty()) {
            category.setCategoryId(Integer.parseInt(idStr));
        }

        category.setCategoryName(categoryName);
        category.setImages(images != null && !images.trim().isEmpty() ? images.trim() : "https://picsum.photos/id/1/300/200");
        category.setStatus(statusStr != null ? Integer.parseInt(statusStr) : 1);

        boolean success = categoryService.saveCategory(category);
        if (success) {
            resp.sendRedirect(req.getContextPath() + "/admin/category?message=saved");
        } else {
            req.setAttribute("error", "Không thể lưu danh mục!");
            req.setAttribute("category", category);
            req.getRequestDispatcher("/WEB-INF/views/admin/category-form.jsp").forward(req, resp);
        }
    }
}
