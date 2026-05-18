package com.ecosprout.dao;

import java.sql.*;
import java.util.*;
import com.ecosprout.model.ContactModel;
import com.ecosprout.util.DBUtil;

/** DAO for contact-form submissions. Soft-delete aware. */
public class ContactDAO {

    /** Insert a new contact message. */
    public boolean addContact(ContactModel c) throws SQLException {
        String sql = "INSERT INTO contacts(name, email, subject, message) VALUES(?,?,?,?)";
        try (Connection con = DBUtil.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, c.getName());
            ps.setString(2, c.getEmail());
            ps.setString(3, c.getSubject());
            ps.setString(4, c.getMessage());
            return ps.executeUpdate() > 0;
        }
    }

    /** All contact messages, newest first. */
    public List<ContactModel> getAllContacts() throws SQLException {
        List<ContactModel> list = new ArrayList<>();
        try (Connection con = DBUtil.getConnection();
             PreparedStatement ps = con.prepareStatement(
                "SELECT * FROM contacts WHERE is_deleted=0 ORDER BY created_at DESC");
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) list.add(mapRow(rs));
        }
        return list;
    }

    /** Latest N contact messages, newest first. */
    public List<ContactModel> getRecentContacts(int limit) throws SQLException {
        List<ContactModel> list = new ArrayList<>();
        try (Connection con = DBUtil.getConnection();
             PreparedStatement ps = con.prepareStatement(
                "SELECT * FROM contacts WHERE is_deleted=0 "
              + "ORDER BY created_at DESC LIMIT ?")) {
            ps.setInt(1, limit);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) list.add(mapRow(rs));
        }
        return list;
    }

    /** Total number of non-deleted contact messages. */
    public int countContacts() throws SQLException {
        try (Connection con = DBUtil.getConnection();
             PreparedStatement ps = con.prepareStatement(
                "SELECT COUNT(*) FROM contacts WHERE is_deleted=0");
             ResultSet rs = ps.executeQuery()) {
            return rs.next() ? rs.getInt(1) : 0;
        }
    }

    /** Soft-delete a contact message. */
    public boolean deleteContact(int id) throws SQLException {
        try (Connection con = DBUtil.getConnection();
             PreparedStatement ps = con.prepareStatement(
                "UPDATE contacts SET is_deleted=1 WHERE id=?")) {
            ps.setInt(1, id);
            return ps.executeUpdate() > 0;
        }
    }

    private ContactModel mapRow(ResultSet rs) throws SQLException {
        ContactModel c = new ContactModel();
        c.setId(rs.getInt("id"));
        c.setName(rs.getString("name"));
        c.setEmail(rs.getString("email"));
        c.setSubject(rs.getString("subject"));
        c.setMessage(rs.getString("message"));
        c.setCreatedAt(rs.getString("created_at"));
        return c;
    }
}
