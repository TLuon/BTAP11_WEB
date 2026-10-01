package com.tranthanhluon.webexam.entity;

import jakarta.persistence.*;
import java.io.Serializable;
import java.util.Date;

@Entity(name = "Product_24110280")
@Table(name = "Product")
public class Product_24110280 implements Serializable {
    private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "productId")
    private Integer productId;

    @Column(name = "productName", nullable = false, length = 200)
    private String productName;

    @Column(name = "productCode", nullable = false)
    private Long productCode;

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "categoryId", nullable = false)
    private Category_24110280 category;

    @Column(name = "description", columnDefinition = "NVARCHAR(MAX)")
    private String description;

    @Column(name = "price", nullable = false)
    private Double price;

    @Column(name = "amount", nullable = false)
    private Integer amount = 0;

    @Column(name = "stock", nullable = false)
    private Integer stock = 0;

    @Column(name = "images", length = 500)
    private String images;

    @Column(name = "wishlist", nullable = false)
    private Integer wishlist = 0;

    @Column(name = "status", nullable = false)
    private Integer status = 1;

    @Temporal(TemporalType.DATE)
    @Column(name = "createDate")
    private Date createDate = new Date();

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "sellerId", nullable = false)
    private Seller_24110280 seller;

    public Product_24110280() {}

    public Integer getProductId() {
        return productId;
    }

    public void setProductId(Integer productId) {
        this.productId = productId;
    }

    public String getProductName() {
        return productName;
    }

    public void setProductName(String productName) {
        this.productName = productName;
    }

    public Long getProductCode() {
        return productCode;
    }

    public void setProductCode(Long productCode) {
        this.productCode = productCode;
    }

    public Category_24110280 getCategory() {
        return category;
    }

    public void setCategory(Category_24110280 category) {
        this.category = category;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public Double getPrice() {
        return price;
    }

    public void setPrice(Double price) {
        this.price = price;
    }

    public Integer getAmount() {
        return amount;
    }

    public void setAmount(Integer amount) {
        this.amount = amount;
    }

    public Integer getStock() {
        return stock;
    }

    public void setStock(Integer stock) {
        this.stock = stock;
    }

    public String getImages() {
        return images;
    }

    public void setImages(String images) {
        this.images = images;
    }

    public Integer getWishlist() {
        return wishlist;
    }

    public void setWishlist(Integer wishlist) {
        this.wishlist = wishlist;
    }

    public Integer getStatus() {
        return status;
    }

    public void setStatus(Integer status) {
        this.status = status;
    }

    public Date getCreateDate() {
        return createDate;
    }

    public void setCreateDate(Date createDate) {
        this.createDate = createDate;
    }

    public Seller_24110280 getSeller() {
        return seller;
    }

    public void setSeller(Seller_24110280 seller) {
        this.seller = seller;
    }
}
