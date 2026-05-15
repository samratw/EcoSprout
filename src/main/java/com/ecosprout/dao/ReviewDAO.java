package com.ecosprout.dao;

import java.sql.*;
import java.util.*;
import com.ecosprout.model.ReviewModel;
import com.ecosprout.util.DBUtil;

/** DAO for product reviews and ratings. Soft-delete aware. */
public class ReviewDAO {

    /** Add a new review. */
    public boolean addReview(ReviewModel r) throws SQLException {
        String sql = "INSERT INTO reviews(product_id, buyer_id, rating, comment) "
                   + "VALUES(?,?,?,?)";
        try (Connection con = DBUtil.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, r.getProductId());
            ps.setInt(2, r.getBuyerId());
            ps.setInt(3, r.getRating());
            ps.setString(4, r.getComment());
            return ps.executeUpdate() > 0;
        }
    }

    /** All non-deleted reviews for a product, newest first. */
    public List<ReviewModel> getReviewsByProduct(int productId) throws SQLException {
        List<ReviewModel> list = new ArrayList<>();
        String sql = "SELECT r.*, u.name AS buyer_name FROM reviews r "
                   + "JOIN users u ON r.buyer_id = u.id "
                   + "WHERE r.product_id=? AND r.is_deleted=0 "
                   + "ORDER BY r.created_at DESC";
        try (Connection con = DBUtil.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, productId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                ReviewModel r = mapRow(rs);
                r.setBuyerName(rs.getString("buyer_name"));
                list.add(r);
            }
        }
        return list;
    }

    /** True if this buyer has already reviewed the product. */
    public boolean hasReviewed(int productId, int buyerId) throws SQLException {
        String sql = "SELECT id FROM reviews WHERE product_id=? AND buyer_id=? AND is_deleted=0";
        try (Connection con = DBUtil.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, productId);
            ps.setInt(2, buyerId);
            return ps.executeQuery().next();
        }
    }

    /** Soft-delete a review. */
    public boolean deleteReview(int id) throws SQLException {
        try (Connection con = DBUtil.getConnection();
             PreparedStatement ps = con.prepareStatement(
                "UPDATE reviews SET is_deleted=1 WHERE id=?")) {
            ps.setInt(1, id);
            return ps.executeUpdate() > 0;
        }
    }

    private ReviewModel mapRow(ResultSet rs) throws SQLException {
        ReviewModel r = new ReviewModel();
        r.setId(rs.getInt("id"));
        r.setProductId(rs.getInt("product_id"));
        r.setBuyerId(rs.getInt("buyer_id"));
        r.setRating(rs.getInt("rating"));
        r.setComment(rs.getString("comment"));
        r.setCreatedAt(rs.getString("created_at"));
        return r;
    }
}
