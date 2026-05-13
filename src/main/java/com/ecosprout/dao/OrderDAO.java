package com.ecosprout.dao;

import java.sql.*;
import java.util.*;
import com.ecosprout.model.OrderModel;
import com.ecosprout.util.DBUtil;

/** DAO for purchase orders. */
public class OrderDAO {

    /** Insert a new order with status "pending". */
    public boolean placeOrder(OrderModel o) throws SQLException {
        String sql = "INSERT INTO orders(buyer_id, product_id, quantity, total_price, status) "
                   + "VALUES(?,?,?,?,?)";
        try (Connection con = DBUtil.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, o.getBuyerId());
            ps.setInt(2, o.getProductId());
            ps.setInt(3, o.getQuantity());
            ps.setDouble(4, o.getTotalPrice());
            ps.setString(5, "pending");
            return ps.executeUpdate() > 0;
        }
    }

    /** Orders placed by a specific buyer (newest first). */
    public List<OrderModel> getOrdersByBuyer(int buyerId) throws SQLException {
        List<OrderModel> list = new ArrayList<>();
        String sql = "SELECT o.*, p.name AS product_name FROM orders o "
                   + "JOIN products p ON o.product_id = p.id "
                   + "WHERE o.buyer_id=? ORDER BY o.created_at DESC";
        try (Connection con = DBUtil.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, buyerId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                OrderModel om = mapRow(rs);
                om.setProductName(rs.getString("product_name"));
                list.add(om);
            }
        }
        return list;
    }

    /** All orders with product and buyer name joined (for admin views). */
    public List<OrderModel> getAllOrders() throws SQLException {
        List<OrderModel> list = new ArrayList<>();
        String sql = "SELECT o.*, p.name AS product_name, u.name AS buyer_name "
                   + "FROM orders o JOIN products p ON o.product_id = p.id "
                   + "JOIN users u ON o.buyer_id = u.id ORDER BY o.created_at DESC";
        try (Connection con = DBUtil.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                OrderModel om = mapRow(rs);
                om.setProductName(rs.getString("product_name"));
                om.setBuyerName(rs.getString("buyer_name"));
                list.add(om);
            }
        }
        return list;
    }

    /** Total number of orders. */
    public int countOrders() throws SQLException {
        try (Connection con = DBUtil.getConnection();
             PreparedStatement ps = con.prepareStatement("SELECT COUNT(*) FROM orders");
             ResultSet rs = ps.executeQuery()) {
            return rs.next() ? rs.getInt(1) : 0;
        }
    }

    /** Orders grouped by status (returns status -> count). */
    public Map<String, Integer> countByStatus() throws SQLException {
        Map<String, Integer> map = new LinkedHashMap<>();
        try (Connection con = DBUtil.getConnection();
             PreparedStatement ps = con.prepareStatement(
                "SELECT status, COUNT(*) AS c FROM orders GROUP BY status");
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) map.put(rs.getString("status"), rs.getInt("c"));
        }
        return map;
    }

    /** Top selling products by quantity ordered (top N). */
    public List<Map<String, Object>> topSellingProducts(int limit) throws SQLException {
        List<Map<String, Object>> list = new ArrayList<>();
        String sql = "SELECT p.name AS product_name, SUM(o.quantity) AS total_qty "
                   + "FROM orders o JOIN products p ON o.product_id = p.id "
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

    /** Build an OrderModel from a ResultSet row. */
    private OrderModel mapRow(ResultSet rs) throws SQLException {
        OrderModel o = new OrderModel();
        o.setId(rs.getInt("id"));
        o.setBuyerId(rs.getInt("buyer_id"));
        o.setProductId(rs.getInt("product_id"));
        o.setQuantity(rs.getInt("quantity"));
        o.setTotalPrice(rs.getDouble("total_price"));
        o.setStatus(rs.getString("status"));
        o.setCreatedAt(rs.getString("created_at"));
        return o;
    }
}
