package com.tranthanhluon.webexam.dao;

import com.tranthanhluon.webexam.entity.Order_24110280;
import com.tranthanhluon.webexam.entity.OrderDetail_24110280;
import com.tranthanhluon.webexam.entity.Product_24110280;
import com.tranthanhluon.webexam.util.JPAUtils_24110280;
import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;
import jakarta.persistence.TypedQuery;

import java.util.List;

public class OrderDAOImpl_24110280 {

    public void createOrder(Order_24110280 order, List<OrderDetail_24110280> details) {
        EntityManager em = JPAUtils_24110280.getEntityManager();
        EntityTransaction trans = em.getTransaction();
        try {
            trans.begin();
            
            // Check stock and deduct
            for (OrderDetail_24110280 detail : details) {
                Product_24110280 product = em.find(Product_24110280.class, detail.getProduct().getProductId());
                if (product.getStock() < detail.getQuantity()) {
                    throw new RuntimeException("Sản phẩm " + product.getProductName() + " không đủ số lượng tồn kho!");
                }
                product.setStock(product.getStock() - detail.getQuantity());
                em.merge(product);
                
                detail.setOrder(order);
                order.getOrderDetails().add(detail);
            }
            
            em.persist(order);
            trans.commit();
        } catch (Exception e) {
            trans.rollback();
            throw e;
        } finally {
            em.close();
        }
    }

    public List<Order_24110280> getOrdersByUserId(Integer userId, String status) {
        EntityManager em = JPAUtils_24110280.getEntityManager();
        try {
            String jpql = "SELECT o FROM Order_24110280 o WHERE o.user.userId = :userId";
            if (status != null && !status.isEmpty()) {
                jpql += " AND o.status = :status";
            }
            jpql += " ORDER BY o.orderDate DESC";
            TypedQuery<Order_24110280> query = em.createQuery(jpql, Order_24110280.class);
            query.setParameter("userId", userId);
            if (status != null && !status.isEmpty()) {
                query.setParameter("status", status);
            }
            return query.getResultList();
        } finally {
            em.close();
        }
    }

    public Order_24110280 getOrderById(Integer orderId) {
        EntityManager em = JPAUtils_24110280.getEntityManager();
        try {
            TypedQuery<Order_24110280> query = em.createQuery("SELECT o FROM Order_24110280 o LEFT JOIN FETCH o.orderDetails od LEFT JOIN FETCH od.product WHERE o.orderId = :orderId", Order_24110280.class);
            query.setParameter("orderId", orderId);
            return query.getResultStream().findFirst().orElse(null);
        } finally {
            em.close();
        }
    }

    public void cancelOrder(Integer orderId) {
        EntityManager em = JPAUtils_24110280.getEntityManager();
        EntityTransaction trans = em.getTransaction();
        try {
            trans.begin();
            Order_24110280 order = em.find(Order_24110280.class, orderId);
            if (order != null && "NEW".equals(order.getStatus())) {
                order.setStatus("CANCELLED");
                em.merge(order);
                
                // Restore stock
                TypedQuery<OrderDetail_24110280> query = em.createQuery("SELECT od FROM OrderDetail_24110280 od WHERE od.order.orderId = :orderId", OrderDetail_24110280.class);
                query.setParameter("orderId", orderId);
                List<OrderDetail_24110280> details = query.getResultList();
                for (OrderDetail_24110280 detail : details) {
                    Product_24110280 product = em.find(Product_24110280.class, detail.getProduct().getProductId());
                    product.setStock(product.getStock() + detail.getQuantity());
                    em.merge(product);
                }
            }
            trans.commit();
        } catch (Exception e) {
            trans.rollback();
            throw e;
        } finally {
            em.close();
        }
    }
}
