package com.ecosprout.dao;

import java.sql.*;
import java.util.*;
import com.ecosprout.model.ProductModel;
import com.ecosprout.util.DBUtil;

/** DAO for product-related database operations. */
public class ProductDAO {

    /** Insert a new product. */
    public boolean addProduct(ProductModel p) throws SQLException {
        String sql = "INSERT INTO products(name, category, description, price, quantity, unit, image, vendor_id) "
                   + "VALUES(?,?,?,?,?,?,?,?)";
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

    /** All products (newest first). */
    public List<ProductModel> getAllProducts() throws SQLException {
        List<ProductModel> list = new ArrayList<>();
        try (Connection con = DBUtil.getConnection();
             PreparedStatement ps = con.prepareStatement(
                "SELECT * FROM products ORDER BY created_at DESC");
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) list.add(mapRow(rs));
        }
        return list;
    }

    /** Products matching a keyword in name or category. */
    public List<ProductModel> searchProducts(String keyword) throws SQLException {
        List<ProductModel> list = new ArrayList<>();
        String sql = "SELECT * FROM products WHERE name LIKE ? OR category LIKE ? "
                   + "ORDER BY created_at DESC";
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

    /** Products belonging to a vendor. */
    public List<ProductModel> getProductsByVendor(int vendorId) throws SQLException {
        List<ProductModel> list = new ArrayList<>();
        try (Connection con = DBUtil.getConnection();
             PreparedStatement ps = con.prepareStatement(
                "SELECT * FROM products WHERE vendor_id=? ORDER BY created_at DESC")) {
            ps.setInt(1, vendorId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) list.add(mapRow(rs));
        }
        return list;
    }

    /** Get a single product by id. */
    public ProductModel getProductById(int id) throws SQLException {
        try (Connection con = DBUtil.getConnection();
             PreparedStatement ps = con.prepareStatement("SELECT * FROM products WHERE id=?")) {
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            return rs.next() ? mapRow(rs) : null;
        }
    }

    /** Update a product. */
    public boolean updateProduct(ProductModel p) throws SQLException {
        String sql = "UPDATE products SET name=?, category=?, description=?, price=?, "
                   + "quantity=?, unit=?, status=? WHERE id=?";
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

    /** Delete by id. */
    public boolean deleteProduct(int id) throws SQLException {
        try (Connection con = DBUtil.getConnection();
             PreparedStatement ps = con.prepareStatement("DELETE FROM products WHERE id=?")) {
            ps.setInt(1, id);
            return ps.executeUpdate() > 0;
        }
    }

    /** Total product count. */
    public int countProducts() throws SQLException {
        try (Connection con = DBUtil.getConnection();
             PreparedStatement ps = con.prepareStatement("SELECT COUNT(*) FROM products");
             ResultSet rs = ps.executeQuery()) {
            return rs.next() ? rs.getInt(1) : 0;
        }
    }

    /** Products grouped by category (category -> count). */
    public Map<String, Integer> countByCategory() throws SQLException {
        Map<String, Integer> map = new LinkedHashMap<>();
        try (Connection con = DBUtil.getConnection();
             PreparedStatement ps = con.prepareStatement(
                "SELECT category, COUNT(*) AS c FROM products GROUP BY category ORDER BY c DESC");
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) map.put(rs.getString("category"), rs.getInt("c"));
        }
        return map;
    }

    /** Map a ResultSet row to a ProductModel. */
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
