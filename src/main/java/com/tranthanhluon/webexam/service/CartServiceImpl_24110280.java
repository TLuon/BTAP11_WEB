package com.tranthanhluon.webexam.service;

import com.tranthanhluon.webexam.dao.CartDAOImpl_24110280;
import com.tranthanhluon.webexam.entity.CartItem_24110280;
import com.tranthanhluon.webexam.entity.Cart_24110280;

import java.util.List;

public class CartServiceImpl_24110280 {
    
    private final CartDAOImpl_24110280 cartDAO = new CartDAOImpl_24110280();

    public Cart_24110280 getOrCreateCart(Integer userId) {
        return cartDAO.getOrCreateCart(userId);
    }

    public List<CartItem_24110280> getCartItems(String cartId) {
        return cartDAO.getCartItems(cartId);
    }

    public void addOrUpdateCartItem(String cartId, Integer productId, Integer quantity) {
        cartDAO.addOrUpdateCartItem(cartId, productId, quantity);
    }

    public void updateCartItemQuantity(String cartItemId, Integer newQuantity) {
        cartDAO.updateCartItemQuantity(cartItemId, newQuantity);
    }

    public void removeCartItem(String cartItemId) {
        cartDAO.removeCartItem(cartItemId);
    }

    public void clearCart(String cartId) {
        cartDAO.clearCart(cartId);
    }

    public double calculateSubTotal(String cartId) {
        List<CartItem_24110280> items = cartDAO.getCartItems(cartId);
        double total = 0;
        for (CartItem_24110280 item : items) {
            total += item.getQuantity() * item.getUnitPrice();
        }
        return total;
    }
}
