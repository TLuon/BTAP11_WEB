package com.tranthanhluon.webexam.controller;

import com.tranthanhluon.webexam.entity.Product_24110280;
import com.tranthanhluon.webexam.service.ProductServiceImpl_24110280;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet(name = "ProductDetailController_24110280", urlPatterns = {"/product/detail"})
public class ProductDetailController_24110280 extends HttpServlet {

    private final ProductServiceImpl_24110280 productService = new ProductServiceImpl_24110280();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String idStr = req.getParameter("id");
        if (idStr == null || idStr.trim().isEmpty()) {
            resp.sendRedirect(req.getContextPath() + "/products");
            return;
        }

        try {
            Integer productId = Integer.parseInt(idStr);
            Product_24110280 product = productService.getProductById(productId);

            if (product == null) {
                resp.sendRedirect(req.getContextPath() + "/products");
                return;
            }

            req.setAttribute("product", product);
            req.getRequestDispatcher("/WEB-INF/views/product/product-detail.jsp").forward(req, resp);
        } catch (NumberFormatException e) {
            resp.sendRedirect(req.getContextPath() + "/products");
        }
    }
}
