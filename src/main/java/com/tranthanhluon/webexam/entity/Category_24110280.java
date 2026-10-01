package com.tranthanhluon.webexam.entity;

import jakarta.persistence.*;
import java.io.Serializable;

@Entity(name = "Category_24110280")
@Table(name = "Category")
public class Category_24110280 implements Serializable {
    private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "categoryId")
    private Integer categoryId;

    @Column(name = "categoryName", nullable = false, length = 100)
    private String categoryName;

    @Column(name = "images", length = 500)
    private String images;

    @Column(name = "status", nullable = false)
    private Integer status = 1;

    public Category_24110280() {}

    public Category_24110280(Integer categoryId, String categoryName, String images, Integer status) {
        this.categoryId = categoryId;
        this.categoryName = categoryName;
        this.images = images;
        this.status = status;
    }

    public Integer getCategoryId() {
        return categoryId;
    }

    public void setCategoryId(Integer categoryId) {
        this.categoryId = categoryId;
    }

    public String getCategoryName() {
        return categoryName;
    }

    public void setCategoryName(String categoryName) {
        this.categoryName = categoryName;
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
