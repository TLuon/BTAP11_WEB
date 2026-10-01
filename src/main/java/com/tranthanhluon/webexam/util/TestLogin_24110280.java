package com.tranthanhluon.webexam.util;

import com.tranthanhluon.webexam.dao.UserDAOImpl_24110280;
import com.tranthanhluon.webexam.entity.User_24110280;
import com.tranthanhluon.webexam.service.UserServiceImpl_24110280;

public class TestLogin_24110280 {
    public static void main(String[] args) {
        try {
            System.out.println("--- TESTING DATABASE CONNECTION AND USER LOGIN ---");
            UserDAOImpl_24110280 dao = new UserDAOImpl_24110280();
            User_24110280 user = dao.findByUsername("admin");
            
            if (user == null) {
                System.out.println("RESULT: USER 'admin' NOT FOUND IN DATABASE!");
            } else {
                System.out.println("USER FOUND: ID=" + user.getUserId() + ", username=" + user.getUsername() + ", status=" + user.getStatus() + ", pass=" + user.getPassword());
                
                UserServiceImpl_24110280 service = new UserServiceImpl_24110280();
                User_24110280 loginUser = service.login("admin", "123456");
                if (loginUser != null) {
                    System.out.println("RESULT: LOGIN SUCCESS FOR admin / 123456!");
                } else {
                    System.out.println("RESULT: LOGIN FAILED IN SERVICE!");
                }
            }
        } catch (Exception e) {
            System.err.println("EXCEPTION IN TEST LOGIN:");
            e.printStackTrace();
        }
    }
}
