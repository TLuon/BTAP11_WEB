package com.tranthanhluon.webexam.controller;

import com.tranthanhluon.webexam.entity.Product_24110280;
import com.tranthanhluon.webexam.entity.Seller_24110280;
import com.tranthanhluon.webexam.service.ProductServiceImpl_24110280;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.*;
import java.util.stream.Collectors;

@WebServlet(name = "ProductGroupController_24110280", urlPatterns = {"/products"})
public class ProductGroupController_24110280 extends HttpServlet {

    private final ProductServiceImpl_24110280 productService = new ProductServiceImpl_24110280();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        List<Product_24110280> allProducts = productService.getProductsGroupedBySeller();

        Map<Seller_24110280, List<Product_24110280>> groupedBySeller = allProducts.stream()
                .collect(Collectors.groupingBy(Product_24110280::getSeller, LinkedHashMap::new, Collectors.toList()));

        req.setAttribute("groupedProducts", groupedBySeller);
        req.getRequestDispatcher("/WEB-INF/views/product/products-by-seller.jsp").forward(req, resp);
    }
}
