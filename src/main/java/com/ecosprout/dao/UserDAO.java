package com.ecosprout.dao;

import java.sql.*;
import java.util.*;
import com.ecosprout.model.UserModel;
import com.ecosprout.util.DBUtil;
import com.ecosprout.util.PasswordUtil;

/**
 * UserDAO - Data Access Object for user-related database operations.
 */
public class UserDAO {

    /**
     * Registers a new user. Password is encrypted before storage.
     * @return true if registration succeeded, false otherwise
     */
    public boolean register(UserModel u) throws SQLException {
        String sql = "INSERT INTO users(name, email, password, phone, role, status) VALUES(?,?,?,?,?,?)";
        try (Connection con = DBUtil.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, u.getName());
            ps.setString(2, u.getEmail());
            ps.setString(3, PasswordUtil.encrypt(u.getPassword()));
            ps.setString(4, u.getPhone());
            ps.setString(5, u.getRole());
            // Admin accounts are auto-approved; others require approval
            ps.setString(6, "admin".equals(u.getRole()) ? "approved" : "pending");

            return ps.executeUpdate() > 0;
        }
    }

    /**
     * Checks whether an email address is already registered.
     */
    public boolean emailExists(String email) throws SQLException {
        String sql = "SELECT id FROM users WHERE email = ?";
        try (Connection con = DBUtil.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, email);
            ResultSet rs = ps.executeQuery();
            return rs.next();
        }
    }

    /**
     * Checks whether a phone number is already registered.
     */
    public boolean phoneExists(String phone) throws SQLException {
        String sql = "SELECT id FROM users WHERE phone = ?";
        try (Connection con = DBUtil.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, phone);
            ResultSet rs = ps.executeQuery();
            return rs.next();
        }
    }

    /**
     * Authenticates a user by email and hashed password.
     * Only approved accounts can log in.
     */
    public UserModel login(String email, String hashedPassword) throws SQLException {
        String sql = "SELECT * FROM users WHERE email=? AND password=? AND status='approved'";
        try (Connection con = DBUtil.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, email);
            ps.setString(2, hashedPassword);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                UserModel u = new UserModel();
                u.setId(rs.getInt("id"));
                u.setName(rs.getString("name"));
                u.setEmail(rs.getString("email"));
                u.setRole(rs.getString("role"));
                u.setPhone(rs.getString("phone"));
                u.setStatus(rs.getString("status"));
                return u;
            }
        }
        return null;
    }

    /**
     * Returns all users (for admin management panel).
     */
    public List<UserModel> getAllUsers() throws SQLException {
        List<UserModel> list = new ArrayList<>();
        String sql = "SELECT * FROM users ORDER BY created_at DESC";
        try (Connection con = DBUtil.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                UserModel u = new UserModel();
                u.setId(rs.getInt("id"));
                u.setName(rs.getString("name"));
                u.setEmail(rs.getString("email"));
                u.setRole(rs.getString("role"));
                u.setPhone(rs.getString("phone"));
                u.setStatus(rs.getString("status"));
                list.add(u);
            }
        }
        return list;
    }

    /**
     * Updates the approval status of a user (approved / rejected).
     */
    public boolean updateStatus(int userId, String status) throws SQLException {
        String sql = "UPDATE users SET status=? WHERE id=?";
        try (Connection con = DBUtil.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, status);
            ps.setInt(2, userId);
            return ps.executeUpdate() > 0;
        }
    }

    /**
     * Returns the number of users with the given role and status.
     * Used for admin dashboard statistics.
     */
    public int countByRoleAndStatus(String role, String status) throws SQLException {
        String sql = "SELECT COUNT(*) FROM users WHERE role=? AND status=?";
        try (Connection con = DBUtil.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, role);
            ps.setString(2, status);
            ResultSet rs = ps.executeQuery();
            return rs.next() ? rs.getInt(1) : 0;
        }
    }
}
