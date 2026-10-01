package com.tranthanhluon.webexam.service;

import com.tranthanhluon.webexam.dao.CartDAOImpl_24110280;
import com.tranthanhluon.webexam.dao.OrderDAOImpl_24110280;
import com.tranthanhluon.webexam.entity.CartItem_24110280;
import com.tranthanhluon.webexam.entity.Cart_24110280;
import com.tranthanhluon.webexam.entity.Order_24110280;
import com.tranthanhluon.webexam.entity.OrderDetail_24110280;

import java.util.ArrayList;
import java.util.List;

public class OrderServiceImpl_24110280 {
    
    private final OrderDAOImpl_24110280 orderDAO = new OrderDAOImpl_24110280();
    private final CartDAOImpl_24110280 cartDAO = new CartDAOImpl_24110280();

    public void placeOrder(Order_24110280 order, String cartId) {
        List<CartItem_24110280> cartItems = cartDAO.getCartItems(cartId);
        if (cartItems.isEmpty()) {
            throw new RuntimeException("Giỏ hàng trống, không thể đặt hàng!");
        }

        List<OrderDetail_24110280> orderDetails = new ArrayList<>();
        double total = 0;
        for (CartItem_24110280 item : cartItems) {
            OrderDetail_24110280 od = new OrderDetail_24110280();
            od.setProduct(item.getProduct());
            od.setQuantity(item.getQuantity());
            od.setUnitPrice(item.getUnitPrice());
            orderDetails.add(od);
            total += item.getQuantity() * item.getUnitPrice();
        }
        order.setTotalAmount(total);

        orderDAO.createOrder(order, orderDetails);
        cartDAO.clearCart(cartId);
    }

    public List<Order_24110280> getOrdersByUserId(Integer userId, String status) {
        return orderDAO.getOrdersByUserId(userId, status);
    }

    public Order_24110280 getOrderById(Integer orderId) {
        return orderDAO.getOrderById(orderId);
    }

    public void cancelOrder(Integer orderId) {
        orderDAO.cancelOrder(orderId);
    }
}
