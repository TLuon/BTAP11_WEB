package com.tranthanhluon.webexam.dao;

import com.tranthanhluon.webexam.entity.UserRole_24110280;
import com.tranthanhluon.webexam.util.JPAUtils_24110280;
import jakarta.persistence.EntityManager;
import jakarta.persistence.TypedQuery;

public class UserRoleDAOImpl_24110280 {

    public UserRole_24110280 findById(Integer roleId) {
        EntityManager em = JPAUtils_24110280.getEntityManager();
        try {
            return em.find(UserRole_24110280.class, roleId);
        } finally {
            em.close();
        }
    }

    public UserRole_24110280 findByName(String roleName) {
        EntityManager em = JPAUtils_24110280.getEntityManager();
        try {
            TypedQuery<UserRole_24110280> query = em.createQuery("SELECT r FROM UserRole_24110280 r WHERE r.roleName = :roleName", UserRole_24110280.class);
            query.setParameter("roleName", roleName);
            return query.getResultStream().findFirst().orElse(null);
        } finally {
            em.close();
        }
    }
}
