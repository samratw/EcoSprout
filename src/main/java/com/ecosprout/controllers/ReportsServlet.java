package com.ecosprout.controllers;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import com.ecosprout.dao.ContactDAO;
import com.ecosprout.dao.OrderDAO;
import com.ecosprout.dao.ProductDAO;
import com.ecosprout.service.UserService;

/** Admin analytics: catalogue, orders, users, top sellers, contacts. */
@WebServlet("/reports")
public class ReportsServlet extends HttpServlet {

    private final ProductDAO  productDAO  = new ProductDAO();
    private final OrderDAO    orderDAO    = new OrderDAO();
    private final ContactDAO  contactDAO  = new ContactDAO();
    private final UserService userService = new UserService();

    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {
        try {
            req.setAttribute("productsByCategory", productDAO.countByCategory());
            req.setAttribute("ordersByStatus",     orderDAO.countByStatus());
            req.setAttribute("usersByRole",        userService.countByRole());
            req.setAttribute("topSellers",         orderDAO.topSellingProducts(5));
            req.setAttribute("totalProducts",      productDAO.countProducts());
            req.setAttribute("totalOrders",        orderDAO.countOrders());
            req.setAttribute("totalContacts",      contactDAO.countContacts());
            req.setAttribute("recentContacts",     contactDAO.getRecentContacts(5));
        } catch (Exception e) {
            req.setAttribute("error", "Could not load reports.");
        }
        req.getRequestDispatcher("/WEB-INF/pages/reports.jsp").forward(req, res);
    }
}
