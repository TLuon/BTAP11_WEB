package com.tranthanhluon.webexam.entity;

import jakarta.persistence.*;
import java.io.Serializable;

@Entity(name = "Seller_24110280")
@Table(name = "Seller")
public class Seller_24110280 implements Serializable {
    private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "sellerId")
    private Integer sellerId;

    @Column(name = "sellername", nullable = false, length = 100)
    private String sellername;

    @Column(name = "images", length = 500)
    private String images;

    @Column(name = "status", nullable = false)
    private Integer status = 1;

    public Seller_24110280() {}

    public Seller_24110280(Integer sellerId, String sellername, String images, Integer status) {
        this.sellerId = sellerId;
        this.sellername = sellername;
        this.images = images;
        this.status = status;
    }

    public Integer getSellerId() {
        return sellerId;
    }

    public void setSellerId(Integer sellerId) {
        this.sellerId = sellerId;
    }

    public String getSellername() {
        return sellername;
    }

    public void setSellername(String sellername) {
        this.sellername = sellername;
    }

    public String getImages() {
        return images;
    }

    public void setImages(String images) {
        this.images = images;
    }

    public Integer getStatus() {
        return status;
    }

    public void setStatus(Integer status) {
        this.status = status;
    }
}
