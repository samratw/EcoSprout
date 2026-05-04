package com.ecosprout.controllers;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import com.ecosprout.service.ProductService;

/**
 * ViewProductsServlet - Displays all products (accessible to admin and vendor).
 */
@WebServlet("/viewproducts")
public class ViewProductsServlet extends HttpServlet {

    private final ProductService productService = new ProductService();

    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {
        try {
            req.setAttribute("products", productService.getAllProducts());
        } catch (Exception e) {
            req.setAttribute("error", "Could not load products.");
        }
        req.getRequestDispatcher("/WEB-INF/pages/viewproducts.jsp").forward(req, res);
    }
}
