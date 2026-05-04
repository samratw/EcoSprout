package com.ecosprout.controllers;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import com.ecosprout.service.UserService;

/**
 * ManageUsersServlet - Admin panel for listing users and approving/rejecting accounts.
 */
@WebServlet("/manageusers")
public class ManageUsersServlet extends HttpServlet {

    private final UserService userService = new UserService();

    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {
        try {
            req.setAttribute("users", userService.getAllUsers());
        } catch (Exception e) {
            req.setAttribute("error", "Could not load users.");
        }
        req.getRequestDispatcher("/WEB-INF/pages/manageusers.jsp").forward(req, res);
    }

    protected void doPost(HttpServletRequest req, HttpServletResponse res)
            throws IOException, ServletException {
        try {
            int    userId = Integer.parseInt(req.getParameter("userId"));
            String action = req.getParameter("action");
            String status = "approve".equals(action) ? "approved" : "rejected";
            userService.updateStatus(userId, status);
        } catch (Exception e) {
            req.setAttribute("error", "Could not update user status.");
        }
        res.sendRedirect(req.getContextPath() + "/manageusers");
    }
}
