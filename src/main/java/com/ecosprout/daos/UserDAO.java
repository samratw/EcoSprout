package com.ecosprout.daos;

import java.sql.*;
import com.ecosprout.models.UserModel;
import com.ecosprout.utils.DBCon;

public class UserDAO {

    public boolean register(UserModel user) {
        try {
            Connection con = DBCon.getConnection();
            String sql = "INSERT INTO users(name,email,password) VALUES(?,?,?)";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, user.getName());
            ps.setString(2, user.getEmail());
            ps.setString(3, user.getPassword());

            return ps.executeUpdate() > 0;
        } catch(Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    public UserModel login(String email, String password) {
        try {
            Connection con = DBCon.getConnection();
            String sql = "SELECT * FROM users WHERE email=? AND password=?";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, email);
            ps.setString(2, password);

            ResultSet rs = ps.executeQuery();

            if(rs.next()) {
                UserModel user = new UserModel();
                user.setId(rs.getInt("id"));
                user.setName(rs.getString("name"));
                user.setRole(rs.getString("role"));
                return user;
            }
        } catch(Exception e) {
            e.printStackTrace();
        }
        return null;
    }
}