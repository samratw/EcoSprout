package com.ecosprout.dao;

import java.sql.*;
import java.util.*;
import com.ecosprout.model.ProductModel;
import com.ecosprout.util.DBUtil;

/**
 * ProductDAO - Data Access Object for product-related database operations.
 */
public class ProductDAO {

    /**
     * Adds a new product to the database.
     */
    public boolean addProduct(ProductModel p) throws SQLException {
        String sql = "INSERT INTO products(name, category, description, price, quantity, unit, image, vendor_id) VALUES(?,?,?,?,?,?,?,?)";
        try (Connection con = DBUtil.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, p.getName());
            ps.setString(2, p.getCategory());
            ps.setString(3, p.getDescription());
            ps.setDouble(4, p.getPrice());
            ps.setInt(5, p.getQuantity());
            ps.setString(6, p.getUnit());
            ps.setString(7, p.getImage());
            ps.setInt(8, p.getVendorId());

            return ps.executeUpdate() > 0;
        }
    }

    /**
     * Returns all products (admin view).
     */
    public List<ProductModel> getAllProducts() throws SQLException {
        List<ProductModel> list = new ArrayList<>();
        String sql = "SELECT * FROM products ORDER BY created_at DESC";
        try (Connection con = DBUtil.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) list.add(mapRow(rs));
        }
        return list;
    }

    /**
     * Returns all products matching a search keyword in name or category.
     */
    public List<ProductModel> searchProducts(String keyword) throws SQLException {
        List<ProductModel> list = new ArrayList<>();
        String sql = "SELECT * FROM products WHERE name LIKE ? OR category LIKE ? ORDER BY created_at DESC";
        try (Connection con = DBUtil.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            String kw = "%" + keyword + "%";
            ps.setString(1, kw);
            ps.setString(2, kw);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) list.add(mapRow(rs));
        }
        return list;
    }

    /**
     * Returns all products belonging to a specific vendor.
     */
    public List<ProductModel> getProductsByVendor(int vendorId) throws SQLException {
        List<ProductModel> list = new ArrayList<>();
        String sql = "SELECT * FROM products WHERE vendor_id=? ORDER BY created_at DESC";
        try (Connection con = DBUtil.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, vendorId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) list.add(mapRow(rs));
        }
        return list;
    }

    /**
     * Retrieves a single product by its ID.
     */
    public ProductModel getProductById(int id) throws SQLException {
        String sql = "SELECT * FROM products WHERE id=?";
        try (Connection con = DBUtil.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) return mapRow(rs);
        }
        return null;
    }

    /**
     * Updates a product's details.
     */
    public boolean updateProduct(ProductModel p) throws SQLException {
        String sql = "UPDATE products SET name=?, category=?, description=?, price=?, quantity=?, unit=?, status=? WHERE id=?";
        try (Connection con = DBUtil.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, p.getName());
            ps.setString(2, p.getCategory());
            ps.setString(3, p.getDescription());
            ps.setDouble(4, p.getPrice());
            ps.setInt(5, p.getQuantity());
            ps.setString(6, p.getUnit());
            ps.setString(7, p.getStatus());
            ps.setInt(8, p.getId());
            return ps.executeUpdate() > 0;
        }
    }

    /**
     * Deletes a product by its ID.
     */
    public boolean deleteProduct(int id) throws SQLException {
        String sql = "DELETE FROM products WHERE id=?";
        try (Connection con = DBUtil.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, id);
            return ps.executeUpdate() > 0;
        }
    }

    /**
     * Returns the total count of products in the database.
     */
    public int countProducts() throws SQLException {
        String sql = "SELECT COUNT(*) FROM products";
        try (Connection con = DBUtil.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            return rs.next() ? rs.getInt(1) : 0;
        }
    }

    /**
     * Maps a ResultSet row to a ProductModel object.
     */
    private ProductModel mapRow(ResultSet rs) throws SQLException {
        ProductModel p = new ProductModel();
        p.setId(rs.getInt("id"));
        p.setName(rs.getString("name"));
        p.setCategory(rs.getString("category"));
        p.setDescription(rs.getString("description"));
        p.setPrice(rs.getDouble("price"));
        p.setQuantity(rs.getInt("quantity"));
        p.setUnit(rs.getString("unit"));
        p.setImage(rs.getString("image"));
        p.setVendorId(rs.getInt("vendor_id"));
        p.setStatus(rs.getString("status"));
        return p;
    }
}
