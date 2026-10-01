package com.tranthanhluon.webexam.entity;

import jakarta.persistence.*;
import java.io.Serializable;

@Entity(name = "CartItem_24110280")
@Table(name = "CartItem")
public class CartItem_24110280 implements Serializable {
    private static final long serialVersionUID = 1L;

    @Id
    @Column(name = "cartItemId", length = 50)
    private String cartItemId;

    @Column(name = "quantity", nullable = false)
    private Integer quantity = 1;

    @Column(name = "unitPrice", nullable = false)
    private Double unitPrice = 0.0;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "productId", nullable = false)
    private Product_24110280 product;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "cartId", nullable = false)
    private Cart_24110280 cart;

    public CartItem_24110280() {}

    public String getCartItemId() {
        return cartItemId;
    }

    public void setCartItemId(String cartItemId) {
        this.cartItemId = cartItemId;
    }

    public Integer getQuantity() {
        return quantity;
    }

    public void setQuantity(Integer quantity) {
        this.quantity = quantity;
    }

    public Double getUnitPrice() {
        return unitPrice;
    }

    public void setUnitPrice(Double unitPrice) {
        this.unitPrice = unitPrice;
    }

    public Product_24110280 getProduct() {
        return product;
    }

    public void setProduct(Product_24110280 product) {
        this.product = product;
    }

    public Cart_24110280 getCart() {
        return cart;
    }

    public void setCart(Cart_24110280 cart) {
        this.cart = cart;
    }
}
