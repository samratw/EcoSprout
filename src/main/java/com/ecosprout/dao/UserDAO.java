package com.ecosprout.dao;

import java.sql.*;
import java.util.*;
import com.ecosprout.model.UserModel;
import com.ecosprout.util.DBUtil;
import com.ecosprout.util.PasswordUtil;

/** DAO for user-related database operations. */
public class UserDAO {

    /** Register a new user (password is hashed first). */
    public boolean register(UserModel u) throws SQLException {
        String sql = "INSERT INTO users(name, email, password, phone, role, status) "
                   + "VALUES(?,?,?,?,?,?)";
        try (Connection con = DBUtil.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, u.getName());
            ps.setString(2, u.getEmail());
            ps.setString(3, PasswordUtil.encrypt(u.getPassword()));
            ps.setString(4, u.getPhone());
            ps.setString(5, u.getRole());
            ps.setString(6, "admin".equals(u.getRole()) ? "approved" : "pending");
            return ps.executeUpdate() > 0;
        }
    }

    /** True if any account has this email. */
    public boolean emailExists(String email) throws SQLException {
        try (Connection con = DBUtil.getConnection();
             PreparedStatement ps = con.prepareStatement("SELECT id FROM users WHERE email = ?")) {
            ps.setString(1, email);
            return ps.executeQuery().next();
        }
    }

    /** True if any account has this phone. */
    public boolean phoneExists(String phone) throws SQLException {
        try (Connection con = DBUtil.getConnection();
             PreparedStatement ps = con.prepareStatement("SELECT id FROM users WHERE phone = ?")) {
            ps.setString(1, phone);
            return ps.executeQuery().next();
        }
    }

    /** True if another (different id) account already uses this phone. */
    public boolean phoneTakenByOther(int userId, String phone) throws SQLException {
        try (Connection con = DBUtil.getConnection();
             PreparedStatement ps = con.prepareStatement(
                "SELECT id FROM users WHERE phone = ? AND id <> ?")) {
            ps.setString(1, phone);
            ps.setInt(2, userId);
            return ps.executeQuery().next();
        }
    }

    /** Authenticate by email + already-hashed password. Only approved users. */
    public UserModel login(String email, String hashedPassword) throws SQLException {
        String sql = "SELECT * FROM users WHERE email=? AND password=? AND status='approved'";
        try (Connection con = DBUtil.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, email);
            ps.setString(2, hashedPassword);
            ResultSet rs = ps.executeQuery();
            return rs.next() ? mapRow(rs) : null;
        }
    }

    /** Fetch a user by id. */
    public UserModel getById(int id) throws SQLException {
        try (Connection con = DBUtil.getConnection();
             PreparedStatement ps = con.prepareStatement("SELECT * FROM users WHERE id=?")) {
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            return rs.next() ? mapRow(rs) : null;
        }
    }

    /** Verify a user's current password matches the supplied hash. */
    public boolean verifyPassword(int userId, String hashedPassword) throws SQLException {
        try (Connection con = DBUtil.getConnection();
             PreparedStatement ps = con.prepareStatement(
                "SELECT id FROM users WHERE id=? AND password=?")) {
            ps.setInt(1, userId);
            ps.setString(2, hashedPassword);
            return ps.executeQuery().next();
        }
    }

    /** Update name and phone for a user. */
    public boolean updateProfile(int userId, String name, String phone) throws SQLException {
        try (Connection con = DBUtil.getConnection();
             PreparedStatement ps = con.prepareStatement(
                "UPDATE users SET name=?, phone=? WHERE id=?")) {
            ps.setString(1, name);
            ps.setString(2, phone);
            ps.setInt(3, userId);
            return ps.executeUpdate() > 0;
        }
    }

    /** Update password (caller must pass an already-hashed value). */
    public boolean updatePassword(int userId, String hashedPassword) throws SQLException {
        try (Connection con = DBUtil.getConnection();
             PreparedStatement ps = con.prepareStatement(
                "UPDATE users SET password=? WHERE id=?")) {
            ps.setString(1, hashedPassword);
            ps.setInt(2, userId);
            return ps.executeUpdate() > 0;
        }
    }

    /** All users (for admin panel). */
    public List<UserModel> getAllUsers() throws SQLException {
        List<UserModel> list = new ArrayList<>();
        try (Connection con = DBUtil.getConnection();
             PreparedStatement ps = con.prepareStatement(
                "SELECT * FROM users ORDER BY created_at DESC");
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) list.add(mapRow(rs));
        }
        return list;
    }

    /** Update approval status (approved / rejected). */
    public boolean updateStatus(int userId, String status) throws SQLException {
        try (Connection con = DBUtil.getConnection();
             PreparedStatement ps = con.prepareStatement(
                "UPDATE users SET status=? WHERE id=?")) {
            ps.setString(1, status);
            ps.setInt(2, userId);
            return ps.executeUpdate() > 0;
        }
    }

    /** Count users by role and status. */
    public int countByRoleAndStatus(String role, String status) throws SQLException {
        try (Connection con = DBUtil.getConnection();
             PreparedStatement ps = con.prepareStatement(
                "SELECT COUNT(*) FROM users WHERE role=? AND status=?")) {
            ps.setString(1, role);
            ps.setString(2, status);
            ResultSet rs = ps.executeQuery();
            return rs.next() ? rs.getInt(1) : 0;
        }
    }

    /** Count users grouped by role (returns role -> count). */
    public Map<String, Integer> countByRole() throws SQLException {
        Map<String, Integer> map = new LinkedHashMap<>();
        try (Connection con = DBUtil.getConnection();
             PreparedStatement ps = con.prepareStatement(
                "SELECT role, COUNT(*) AS c FROM users GROUP BY role");
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) map.put(rs.getString("role"), rs.getInt("c"));
        }
        return map;
    }

    /** Build a UserModel from a ResultSet row. */
    private UserModel mapRow(ResultSet rs) throws SQLException {
        UserModel u = new UserModel();
        u.setId(rs.getInt("id"));
        u.setName(rs.getString("name"));
        u.setEmail(rs.getString("email"));
        u.setPhone(rs.getString("phone"));
        u.setRole(rs.getString("role"));
        u.setStatus(rs.getString("status"));
        return u;
    }
}
