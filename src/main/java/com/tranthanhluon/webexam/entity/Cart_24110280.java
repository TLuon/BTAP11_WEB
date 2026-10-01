package com.tranthanhluon.webexam.entity;

import jakarta.persistence.*;
import java.io.Serializable;
import java.util.Date;

@Entity(name = "Cart_24110280")
@Table(name = "Cart")
public class Cart_24110280 implements Serializable {
    private static final long serialVersionUID = 1L;

    @Id
    @Column(name = "cartId", length = 50)
    private String cartId;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "userId", nullable = false)
    private User_24110280 user;

    @Temporal(TemporalType.TIMESTAMP)
    @Column(name = "buyDate")
    private Date buyDate = new Date();

    @Column(name = "status", nullable = false)
    private Integer status = 1;

    public Cart_24110280() {}

    public String getCartId() {
        return cartId;
    }

    public void setCartId(String cartId) {
        this.cartId = cartId;
    }

    public User_24110280 getUser() {
        return user;
    }

    public void setUser(User_24110280 user) {
        this.user = user;
    }

    public Date getBuyDate() {
        return buyDate;
    }

    public void setBuyDate(Date buyDate) {
        this.buyDate = buyDate;
    }

    public Integer getStatus() {
        return status;
    }

    public void setStatus(Integer status) {
        this.status = status;
    }
}
