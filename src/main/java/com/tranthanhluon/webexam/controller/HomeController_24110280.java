package com.tranthanhluon.webexam.controller;

import com.tranthanhluon.webexam.entity.Product_24110280;
import com.tranthanhluon.webexam.service.ProductServiceImpl_24110280;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

@WebServlet(name = "HomeController_24110280", urlPatterns = {"/home", "/index", ""})
public class HomeController_24110280 extends HttpServlet {

    private final ProductServiceImpl_24110280 productService = new ProductServiceImpl_24110280();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        List<Product_24110280> products = productService.getAllProducts();
        req.setAttribute("products", products);
        req.getRequestDispatcher("/WEB-INF/views/home.jsp").forward(req, resp);
    }
}
