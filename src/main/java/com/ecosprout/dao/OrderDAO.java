package com.ecosprout.dao;

import java.sql.*;
import java.util.*;
import com.ecosprout.model.OrderModel;
import com.ecosprout.util.DBUtil;

/** DAO for purchase orders. Soft-delete aware. */
public class OrderDAO {

    /** Insert a new order with status "pending" and a delivery location. */
    public boolean placeOrder(OrderModel o) throws SQLException {
        String sql = "INSERT INTO orders(buyer_id, product_id, quantity, total_price, delivery_location, status) "
                   + "VALUES(?,?,?,?,?,?)";
        try (Connection con = DBUtil.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, o.getBuyerId());
            ps.setInt(2, o.getProductId());
            ps.setInt(3, o.getQuantity());
            ps.setDouble(4, o.getTotalPrice());
            ps.setString(5, o.getDeliveryLocation());
            ps.setString(6, "pending");
            return ps.executeUpdate() > 0;
        }
    }

    /** Orders placed by a specific buyer (newest first). */
    public List<OrderModel> getOrdersByBuyer(int buyerId) throws SQLException {
        String sql = "SELECT o.*, p.name AS product_name FROM orders o "
                   + "JOIN products p ON o.product_id = p.id "
                   + "WHERE o.buyer_id=? AND o.is_deleted=0 "
                   + "ORDER BY o.created_at DESC";
        return runListWith(sql, ps -> ps.setInt(1, buyerId), true, false);
    }

    /** All orders with product and buyer name joined (admin view). */
    public List<OrderModel> getAllOrders() throws SQLException {
        String sql = "SELECT o.*, p.name AS product_name, u.name AS buyer_name "
                   + "FROM orders o "
                   + "JOIN products p ON o.product_id = p.id "
                   + "JOIN users    u ON o.buyer_id   = u.id "
                   + "WHERE o.is_deleted=0 "
                   + "ORDER BY o.created_at DESC";
        return runListWith(sql, ps -> {}, true, true);
    }

    /** Orders for products belonging to a specific vendor. */
    public List<OrderModel> getOrdersByVendor(int vendorId) throws SQLException {
        String sql = "SELECT o.*, p.name AS product_name, u.name AS buyer_name "
                   + "FROM orders o "
                   + "JOIN products p ON o.product_id = p.id "
                   + "JOIN users    u ON o.buyer_id   = u.id "
                   + "WHERE p.vendor_id=? AND o.is_deleted=0 "
                   + "ORDER BY o.created_at DESC";
        return runListWith(sql, ps -> ps.setInt(1, vendorId), true, true);
    }

    /** Total number of non-deleted orders. */
    public int countOrders() throws SQLException {
        try (Connection con = DBUtil.getConnection();
             PreparedStatement ps = con.prepareStatement(
                "SELECT COUNT(*) FROM orders WHERE is_deleted=0");
             ResultSet rs = ps.executeQuery()) {
            return rs.next() ? rs.getInt(1) : 0;
        }
    }

    /** Orders grouped by status. */
    public Map<String, Integer> countByStatus() throws SQLException {
        Map<String, Integer> map = new LinkedHashMap<>();
        try (Connection con = DBUtil.getConnection();
             PreparedStatement ps = con.prepareStatement(
                "SELECT status, COUNT(*) AS c FROM orders "
              + "WHERE is_deleted=0 GROUP BY status");
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) map.put(rs.getString("status"), rs.getInt("c"));
        }
        return map;
    }

    /** Top selling products by units ordered. */
    public List<Map<String, Object>> topSellingProducts(int limit) throws SQLException {
        List<Map<String, Object>> list = new ArrayList<>();
        String sql = "SELECT p.name AS product_name, SUM(o.quantity) AS total_qty "
                   + "FROM orders o JOIN products p ON o.product_id = p.id "
                   + "WHERE o.is_deleted=0 AND p.is_deleted=0 "
                   + "GROUP BY p.id, p.name ORDER BY total_qty DESC LIMIT ?";
        try (Connection con = DBUtil.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, limit);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Map<String, Object> row = new LinkedHashMap<>();
                row.put("name", rs.getString("product_name"));
                row.put("qty",  rs.getInt("total_qty"));
                list.add(row);
            }
        }
        return list;
    }

    /** Fetch one order (with product, buyer and vendor names joined). */
    public OrderModel getById(int id) throws SQLException {
        String sql = "SELECT o.*, p.name AS product_name, p.vendor_id AS prod_vendor, "
                   + "u.name AS buyer_name, v.name AS vendor_name "
                   + "FROM orders o "
                   + "JOIN products p ON o.product_id = p.id "
                   + "JOIN users    u ON o.buyer_id   = u.id "
                   + "JOIN users    v ON p.vendor_id  = v.id "
                   + "WHERE o.id=? AND o.is_deleted=0";
        try (Connection con = DBUtil.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                OrderModel o = mapRow(rs);
                o.setProductName(rs.getString("product_name"));
                o.setBuyerName(rs.getString("buyer_name"));
                o.setVendorId(rs.getInt("prod_vendor"));
                o.setVendorName(rs.getString("vendor_name"));
                return o;
            }
            return null;
        }
    }

    /** Update the lifecycle status of an order. */
    public boolean updateStatus(int orderId, String newStatus) throws SQLException {
        try (Connection con = DBUtil.getConnection();
             PreparedStatement ps = con.prepareStatement(
                "UPDATE orders SET status=? WHERE id=? AND is_deleted=0")) {
            ps.setString(1, newStatus);
            ps.setInt(2, orderId);
            return ps.executeUpdate() > 0;
        }
    }

    /** True if a buyer has placed at least one order for this product. */
    public boolean hasOrdered(int buyerId, int productId) throws SQLException {
        try (Connection con = DBUtil.getConnection();
             PreparedStatement ps = con.prepareStatement(
                "SELECT id FROM orders WHERE buyer_id=? AND product_id=? AND is_deleted=0 LIMIT 1")) {
            ps.setInt(1, buyerId);
            ps.setInt(2, productId);
            return ps.executeQuery().next();
        }
    }

    /** Soft-delete an order. */
    public boolean deleteOrder(int id) throws SQLException {
        try (Connection con = DBUtil.getConnection();
             PreparedStatement ps = con.prepareStatement(
                "UPDATE orders SET is_deleted=1 WHERE id=?")) {
            ps.setInt(1, id);
            return ps.executeUpdate() > 0;
        }
    }

    /** Functional helper for queries that take 0 or 1 parameter and may pull joined names. */
    private interface Binder { void bind(PreparedStatement ps) throws SQLException; }

    private List<OrderModel> runListWith(String sql, Binder binder,
                                         boolean hasProductName, boolean hasBuyerName) throws SQLException {
        List<OrderModel> list = new ArrayList<>();
        try (Connection con = DBUtil.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            binder.bind(ps);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                OrderModel o = mapRow(rs);
                if (hasProductName) o.setProductName(rs.getString("product_name"));
                if (hasBuyerName)   o.setBuyerName(rs.getString("buyer_name"));
                list.add(o);
            }
        }
        return list;
    }

    private OrderModel mapRow(ResultSet rs) throws SQLException {
        OrderModel o = new OrderModel();
        o.setId(rs.getInt("id"));
        o.setBuyerId(rs.getInt("buyer_id"));
        o.setProductId(rs.getInt("product_id"));
        o.setQuantity(rs.getInt("quantity"));
        o.setTotalPrice(rs.getDouble("total_price"));
        o.setStatus(rs.getString("status"));
        o.setCreatedAt(rs.getString("created_at"));
        try { o.setDeliveryLocation(rs.getString("delivery_location")); } catch (SQLException ignore) {}
        return o;
    }
}
