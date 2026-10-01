package com.tranthanhluon.webexam.entity;

import jakarta.persistence.*;
import java.io.Serializable;

@Entity(name = "OrderDetail_24110280")
@Table(name = "OrderDetails")
public class OrderDetail_24110280 implements Serializable {
    private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "orderDetailId")
    private Integer orderDetailId;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "orderId", nullable = false)
    private Order_24110280 order;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "productId", nullable = false)
    private Product_24110280 product;

    @Column(name = "quantity", nullable = false)
    private Integer quantity = 1;

    @Column(name = "unitPrice", nullable = false)
    private Double unitPrice = 0.0;

    public OrderDetail_24110280() {}

    public Integer getOrderDetailId() { return orderDetailId; }
    public void setOrderDetailId(Integer orderDetailId) { this.orderDetailId = orderDetailId; }

    public Order_24110280 getOrder() { return order; }
    public void setOrder(Order_24110280 order) { this.order = order; }

    public Product_24110280 getProduct() { return product; }
    public void setProduct(Product_24110280 product) { this.product = product; }

    public Integer getQuantity() { return quantity; }
    public void setQuantity(Integer quantity) { this.quantity = quantity; }

    public Double getUnitPrice() { return unitPrice; }
    public void setUnitPrice(Double unitPrice) { this.unitPrice = unitPrice; }
}
