package com.ecosprout.controllers;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.Set;
import com.ecosprout.model.ProductModel;
import com.ecosprout.service.ProductService;
import com.ecosprout.service.ReviewService;

/** Full product details page. */
@WebServlet("/product")
public class ProductServlet extends HttpServlet {

    private final ProductService productService = new ProductService();
    private final ReviewService  reviewService  = new ReviewService();

    @SuppressWarnings("unchecked")
    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        int id = parseInt(req.getParameter("id"), -1);

        try {
            ProductModel p = productService.getProductById(id);
            req.setAttribute("product", p);
            if (p != null) {
                req.setAttribute("reviews", reviewService.getReviewsByProduct(id));
            }
            // Tell the page whether this product is already wishlisted
            Set<Integer> wishlist = (Set<Integer>) req.getSession().getAttribute("wishlist");
            req.setAttribute("inWishlist", wishlist != null && wishlist.contains(id));
        } catch (Exception e) {
            req.setAttribute("error", "Could not load this product.");
        }

        req.getRequestDispatcher("/WEB-INF/pages/product.jsp").forward(req, res);
    }

    private static int parseInt(String s, int fallback) {
        try { return Integer.parseInt(s); } catch (Exception e) { return fallback; }
    }
}
