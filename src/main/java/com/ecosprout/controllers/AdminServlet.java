package com.ecosprout.controllers;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import com.ecosprout.dao.OrderDAO;
import com.ecosprout.service.ProductService;
import com.ecosprout.service.UserService;

/**
 * AdminServlet - Loads data for the admin dashboard.
 */
@WebServlet("/admin")
public class AdminServlet extends HttpServlet {

    private final UserService    userService    = new UserService();
    private final ProductService productService = new ProductService();
    private final OrderDAO       orderDAO       = new OrderDAO();

    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {
        try {
            req.setAttribute("totalProducts", productService.countProducts());
            req.setAttribute("pendingUsers",  userService.countPendingUsers());
            req.setAttribute("totalOrders",   orderDAO.countOrders());
            req.setAttribute("recentOrders",  orderDAO.getAllOrders());
        } catch (Exception e) {
            req.setAttribute("dbError", "Could not load dashboard stats.");
        }
        req.getRequestDispatcher("/WEB-INF/pages/admin.jsp").forward(req, res);
    }
}
