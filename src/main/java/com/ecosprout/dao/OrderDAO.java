package com.ecosprout.dao;

import java.sql.*;
import java.util.*;
import com.ecosprout.model.OrderModel;
import com.ecosprout.util.DBUtil;

/**
 * OrderDAO - Data Access Object for purchase orders.
 */
public class OrderDAO {

    /**
     * Places a new order for a buyer.
     */
    public boolean placeOrder(OrderModel o) throws SQLException {
        String sql = "INSERT INTO orders(buyer_id, product_id, quantity, total_price, status) VALUES(?,?,?,?,?)";
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

    /**
     * Returns all orders for a specific buyer.
     */
    public List<OrderModel> getOrdersByBuyer(int buyerId) throws SQLException {
        List<OrderModel> list = new ArrayList<>();
        String sql = "SELECT o.*, p.name AS product_name FROM orders o " +
                     "JOIN products p ON o.product_id = p.id WHERE o.buyer_id=? ORDER BY o.created_at DESC";
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

    /**
     * Returns all orders (admin view).
     */
    public List<OrderModel> getAllOrders() throws SQLException {
        List<OrderModel> list = new ArrayList<>();
        String sql = "SELECT o.*, p.name AS product_name, u.name AS buyer_name " +
                     "FROM orders o JOIN products p ON o.product_id = p.id " +
                     "JOIN users u ON o.buyer_id = u.id ORDER BY o.created_at DESC";
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

    /**
     * Returns the total number of orders in the database.
     */
    public int countOrders() throws SQLException {
        String sql = "SELECT COUNT(*) FROM orders";
        try (Connection con = DBUtil.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            return rs.next() ? rs.getInt(1) : 0;
        }
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
        return o;
    }
}
