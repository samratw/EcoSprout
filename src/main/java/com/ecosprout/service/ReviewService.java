package com.ecosprout.service;

import java.sql.SQLException;
import java.util.List;
import com.ecosprout.dao.OrderDAO;
import com.ecosprout.dao.ReviewDAO;
import com.ecosprout.model.ReviewModel;

/** Business logic for product reviews. */
public class ReviewService {

    private final ReviewDAO reviewDAO = new ReviewDAO();
    private final OrderDAO  orderDAO  = new OrderDAO();

    /**
     * Add a review. Returns null on success or an error message.
     * A buyer can only review a product they have actually ordered.
     */
    public String addReview(int productId, int buyerId, int rating, String comment) throws SQLException {
        if (productId <= 0 || buyerId <= 0)
            return "Invalid product or user.";
        if (rating < 1 || rating > 5)
            return "Rating must be between 1 and 5 stars.";
        if (comment == null || comment.trim().isEmpty())
            return "Please write a short comment.";
        if (!orderDAO.hasOrdered(buyerId, productId))
            return "You can only review products you have purchased.";
        if (reviewDAO.hasReviewed(productId, buyerId))
            return "You have already reviewed this product.";

        ReviewModel r = new ReviewModel();
        r.setProductId(productId);
        r.setBuyerId(buyerId);
        r.setRating(rating);
        r.setComment(comment.trim());
        reviewDAO.addReview(r);
        return null;
    }

    public List<ReviewModel> getReviewsByProduct(int productId) throws SQLException {
        return reviewDAO.getReviewsByProduct(productId);
    }

    public boolean deleteReview(int id) throws SQLException {
        return reviewDAO.deleteReview(id);
    }
}
