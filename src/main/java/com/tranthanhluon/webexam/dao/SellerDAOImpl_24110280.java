package com.tranthanhluon.webexam.dao;

import com.tranthanhluon.webexam.entity.Seller_24110280;
import com.tranthanhluon.webexam.util.JPAUtils_24110280;
import jakarta.persistence.EntityManager;
import jakarta.persistence.TypedQuery;

import java.util.List;

public class SellerDAOImpl_24110280 {

    public Seller_24110280 findById(Integer sellerId) {
        EntityManager em = JPAUtils_24110280.getEntityManager();
        try {
            return em.find(Seller_24110280.class, sellerId);
        } finally {
            em.close();
        }
    }

    public List<Seller_24110280> findAll() {
        EntityManager em = JPAUtils_24110280.getEntityManager();
        try {
            TypedQuery<Seller_24110280> query = em.createQuery("SELECT s FROM Seller_24110280 s ORDER BY s.sellerId ASC", Seller_24110280.class);
            return query.getResultList();
        } finally {
            em.close();
        }
    }
}
