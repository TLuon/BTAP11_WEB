package com.tranthanhluon.webexam.dao;

import com.tranthanhluon.webexam.entity.CartItem_24110280;
import com.tranthanhluon.webexam.entity.Cart_24110280;
import com.tranthanhluon.webexam.entity.Product_24110280;
import com.tranthanhluon.webexam.entity.User_24110280;
import com.tranthanhluon.webexam.util.JPAUtils_24110280;
import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;
import jakarta.persistence.TypedQuery;

import java.util.List;
import java.util.UUID;

public class CartDAOImpl_24110280 {

    public Cart_24110280 getCartByUserId(Integer userId) {
        EntityManager em = JPAUtils_24110280.getEntityManager();
        try {
            TypedQuery<Cart_24110280> query = em.createQuery("SELECT c FROM Cart_24110280 c WHERE c.user.userId = :userId", Cart_24110280.class);
            query.setParameter("userId", userId);
            return query.getResultStream().findFirst().orElse(null);
        } finally {
            em.close();
        }
    }

    public void createCart(Cart_24110280 cart) {
        EntityManager em = JPAUtils_24110280.getEntityManager();
        EntityTransaction trans = em.getTransaction();
        try {
            trans.begin();
            em.persist(cart);
            trans.commit();
        } catch (Exception e) {
            trans.rollback();
            throw e;
        } finally {
            em.close();
        }
    }

    public Cart_24110280 getOrCreateCart(Integer userId) {
        Cart_24110280 cart = getCartByUserId(userId);
        if (cart == null) {
            cart = new Cart_24110280();
            cart.setCartId(UUID.randomUUID().toString());
            User_24110280 user = new User_24110280();
            user.setUserId(userId);
            cart.setUser(user);
            createCart(cart);
        }
        return cart;
    }

    public List<CartItem_24110280> getCartItems(String cartId) {
        EntityManager em = JPAUtils_24110280.getEntityManager();
        try {
            TypedQuery<CartItem_24110280> query = em.createQuery("SELECT ci FROM CartItem_24110280 ci JOIN FETCH ci.product WHERE ci.cart.cartId = :cartId", CartItem_24110280.class);
            query.setParameter("cartId", cartId);
            return query.getResultList();
        } finally {
            em.close();
        }
    }

    public void addOrUpdateCartItem(String cartId, Integer productId, Integer quantity) {
        EntityManager em = JPAUtils_24110280.getEntityManager();
        EntityTransaction trans = em.getTransaction();
        try {
            trans.begin();
            TypedQuery<CartItem_24110280> query = em.createQuery("SELECT ci FROM CartItem_24110280 ci WHERE ci.cart.cartId = :cartId AND ci.product.productId = :productId", CartItem_24110280.class);
            query.setParameter("cartId", cartId);
            query.setParameter("productId", productId);
            CartItem_24110280 item = query.getResultStream().findFirst().orElse(null);
            
            Product_24110280 product = em.find(Product_24110280.class, productId);
            if (product == null) throw new IllegalArgumentException("Product not found");

            if (item != null) {
                item.setQuantity(item.getQuantity() + quantity);
                if (item.getQuantity() > product.getStock()) {
                    item.setQuantity(product.getStock());
                }
                em.merge(item);
            } else {
                item = new CartItem_24110280();
                item.setCartItemId(UUID.randomUUID().toString());
                Cart_24110280 cartRef = em.getReference(Cart_24110280.class, cartId);
                item.setCart(cartRef);
                item.setProduct(product);
                item.setQuantity(quantity > product.getStock() ? product.getStock() : quantity);
                item.setUnitPrice(product.getPrice());
                em.persist(item);
            }
            trans.commit();
        } catch (Exception e) {
            trans.rollback();
            throw e;
        } finally {
            em.close();
        }
    }

    public void updateCartItemQuantity(String cartItemId, Integer newQuantity) {
        EntityManager em = JPAUtils_24110280.getEntityManager();
        EntityTransaction trans = em.getTransaction();
        try {
            trans.begin();
            CartItem_24110280 item = em.find(CartItem_24110280.class, cartItemId);
            if (item != null) {
                Product_24110280 product = item.getProduct();
                if (newQuantity > product.getStock()) {
                    item.setQuantity(product.getStock());
                } else if (newQuantity < 1) {
                    item.setQuantity(1);
                } else {
                    item.setQuantity(newQuantity);
                }
                em.merge(item);
            }
            trans.commit();
        } catch (Exception e) {
            trans.rollback();
            throw e;
        } finally {
            em.close();
        }
    }

    public void removeCartItem(String cartItemId) {
        EntityManager em = JPAUtils_24110280.getEntityManager();
        EntityTransaction trans = em.getTransaction();
        try {
            trans.begin();
            CartItem_24110280 item = em.find(CartItem_24110280.class, cartItemId);
            if (item != null) {
                em.remove(item);
            }
            trans.commit();
        } catch (Exception e) {
            trans.rollback();
            throw e;
        } finally {
            em.close();
        }
    }

    public void clearCart(String cartId) {
        EntityManager em = JPAUtils_24110280.getEntityManager();
        EntityTransaction trans = em.getTransaction();
        try {
            trans.begin();
            em.createQuery("DELETE FROM CartItem_24110280 ci WHERE ci.cart.cartId = :cartId")
              .setParameter("cartId", cartId)
              .executeUpdate();
            trans.commit();
        } catch (Exception e) {
            trans.rollback();
            throw e;
        } finally {
            em.close();
        }
    }
}
