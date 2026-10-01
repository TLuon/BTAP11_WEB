package com.tranthanhluon.webexam.service;

import com.tranthanhluon.webexam.dao.SellerDAOImpl_24110280;
import com.tranthanhluon.webexam.entity.Seller_24110280;

import java.util.List;

public class SellerServiceImpl_24110280 {
    private final SellerDAOImpl_24110280 sellerDAO = new SellerDAOImpl_24110280();

    public List<Seller_24110280> getAllSellers() {
        return sellerDAO.findAll();
    }

    public Seller_24110280 getSellerById(Integer sellerId) {
        return sellerDAO.findById(sellerId);
    }
}
