package com.tranthanhluon.webexam.service;

import com.tranthanhluon.webexam.dao.ProductDAOImpl_24110280;
import com.tranthanhluon.webexam.entity.Product_24110280;

import java.util.List;

public class ProductServiceImpl_24110280 {
    private final ProductDAOImpl_24110280 productDAO = new ProductDAOImpl_24110280();

    public List<Product_24110280> getAllProducts() {
        return productDAO.findAll();
    }

    public List<Product_24110280> getProductsGroupedBySeller() {
        return productDAO.findAllGroupedBySeller();
    }

    public List<Product_24110280> getProductsBySellerId(Integer sellerId) {
        return productDAO.findBySellerId(sellerId);
    }

    public Product_24110280 getProductById(Integer productId) {
        return productDAO.findById(productId);
    }

    public List<Product_24110280> getProductsWithPage(int page, int pageSize) {
        return productDAO.findWithPage(page, pageSize);
    }

    public int getTotalPages(int pageSize) {
        long totalCount = productDAO.count();
        return (int) Math.ceil((double) totalCount / pageSize);
    }

    public long getTotalCount() {
        return productDAO.count();
    }

    public boolean saveProduct(Product_24110280 product) {
        if (product.getProductId() == null || product.getProductId() == 0) {
            return productDAO.insert(product);
        } else {
            return productDAO.update(product);
        }
    }

    public boolean deleteProduct(Integer productId) {
        return productDAO.delete(productId);
    }
}
