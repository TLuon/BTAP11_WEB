package com.tranthanhluon.webexam.controller;

import com.tranthanhluon.webexam.entity.Category_24110280;
import com.tranthanhluon.webexam.entity.Product_24110280;
import com.tranthanhluon.webexam.entity.Seller_24110280;
import com.tranthanhluon.webexam.service.CategoryServiceImpl_24110280;
import com.tranthanhluon.webexam.service.ProductServiceImpl_24110280;
import com.tranthanhluon.webexam.service.SellerServiceImpl_24110280;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.Date;
import java.util.List;

@WebServlet(name = "AdminProductController_24110280", urlPatterns = {"/admin/product", "/admin/product/add", "/admin/product/edit", "/admin/product/delete", "/admin/product/save"})
public class AdminProductController_24110280 extends HttpServlet {

    private final ProductServiceImpl_24110280 productService = new ProductServiceImpl_24110280();
    private final CategoryServiceImpl_24110280 categoryService = new CategoryServiceImpl_24110280();
    private final SellerServiceImpl_24110280 sellerService = new SellerServiceImpl_24110280();
    private static final int PAGE_SIZE = 5;

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String path = req.getServletPath();

        switch (path) {
            case "/admin/product/add":
                req.setAttribute("product", new Product_24110280());
                loadDropdownData(req);
                req.getRequestDispatcher("/WEB-INF/views/admin/product-form.jsp").forward(req, resp);
                break;
            case "/admin/product/edit":
                handleEdit(req, resp);
                break;
            case "/admin/product/delete":
                handleDelete(req, resp);
                break;
            case "/admin/product":
            default:
                handleList(req, resp);
                break;
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        String path = req.getServletPath();

        if ("/admin/product/save".equals(path)) {
            handleSave(req, resp);
        }
    }

    private void loadDropdownData(HttpServletRequest req) {
        req.setAttribute("categories", categoryService.getAllCategories());
        req.setAttribute("sellers", sellerService.getAllSellers());
    }

    private void handleList(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int page = 1;
        String pageParam = req.getParameter("page");
        if (pageParam != null && !pageParam.isEmpty()) {
            try {
                page = Math.max(1, Integer.parseInt(pageParam));
            } catch (NumberFormatException ignored) {}
        }

        List<Product_24110280> products = productService.getProductsWithPage(page, PAGE_SIZE);
        int totalPages = productService.getTotalPages(PAGE_SIZE);

        req.setAttribute("products", products);
        req.setAttribute("currentPage", page);
        req.setAttribute("totalPages", Math.max(1, totalPages));
        req.setAttribute("pageSize", PAGE_SIZE);
        req.getRequestDispatcher("/WEB-INF/views/admin/product-list.jsp").forward(req, resp);
    }

    private void handleEdit(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String idStr = req.getParameter("id");
        if (idStr != null) {
            try {
                Integer productId = Integer.parseInt(idStr);
                Product_24110280 product = productService.getProductById(productId);
                if (product != null) {
                    req.setAttribute("product", product);
                    loadDropdownData(req);
                    req.getRequestDispatcher("/WEB-INF/views/admin/product-form.jsp").forward(req, resp);
                    return;
                }
            } catch (NumberFormatException ignored) {}
        }
        resp.sendRedirect(req.getContextPath() + "/admin/product");
    }

    private void handleDelete(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String idStr = req.getParameter("id");
        if (idStr != null) {
            try {
                Integer productId = Integer.parseInt(idStr);
                productService.deleteProduct(productId);
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        resp.sendRedirect(req.getContextPath() + "/admin/product?message=deleted");
    }

    private void handleSave(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String idStr = req.getParameter("productId");
        String productName = req.getParameter("productName");
        String productCodeStr = req.getParameter("productCode");
        String categoryIdStr = req.getParameter("categoryId");
        String sellerIdStr = req.getParameter("sellerId");
        String priceStr = req.getParameter("price");
        String amountStr = req.getParameter("amount");
        String stockStr = req.getParameter("stock");
        String images = req.getParameter("images");
        String description = req.getParameter("description");
        String statusStr = req.getParameter("status");

        Product_24110280 product = new Product_24110280();
        if (idStr != null && !idStr.isEmpty()) {
            product.setProductId(Integer.parseInt(idStr));
        }

        try {
            product.setProductName(productName);
            product.setProductCode(Long.parseLong(productCodeStr));
            
            Category_24110280 category = categoryService.getCategoryById(Integer.parseInt(categoryIdStr));
            product.setCategory(category);

            Seller_24110280 seller = sellerService.getSellerById(Integer.parseInt(sellerIdStr));
            product.setSeller(seller);

            product.setPrice(Double.parseDouble(priceStr));
            product.setAmount(Integer.parseInt(amountStr));
            product.setStock(Integer.parseInt(stockStr));
            product.setImages(images != null && !images.trim().isEmpty() ? images.trim() : "https://picsum.photos/id/1/500/400");
            product.setDescription(description);
            product.setStatus(statusStr != null ? Integer.parseInt(statusStr) : 1);
            if (product.getCreateDate() == null) {
                product.setCreateDate(new Date());
            }

            boolean success = productService.saveProduct(product);
            if (success) {
                resp.sendRedirect(req.getContextPath() + "/admin/product?message=saved");
                return;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        req.setAttribute("error", "Vui lòng kiểm tra lại dữ liệu nhập!");
        req.setAttribute("product", product);
        loadDropdownData(req);
        req.getRequestDispatcher("/WEB-INF/views/admin/product-form.jsp").forward(req, resp);
    }
}
