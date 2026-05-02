package com.ecosprout.daos;

import java.sql.*;
import java.util.*;
import com.ecosprout.models.ProductModel;
import com.ecosprout.utils.DBCon;

public class ProductDAO {

    public boolean addProduct(ProductModel p) {
        try {
            Connection con = DBCon.getConnection();
            String sql = "INSERT INTO products(name,category,price,quantity,description) VALUES(?,?,?,?,?)";
            PreparedStatement ps = con.prepareStatement(sql);

            ps.setString(1, p.getName());
            ps.setString(2, p.getCategory());
            ps.setDouble(3, p.getPrice());
            ps.setInt(4, p.getQuantity());
            ps.setString(5, p.getDescription());

            return ps.executeUpdate() > 0;
        } catch(Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    public List<ProductModel> getAllProducts() {
        List<ProductModel> list = new ArrayList<>();
        try {
            Connection con = DBCon.getConnection();
            String sql = "SELECT * FROM products";
            ResultSet rs = con.createStatement().executeQuery(sql);

            while(rs.next()) {
                ProductModel p = new ProductModel();
                p.setId(rs.getInt("id"));
                p.setName(rs.getString("name"));
                p.setCategory(rs.getString("category"));
                p.setPrice(rs.getDouble("price"));
                p.setQuantity(rs.getInt("quantity"));
                p.setDescription(rs.getString("description"));

                list.add(p);
            }
        } catch(Exception e) {
            e.printStackTrace();
        }
        return list;
    }
}