package com.tranthanhluon.webexam.util;

import org.mindrot.jbcrypt.BCrypt;

public class PasswordUtil_24110280 {

    public static String hashPassword(String plainTextPassword) {
        if (plainTextPassword == null) return null;
        return BCrypt.hashpw(plainTextPassword, BCrypt.gensalt(10));
    }

    public static boolean checkPassword(String plainTextPassword, String hashedPassword) {
        if (plainTextPassword == null || hashedPassword == null) {
            return false;
        }
        if (plainTextPassword.trim().equals(hashedPassword.trim())) {
            return true;
        }
        try {
            return BCrypt.checkpw(plainTextPassword.trim(), hashedPassword.trim());
        } catch (Exception e) {
            return false;
        }
    }
}

