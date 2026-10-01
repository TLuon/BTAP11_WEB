package com.tranthanhluon.webexam.controller;

import com.tranthanhluon.webexam.entity.Order_24110280;
import com.tranthanhluon.webexam.entity.User_24110280;
import com.tranthanhluon.webexam.service.OrderServiceImpl_24110280;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

@WebServlet(name = "OrderHistoryController_24110280", urlPatterns = {"/orders", "/orders/detail", "/orders/cancel"})
public class OrderHistoryController_24110280 extends HttpServlet {

    private final OrderServiceImpl_24110280 orderService = new OrderServiceImpl_24110280();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String path = req.getServletPath();
        User_24110280 user = (User_24110280) req.getSession().getAttribute("user");
        if (user == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        if ("/orders/detail".equals(path)) {
            try {
                Integer orderId = Integer.parseInt(req.getParameter("orderId"));
                Order_24110280 order = orderService.getOrderById(orderId);
                // Security check
                if (order != null && order.getUser().getUserId().equals(user.getUserId())) {
                    req.setAttribute("order", order);
                    req.getRequestDispatcher("/WEB-INF/views/order-detail.jsp").forward(req, resp);
                    return;
                } else {
                    resp.sendRedirect(req.getContextPath() + "/orders");
                    return;
                }
            } catch (Exception e) {
                resp.sendRedirect(req.getContextPath() + "/orders");
                return;
            }
        }

        // Default to /orders
        String status = req.getParameter("status");
        List<Order_24110280> orders = orderService.getOrdersByUserId(user.getUserId(), status);
        req.setAttribute("orders", orders);
        req.setAttribute("currentStatus", status == null ? "" : status);
        req.getRequestDispatcher("/WEB-INF/views/order-history.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String path = req.getServletPath();
        User_24110280 user = (User_24110280) req.getSession().getAttribute("user");
        if (user == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        if ("/orders/cancel".equals(path)) {
            try {
                Integer orderId = Integer.parseInt(req.getParameter("orderId"));
                Order_24110280 order = orderService.getOrderById(orderId);
                if (order != null && order.getUser().getUserId().equals(user.getUserId())) {
                    orderService.cancelOrder(orderId);
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        resp.sendRedirect(req.getContextPath() + "/orders");
    }
}
