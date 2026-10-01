package com.tranthanhluon.webexam.entity;

import jakarta.persistence.*;
import java.io.Serializable;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

@Entity(name = "Order_24110280")
@Table(name = "Orders")
public class Order_24110280 implements Serializable {
    private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "orderId")
    private Integer orderId;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "userId", nullable = false)
    private User_24110280 user;

    @Temporal(TemporalType.TIMESTAMP)
    @Column(name = "orderDate", nullable = false)
    private Date orderDate = new Date();

    @Column(name = "status", length = 50, nullable = false)
    private String status = "NEW";

    @Column(name = "fullName", length = 100, nullable = false)
    private String fullName;

    @Column(name = "phone", length = 20, nullable = false)
    private String phone;

    @Column(name = "address", length = 500, nullable = false)
    private String address;

    @Column(name = "note", length = 500)
    private String note;

    @Column(name = "paymentMethod", length = 50, nullable = false)
    private String paymentMethod = "COD";

    @Column(name = "totalAmount", nullable = false)
    private Double totalAmount = 0.0;

    @OneToMany(mappedBy = "order", cascade = CascadeType.ALL, fetch = FetchType.LAZY)
    private List<OrderDetail_24110280> orderDetails = new ArrayList<>();

    public Order_24110280() {}

    public Integer getOrderId() { return orderId; }
    public void setOrderId(Integer orderId) { this.orderId = orderId; }

    public User_24110280 getUser() { return user; }
    public void setUser(User_24110280 user) { this.user = user; }

    public Date getOrderDate() { return orderDate; }
    public void setOrderDate(Date orderDate) { this.orderDate = orderDate; }

    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }

    public String getFullName() { return fullName; }
    public void setFullName(String fullName) { this.fullName = fullName; }

    public String getPhone() { return phone; }
    public void setPhone(String phone) { this.phone = phone; }

    public String getAddress() { return address; }
    public void setAddress(String address) { this.address = address; }

    public String getNote() { return note; }
    public void setNote(String note) { this.note = note; }

    public String getPaymentMethod() { return paymentMethod; }
    public void setPaymentMethod(String paymentMethod) { this.paymentMethod = paymentMethod; }

    public Double getTotalAmount() { return totalAmount; }
    public void setTotalAmount(Double totalAmount) { this.totalAmount = totalAmount; }

    public List<OrderDetail_24110280> getOrderDetails() { return orderDetails; }
    public void setOrderDetails(List<OrderDetail_24110280> orderDetails) { this.orderDetails = orderDetails; }
}
