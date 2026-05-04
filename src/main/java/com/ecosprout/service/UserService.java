package com.ecosprout.service;

import com.ecosprout.dao.UserDAO;
import com.ecosprout.model.UserModel;
import com.ecosprout.util.PasswordUtil;
import java.sql.SQLException;
import java.util.List;

/**
 * UserService - Business logic layer for user operations.
 */
public class UserService {

    private final UserDAO userDAO = new UserDAO();

    /** Validates and registers a new user. Returns null on success, or an error message. */
    public String register(UserModel u) throws SQLException {
        if (!u.getName().matches("[a-zA-Z ]+"))
            return "Full name must contain letters only.";
        if (!u.getEmail().matches("^[\\w.-]+@[\\w.-]+\\.[a-zA-Z]{2,}$"))
            return "Please enter a valid email address.";
        if (u.getPhone() == null || !u.getPhone().matches("\\d{10}"))
            return "Phone number must be exactly 10 digits.";
        if (u.getPassword() == null || u.getPassword().length() < 6)
            return "Password must be at least 6 characters.";
        if (userDAO.emailExists(u.getEmail()))
            return "An account with this email already exists.";
        if (userDAO.phoneExists(u.getPhone()))
            return "An account with this phone number already exists.";
        userDAO.register(u);
        return null;
    }

    /** Authenticates a user by email and plaintext password. */
    public UserModel login(String email, String plainPassword) throws SQLException {
        return userDAO.login(email, PasswordUtil.encrypt(plainPassword));
    }

    public List<UserModel> getAllUsers() throws SQLException { return userDAO.getAllUsers(); }

    public boolean updateStatus(int userId, String status) throws SQLException {
        return userDAO.updateStatus(userId, status);
    }

    public int countPendingUsers() throws SQLException {
        return userDAO.countByRoleAndStatus("vendor", "pending")
             + userDAO.countByRoleAndStatus("buyer", "pending");
    }
}
