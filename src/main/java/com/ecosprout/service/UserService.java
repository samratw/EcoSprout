package com.ecosprout.service;

import com.ecosprout.dao.UserDAO;
import com.ecosprout.model.UserModel;
import com.ecosprout.util.PasswordUtil;
import java.sql.SQLException;
import java.util.List;
import java.util.Map;

/** Business logic for user operations. */
public class UserService {

    private final UserDAO userDAO = new UserDAO();

    /** Register a user. Returns null on success or an error message. */
    public String register(UserModel u) throws SQLException {
        if (u.getName() == null || !u.getName().matches("[a-zA-Z ]+"))
            return "Full name must contain letters only.";
        if (u.getEmail() == null || !u.getEmail().matches("^[\\w.-]+@[\\w.-]+\\.[a-zA-Z]{2,}$"))
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

    /** Authenticate by email + plaintext password. */
    public UserModel login(String email, String plainPassword) throws SQLException {
        return userDAO.login(email, PasswordUtil.encrypt(plainPassword));
    }

    /** Update user profile (name + phone). Returns null on success or an error. */
    public String updateProfile(int userId, String name, String phone) throws SQLException {
        if (name == null || !name.matches("[a-zA-Z ]+"))
            return "Full name must contain letters only.";
        if (phone == null || !phone.matches("\\d{10}"))
            return "Phone number must be exactly 10 digits.";
        if (userDAO.phoneTakenByOther(userId, phone))
            return "That phone number is already used by another account.";
        userDAO.updateProfile(userId, name.trim(), phone.trim());
        return null;
    }

    /** Change a user's password. Returns null on success or an error. */
    public String changePassword(int userId, String currentPlain, String newPlain, String confirmPlain)
            throws SQLException {
        if (currentPlain == null || currentPlain.isEmpty())
            return "Please enter your current password.";
        if (newPlain == null || newPlain.length() < 6)
            return "New password must be at least 6 characters.";
        if (!newPlain.equals(confirmPlain))
            return "New password and confirmation do not match.";
        if (!userDAO.verifyPassword(userId, PasswordUtil.encrypt(currentPlain)))
            return "Current password is incorrect.";
        userDAO.updatePassword(userId, PasswordUtil.encrypt(newPlain));
        return null;
    }

    public UserModel getById(int id) throws SQLException { return userDAO.getById(id); }

    public List<UserModel> getAllUsers() throws SQLException { return userDAO.getAllUsers(); }

    public boolean updateStatus(int userId, String status) throws SQLException {
        return userDAO.updateStatus(userId, status);
    }

    public int countPendingUsers() throws SQLException {
        return userDAO.countByRoleAndStatus("vendor", "pending")
             + userDAO.countByRoleAndStatus("buyer", "pending");
    }

    public Map<String, Integer> countByRole() throws SQLException { return userDAO.countByRole(); }
}
