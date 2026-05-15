package com.ecosprout.controllers;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import com.ecosprout.model.ProductModel;
import com.ecosprout.model.UserModel;
import com.ecosprout.service.ProductService;
import com.ecosprout.service.ReviewService;

/** Shows reviews for one product (GET) and posts a new review (POST). */
@WebServlet("/reviews")
public class ReviewServlet extends HttpServlet {

    private final ReviewService  reviewService  = new ReviewService();
    private final ProductService productService = new ProductService();

    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {
        loadAndForward(req, res);
    }

    protected void doPost(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        UserModel buyer = (UserModel) req.getSession().getAttribute("user");
        int productId = parseInt(req.getParameter("productId"), -1);

        try {
            int rating = parseInt(req.getParameter("rating"), 0);
            String comment = req.getParameter("comment");
            String err = reviewService.addReview(productId, buyer.getId(), rating, comment);
            if (err != null) req.setAttribute("error", err);
            else             req.setAttribute("success", "Thanks for your review.");
        } catch (Exception e) {
            req.setAttribute("error", "Could not save review. Please try again.");
        }

        loadAndForward(req, res);
    }

    /** Loads the product + its reviews, then forwards to reviews.jsp. */
    private void loadAndForward(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        int productId = parseInt(req.getParameter("productId"), -1);

        try {
            ProductModel p = productService.getProductById(productId);
            req.setAttribute("product", p);
            req.setAttribute("reviews", reviewService.getReviewsByProduct(productId));
        } catch (Exception e) {
            req.setAttribute("error", "Could not load reviews.");
        }

        req.getRequestDispatcher("/WEB-INF/pages/reviews.jsp").forward(req, res);
    }

    private static int parseInt(String s, int fallback) {
        try { return Integer.parseInt(s); } catch (Exception e) { return fallback; }
    }
}
