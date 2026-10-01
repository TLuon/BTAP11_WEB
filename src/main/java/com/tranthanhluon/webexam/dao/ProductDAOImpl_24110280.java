package com.tranthanhluon.webexam.dao;

import com.tranthanhluon.webexam.entity.Product_24110280;
import com.tranthanhluon.webexam.util.JPAUtils_24110280;
import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;
import jakarta.persistence.TypedQuery;

import java.util.List;

public class ProductDAOImpl_24110280 {

    public List<Product_24110280> findAll() {
        EntityManager em = JPAUtils_24110280.getEntityManager();
        try {
            TypedQuery<Product_24110280> query = em.createQuery("SELECT p FROM Product_24110280 p JOIN FETCH p.category JOIN FETCH p.seller ORDER BY p.productId DESC", Product_24110280.class);
            return query.getResultList();
        } finally {
            em.close();
        }
    }

    public List<Product_24110280> findAllGroupedBySeller() {
        EntityManager em = JPAUtils_24110280.getEntityManager();
        try {
            TypedQuery<Product_24110280> query = em.createQuery(
                    "SELECT p FROM Product_24110280 p JOIN FETCH p.seller s JOIN FETCH p.category c ORDER BY s.sellerId ASC, p.productId DESC", 
                    Product_24110280.class
            );
            return query.getResultList();
        } finally {
            em.close();
        }
    }

    public List<Product_24110280> findBySellerId(Integer sellerId) {
        EntityManager em = JPAUtils_24110280.getEntityManager();
        try {
            TypedQuery<Product_24110280> query = em.createQuery(
                    "SELECT p FROM Product_24110280 p JOIN FETCH p.category JOIN FETCH p.seller WHERE p.seller.sellerId = :sellerId ORDER BY p.productId DESC", 
                    Product_24110280.class
            );
            query.setParameter("sellerId", sellerId);
            return query.getResultList();
        } finally {
            em.close();
        }
    }

    public Product_24110280 findById(Integer productId) {
        EntityManager em = JPAUtils_24110280.getEntityManager();
        try {
            TypedQuery<Product_24110280> query = em.createQuery(
                    "SELECT p FROM Product_24110280 p JOIN FETCH p.category JOIN FETCH p.seller WHERE p.productId = :productId", 
                    Product_24110280.class
            );
            query.setParameter("productId", productId);
            return query.getResultStream().findFirst().orElse(null);
        } finally {
            em.close();
        }
    }

    public long count() {
        EntityManager em = JPAUtils_24110280.getEntityManager();
        try {
            TypedQuery<Long> query = em.createQuery("SELECT COUNT(p) FROM Product_24110280 p", Long.class);
            return query.getSingleResult();
        } finally {
            em.close();
        }
    }

    public List<Product_24110280> findWithPage(int page, int pageSize) {
        EntityManager em = JPAUtils_24110280.getEntityManager();
        try {
            TypedQuery<Product_24110280> query = em.createQuery(
                    "SELECT p FROM Product_24110280 p JOIN FETCH p.category JOIN FETCH p.seller ORDER BY p.productId DESC", 
                    Product_24110280.class
            );
            query.setFirstResult((page - 1) * pageSize);
            query.setMaxResults(pageSize);
            return query.getResultList();
        } finally {
            em.close();
        }
    }

    public boolean insert(Product_24110280 product) {
        EntityManager em = JPAUtils_24110280.getEntityManager();
        EntityTransaction trans = em.getTransaction();
        try {
            trans.begin();
            em.persist(product);
            trans.commit();
            return true;
        } catch (Exception e) {
            if (trans.isActive()) trans.rollback();
            e.printStackTrace();
            return false;
        } finally {
            em.close();
        }
    }

    public boolean update(Product_24110280 product) {
        EntityManager em = JPAUtils_24110280.getEntityManager();
        EntityTransaction trans = em.getTransaction();
        try {
            trans.begin();
            em.merge(product);
            trans.commit();
            return true;
        } catch (Exception e) {
            if (trans.isActive()) trans.rollback();
            e.printStackTrace();
            return false;
        } finally {
            em.close();
        }
    }

    public boolean delete(Integer productId) {
        EntityManager em = JPAUtils_24110280.getEntityManager();
        EntityTransaction trans = em.getTransaction();
        try {
            trans.begin();
            Product_24110280 product = em.find(Product_24110280.class, productId);
            if (product != null) {
                em.remove(product);
            }
            trans.commit();
            return true;
        } catch (Exception e) {
            if (trans.isActive()) trans.rollback();
            e.printStackTrace();
            return false;
        } finally {
            em.close();
        }
    }
}
