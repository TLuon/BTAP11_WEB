package com.tranthanhluon.webexam.controller;

import com.tranthanhluon.webexam.entity.Product_24110280;
import com.tranthanhluon.webexam.entity.Seller_24110280;
import com.tranthanhluon.webexam.service.ProductServiceImpl_24110280;
import com.tranthanhluon.webexam.service.SellerServiceImpl_24110280;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

@WebServlet(name = "SellerHomeController_24110280", urlPatterns = {"/seller/home"})
public class SellerHomeController_24110280 extends HttpServlet {

    private final ProductServiceImpl_24110280 productService = new ProductServiceImpl_24110280();
    private final SellerServiceImpl_24110280 sellerService = new SellerServiceImpl_24110280();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Integer sellerId = (Integer) req.getSession().getAttribute("sellerId");

        if (sellerId == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        Seller_24110280 seller = sellerService.getSellerById(sellerId);
        List<Product_24110280> products = productService.getProductsBySellerId(sellerId);

        req.setAttribute("seller", seller);
        req.setAttribute("products", products);
        req.getRequestDispatcher("/WEB-INF/views/seller/seller-home.jsp").forward(req, resp);
    }
}
