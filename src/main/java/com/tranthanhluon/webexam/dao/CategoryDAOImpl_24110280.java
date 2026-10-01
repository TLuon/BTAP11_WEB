package com.tranthanhluon.webexam.dao;

import com.tranthanhluon.webexam.entity.Category_24110280;
import com.tranthanhluon.webexam.util.JPAUtils_24110280;
import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;
import jakarta.persistence.TypedQuery;

import java.util.List;

public class CategoryDAOImpl_24110280 {

    public List<Category_24110280> findAll() {
        EntityManager em = JPAUtils_24110280.getEntityManager();
        try {
            TypedQuery<Category_24110280> query = em.createQuery("SELECT c FROM Category_24110280 c ORDER BY c.categoryId DESC", Category_24110280.class);
            return query.getResultList();
        } finally {
            em.close();
        }
    }

    public Category_24110280 findById(Integer categoryId) {
        EntityManager em = JPAUtils_24110280.getEntityManager();
        try {
            return em.find(Category_24110280.class, categoryId);
        } finally {
            em.close();
        }
    }

    public long count() {
        EntityManager em = JPAUtils_24110280.getEntityManager();
        try {
            TypedQuery<Long> query = em.createQuery("SELECT COUNT(c) FROM Category_24110280 c", Long.class);
            return query.getSingleResult();
        } finally {
            em.close();
        }
    }

    public List<Category_24110280> findWithPage(int page, int pageSize) {
        EntityManager em = JPAUtils_24110280.getEntityManager();
        try {
            TypedQuery<Category_24110280> query = em.createQuery("SELECT c FROM Category_24110280 c ORDER BY c.categoryId DESC", Category_24110280.class);
            query.setFirstResult((page - 1) * pageSize);
            query.setMaxResults(pageSize);
            return query.getResultList();
        } finally {
            em.close();
        }
    }

    public boolean insert(Category_24110280 category) {
        EntityManager em = JPAUtils_24110280.getEntityManager();
        EntityTransaction trans = em.getTransaction();
        try {
            trans.begin();
            em.persist(category);
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

    public boolean update(Category_24110280 category) {
        EntityManager em = JPAUtils_24110280.getEntityManager();
        EntityTransaction trans = em.getTransaction();
        try {
            trans.begin();
            em.merge(category);
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

    public boolean delete(Integer categoryId) {
        EntityManager em = JPAUtils_24110280.getEntityManager();
        EntityTransaction trans = em.getTransaction();
        try {
            trans.begin();
            Category_24110280 category = em.find(Category_24110280.class, categoryId);
            if (category != null) {
                em.remove(category);
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
