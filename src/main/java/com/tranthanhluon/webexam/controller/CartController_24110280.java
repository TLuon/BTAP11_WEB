package com.tranthanhluon.webexam.controller;

import com.tranthanhluon.webexam.entity.CartItem_24110280;
import com.tranthanhluon.webexam.entity.Cart_24110280;
import com.tranthanhluon.webexam.entity.User_24110280;
import com.tranthanhluon.webexam.service.CartServiceImpl_24110280;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

@WebServlet(name = "CartController_24110280", urlPatterns = {"/cart", "/cart/add", "/cart/update", "/cart/delete", "/cart/clear"})
public class CartController_24110280 extends HttpServlet {

    private final CartServiceImpl_24110280 cartService = new CartServiceImpl_24110280();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String path = req.getServletPath();
        User_24110280 user = (User_24110280) req.getSession().getAttribute("user");
        if (user == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        Cart_24110280 cart = cartService.getOrCreateCart(user.getUserId());

        if ("/cart/delete".equals(path)) {
            String cartItemId = req.getParameter("cartItemId");
            if (cartItemId != null) {
                cartService.removeCartItem(cartItemId);
            }
            resp.sendRedirect(req.getContextPath() + "/cart");
            return;
        }

        if ("/cart/clear".equals(path)) {
            cartService.clearCart(cart.getCartId());
            resp.sendRedirect(req.getContextPath() + "/cart");
            return;
        }

        // Default to /cart view
        List<CartItem_24110280> items = cartService.getCartItems(cart.getCartId());
        double subtotal = cartService.calculateSubTotal(cart.getCartId());
        
        req.setAttribute("cartItems", items);
        req.setAttribute("subtotal", subtotal);
        req.getRequestDispatcher("/WEB-INF/views/cart.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String path = req.getServletPath();
        User_24110280 user = (User_24110280) req.getSession().getAttribute("user");
        if (user == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        Cart_24110280 cart = cartService.getOrCreateCart(user.getUserId());

        if ("/cart/add".equals(path)) {
            try {
                Integer productId = Integer.parseInt(req.getParameter("productId"));
                Integer quantity = Integer.parseInt(req.getParameter("quantity"));
                cartService.addOrUpdateCartItem(cart.getCartId(), productId, quantity);
            } catch (Exception e) {
                // handle parsing error or not found
                e.printStackTrace();
            }
            // Optional: redirect back to where user was, or to cart
            resp.sendRedirect(req.getContextPath() + "/cart");
            return;
        }

        if ("/cart/update".equals(path)) {
            try {
                String cartItemId = req.getParameter("cartItemId");
                Integer quantity = Integer.parseInt(req.getParameter("quantity"));
                cartService.updateCartItemQuantity(cartItemId, quantity);
            } catch (Exception e) {
                e.printStackTrace();
            }
            resp.sendRedirect(req.getContextPath() + "/cart");
            return;
        }

        resp.sendRedirect(req.getContextPath() + "/cart");
    }
}
