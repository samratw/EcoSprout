package com.ecosprout.controllers;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import com.ecosprout.model.UserModel;
import com.ecosprout.service.ProductService;

/**
 * DeleteProductServlet - Handles deletion of a product by the vendor or admin.
 */
@WebServlet("/deleteproduct")
public class DeleteProductServlet extends HttpServlet {

    private final ProductService productService = new ProductService();

    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {
        UserModel user = (UserModel) req.getSession().getAttribute("user");
        try {
            int id = Integer.parseInt(req.getParameter("id"));
            productService.deleteProduct(id);
        } catch (Exception e) {
            // Log error but continue redirect
        }
        res.sendRedirect(req.getContextPath() + ("admin".equals(user.getRole()) ? "/admin" : "/vendor"));
    }
}
