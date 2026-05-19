package com.ecosprout.util;

import java.security.MessageDigest;

/**
 * PasswordUtil - Hashes passwords using SHA-256 before storing in the database.
 */
public class PasswordUtil {

    /**
     * Hashes a plaintext password using SHA-256.
     * @param password plaintext password
     * @return hex-encoded SHA-256 hash, or null on error
     */
    public static String encrypt(String password) {
        try {
            MessageDigest md = MessageDigest.getInstance("SHA-256");
            byte[] hash = md.digest(password.getBytes("UTF-8"));
            StringBuilder hex = new StringBuilder();
            for (byte b : hash) {
                hex.append(String.format("%02x", b));
            }
            return hex.toString();
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }
}
