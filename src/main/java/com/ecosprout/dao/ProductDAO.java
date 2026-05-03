package com.ecosprout.dao;

import java.sql.*;
import java.util.*;
import com.ecosprout.model.*;
import com.ecosprout.util.*;

public class ProductDAO {

    public boolean addProduct(ProductModel p) {
        try {
            Connection con = DBUtil.getConnection();

            PreparedStatement ps = con.prepareStatement(
                "INSERT INTO products(name,category,image,vendor_id) VALUES(?,?,?,?)"
            );

            ps.setString(1, p.getName());
            ps.setString(2, p.getCategory());
            ps.setString(3, p.getImage());
            ps.setInt(4, p.getVendorId());

            return ps.executeUpdate() > 0;

        } catch(Exception e) { e.printStackTrace(); }
        return false;
    }

    public List<ProductModel> getAllProducts() {
        List<ProductModel> list = new ArrayList<>();
        try {
            Connection con = DBUtil.getConnection();
            ResultSet rs = con.createStatement().executeQuery("SELECT * FROM products");

            while(rs.next()) {
                ProductModel p = new ProductModel();
                p.setId(rs.getInt("id"));
                p.setName(rs.getString("name"));
                p.setCategory(rs.getString("category"));
                p.setImage(rs.getString("image"));
                list.add(p);
            }
        } catch(Exception e) {}
        return list;
    }

    public boolean updateProduct(int id, String name, String category) {
        try {
            Connection con = DBUtil.getConnection();

            PreparedStatement ps = con.prepareStatement(
                "UPDATE products SET name=?,category=? WHERE id=?"
            );

            ps.setString(1, name);
            ps.setString(2, category);
            ps.setInt(3, id);

            return ps.executeUpdate() > 0;

        } catch(Exception e) {}
        return false;
    }
}