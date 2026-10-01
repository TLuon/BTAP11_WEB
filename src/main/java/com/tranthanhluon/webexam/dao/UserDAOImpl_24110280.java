package com.tranthanhluon.webexam.dao;

import com.tranthanhluon.webexam.entity.User_24110280;
import com.tranthanhluon.webexam.util.JPAUtils_24110280;
import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;
import jakarta.persistence.TypedQuery;

public class UserDAOImpl_24110280 {

    public User_24110280 findByUsername(String username) {
        EntityManager em = JPAUtils_24110280.getEntityManager();
        try {
            TypedQuery<User_24110280> query = em.createQuery("SELECT u FROM User_24110280 u WHERE u.username = :username", User_24110280.class);
            query.setParameter("username", username);
            return query.getResultStream().findFirst().orElse(null);
        } finally {
            em.close();
        }
    }

    public User_24110280 findByEmail(String email) {
        EntityManager em = JPAUtils_24110280.getEntityManager();
        try {
            TypedQuery<User_24110280> query = em.createQuery("SELECT u FROM User_24110280 u WHERE u.email = :email", User_24110280.class);
            query.setParameter("email", email);
            return query.getResultStream().findFirst().orElse(null);
        } finally {
            em.close();
        }
    }

    public User_24110280 findById(Integer userId) {
        EntityManager em = JPAUtils_24110280.getEntityManager();
        try {
            return em.find(User_24110280.class, userId);
        } finally {
            em.close();
        }
    }

    public boolean insert(User_24110280 user) {
        EntityManager em = JPAUtils_24110280.getEntityManager();
        EntityTransaction trans = em.getTransaction();
        try {
            trans.begin();
            em.persist(user);
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

    public boolean update(User_24110280 user) {
        EntityManager em = JPAUtils_24110280.getEntityManager();
        EntityTransaction trans = em.getTransaction();
        try {
            trans.begin();
            em.merge(user);
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
