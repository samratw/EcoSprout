package com.ecosprout.dao;

import java.sql.*;
import java.util.*;
import com.ecosprout.model.ProductModel;
import com.ecosprout.util.DBUtil;

/** DAO for product-related database operations. Soft-delete aware. */
public class ProductDAO {

    /** Common SELECT joining ratings, filtering out soft-deleted rows. */
    private static final String BASE_SELECT =
        "SELECT p.*, "
      + "       COALESCE(AVG(r.rating), 0)            AS avg_rating, "
      + "       COUNT(CASE WHEN r.is_deleted=0 THEN r.id END) AS review_count "
      + "FROM products p "
      + "LEFT JOIN reviews r ON r.product_id = p.id AND r.is_deleted = 0 "
      + "WHERE p.is_deleted = 0 ";

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
        return runListQuery(BASE_SELECT + "GROUP BY p.id ORDER BY p.created_at DESC");
    }

    /** Search by keyword in name or category. */
    public List<ProductModel> searchProducts(String keyword) throws SQLException {
        String kw = (keyword == null) ? "%" : "%" + keyword + "%";
        String sql = BASE_SELECT
                   + "AND (p.name LIKE ? OR p.category LIKE ?) "
                   + "GROUP BY p.id ORDER BY p.created_at DESC";
        List<ProductModel> list = new ArrayList<>();
        try (Connection con = DBUtil.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, kw);
            ps.setString(2, kw);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) list.add(mapRowWithRating(rs));
        }
        return list;
    }

    /** Products belonging to a vendor. */
    public List<ProductModel> getProductsByVendor(int vendorId) throws SQLException {
        String sql = BASE_SELECT + "AND p.vendor_id=? GROUP BY p.id ORDER BY p.created_at DESC";
        List<ProductModel> list = new ArrayList<>();
        try (Connection con = DBUtil.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, vendorId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) list.add(mapRowWithRating(rs));
        }
        return list;
    }

    /** Get one product by id (still must be non-deleted). */
    public ProductModel getProductById(int id) throws SQLException {
        String sql = BASE_SELECT + "AND p.id=? GROUP BY p.id";
        try (Connection con = DBUtil.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            return rs.next() ? mapRowWithRating(rs) : null;
        }
    }

    /** Update product details. */
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

    /**
     * Reduce a product's stock by the ordered quantity.
     * The "quantity >= ?" guard prevents the stock going negative when two
     * buyers order the last units at the same time. When stock reaches zero
     * the product status is flipped to out_of_stock automatically.
     * @return true if the stock was reduced, false if there was not enough.
     */
    public boolean decreaseStock(int productId, int qty) throws SQLException {
        String sql = "UPDATE products "
                   + "SET quantity = quantity - ?, "
                   + "    status   = CASE WHEN quantity - ? <= 0 "
                   + "                    THEN 'out_of_stock' ELSE status END "
                   + "WHERE id = ? AND quantity >= ? AND is_deleted = 0";
        try (Connection con = DBUtil.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, qty);
            ps.setInt(2, qty);
            ps.setInt(3, productId);
            ps.setInt(4, qty);
            return ps.executeUpdate() > 0;
        }
    }

    /** Soft-delete: row stays in DB, just flagged so it is filtered out. */
    public boolean deleteProduct(int id) throws SQLException {
        try (Connection con = DBUtil.getConnection();
             PreparedStatement ps = con.prepareStatement(
                "UPDATE products SET is_deleted=1 WHERE id=?")) {
            ps.setInt(1, id);
            return ps.executeUpdate() > 0;
        }
    }

    /** Count of non-deleted products. */
    public int countProducts() throws SQLException {
        try (Connection con = DBUtil.getConnection();
             PreparedStatement ps = con.prepareStatement(
                "SELECT COUNT(*) FROM products WHERE is_deleted=0");
             ResultSet rs = ps.executeQuery()) {
            return rs.next() ? rs.getInt(1) : 0;
        }
    }

    /** Group non-deleted products by category. */
    public Map<String, Integer> countByCategory() throws SQLException {
        Map<String, Integer> map = new LinkedHashMap<>();
        try (Connection con = DBUtil.getConnection();
             PreparedStatement ps = con.prepareStatement(
                "SELECT category, COUNT(*) AS c FROM products "
              + "WHERE is_deleted=0 GROUP BY category ORDER BY c DESC");
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) map.put(rs.getString("category"), rs.getInt("c"));
        }
        return map;
    }

    private List<ProductModel> runListQuery(String sql) throws SQLException {
        List<ProductModel> list = new ArrayList<>();
        try (Connection con = DBUtil.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) list.add(mapRowWithRating(rs));
        }
        return list;
    }

    private ProductModel mapRowWithRating(ResultSet rs) throws SQLException {
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
        // Optional columns (only present in BASE_SELECT)
        try { p.setAvgRating(rs.getDouble("avg_rating")); }   catch (SQLException ignore) {}
        try { p.setReviewCount(rs.getInt("review_count")); }  catch (SQLException ignore) {}
        return p;
    }
}
