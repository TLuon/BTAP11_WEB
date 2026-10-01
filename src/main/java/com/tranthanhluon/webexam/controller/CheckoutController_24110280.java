package com.tranthanhluon.webexam.controller;

import com.tranthanhluon.webexam.entity.CartItem_24110280;
import com.tranthanhluon.webexam.entity.Cart_24110280;
import com.tranthanhluon.webexam.entity.Order_24110280;
import com.tranthanhluon.webexam.entity.User_24110280;
import com.tranthanhluon.webexam.service.CartServiceImpl_24110280;
import com.tranthanhluon.webexam.service.OrderServiceImpl_24110280;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

@WebServlet(name = "CheckoutController_24110280", urlPatterns = {"/checkout", "/checkout/place-order"})
public class CheckoutController_24110280 extends HttpServlet {

    private final CartServiceImpl_24110280 cartService = new CartServiceImpl_24110280();
    private final OrderServiceImpl_24110280 orderService = new OrderServiceImpl_24110280();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        User_24110280 user = (User_24110280) req.getSession().getAttribute("user");
        if (user == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        Cart_24110280 cart = cartService.getOrCreateCart(user.getUserId());
        List<CartItem_24110280> items = cartService.getCartItems(cart.getCartId());
        
        if (items.isEmpty()) {
            resp.sendRedirect(req.getContextPath() + "/cart");
            return;
        }

        double subtotal = cartService.calculateSubTotal(cart.getCartId());
        req.setAttribute("cartItems", items);
        req.setAttribute("subtotal", subtotal);
        
        req.getRequestDispatcher("/WEB-INF/views/checkout.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String path = req.getServletPath();
        if (!"/checkout/place-order".equals(path)) {
            resp.sendRedirect(req.getContextPath() + "/checkout");
            return;
        }

        User_24110280 user = (User_24110280) req.getSession().getAttribute("user");
        if (user == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        Cart_24110280 cart = cartService.getOrCreateCart(user.getUserId());
        
        try {
            Order_24110280 order = new Order_24110280();
            order.setUser(user);
            order.setFullName(req.getParameter("fullName"));
            order.setPhone(req.getParameter("phone"));
            order.setAddress(req.getParameter("address"));
            order.setNote(req.getParameter("note"));
            // paymentMethod default is COD in entity

            orderService.placeOrder(order, cart.getCartId());
            
            req.setAttribute("orderId", order.getOrderId());
            req.getRequestDispatcher("/WEB-INF/views/order-success.jsp").forward(req, resp);

        } catch (Exception e) {
            req.setAttribute("error", e.getMessage());
            List<CartItem_24110280> items = cartService.getCartItems(cart.getCartId());
            double subtotal = cartService.calculateSubTotal(cart.getCartId());
            req.setAttribute("cartItems", items);
            req.setAttribute("subtotal", subtotal);
            req.getRequestDispatcher("/WEB-INF/views/checkout.jsp").forward(req, resp);
        }
    }
}
