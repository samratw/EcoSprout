package com.ecosprout.controllers;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import com.ecosprout.service.ProductService;

/**
 * BuyerServlet - Loads the product listing for buyers with optional search.
 */
@WebServlet("/buyer")
public class BuyerServlet extends HttpServlet {

    private final ProductService productService = new ProductService();

    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {
        String keyword = req.getParameter("search");
        try {
            req.setAttribute("products", productService.searchProducts(keyword));
            req.setAttribute("search", keyword);
        } catch (Exception e) {
            req.setAttribute("error", "Could not load products.");
        }
        req.getRequestDispatcher("/WEB-INF/pages/buyer.jsp").forward(req, res);
    }
}
