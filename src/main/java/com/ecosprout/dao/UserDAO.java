package com.ecosprout.dao;

import java.sql.*;
import com.ecosprout.model.*;
import com.ecosprout.util.*;

public class UserDAO {

    public boolean register(UserModel u) {
        try {
            Connection con = DBUtil.getConnection();

            PreparedStatement ps = con.prepareStatement(
                "INSERT INTO users(name,email,password,role) VALUES(?,?,?,?)"
            );

            ps.setString(1, u.getName());
            ps.setString(2, u.getEmail());
            ps.setString(3, PasswordUtil.encrypt(u.getPassword()));
            ps.setString(4, u.getRole());

            return ps.executeUpdate() > 0;

        } catch(Exception e) { e.printStackTrace(); }
        return false;
    }

    public UserModel login(String email, String password) {
        try {
            Connection con = DBUtil.getConnection();

            PreparedStatement ps = con.prepareStatement(
                "SELECT * FROM users WHERE email=? AND password=?"
            );

            ps.setString(1, email);
            ps.setString(2, password);

            ResultSet rs = ps.executeQuery();

            if(rs.next()) {
                UserModel u = new UserModel();
                u.setId(rs.getInt("id"));
                u.setName(rs.getString("name"));
                u.setRole(rs.getString("role"));
                return u;
            }

        } catch(Exception e) { e.printStackTrace(); }
        return null;
    }
}