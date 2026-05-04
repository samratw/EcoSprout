package com.ecosprout.controllers;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import com.ecosprout.model.UserModel;
import com.ecosprout.service.UserService;

/**
 * LoginServlet - Handles GET (show login page) and POST (authenticate user).
 */
@WebServlet("/login")
public class LoginServlet extends HttpServlet {

    private final UserService userService = new UserService();

    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {
        // If already logged in, redirect to dashboard
        HttpSession session = req.getSession(false);
        if (session != null && session.getAttribute("user") != null) {
            UserModel user = (UserModel) session.getAttribute("user");
            redirectByRole(res, req.getContextPath(), user.getRole());
            return;
        }
        req.getRequestDispatcher("/WEB-INF/pages/login.jsp").forward(req, res);
    }

    protected void doPost(HttpServletRequest req, HttpServletResponse res)
            throws IOException, ServletException {

        String email    = req.getParameter("email");
        String password = req.getParameter("password");

        // Basic input presence check
        if (email == null || email.trim().isEmpty() || password == null || password.trim().isEmpty()) {
            req.setAttribute("error", "Email and password are required.");
            req.getRequestDispatcher("/WEB-INF/pages/login.jsp").forward(req, res);
            return;
        }

        try {
            UserModel user = userService.login(email.trim(), password);

            if (user != null) {
                HttpSession session = req.getSession();
                session.setAttribute("user", user);
                redirectByRole(res, req.getContextPath(), user.getRole());
            } else {
                req.setAttribute("error", "Invalid credentials or account not yet approved.");
                req.getRequestDispatcher("/WEB-INF/pages/login.jsp").forward(req, res);
            }
        } catch (Exception e) {
            req.setAttribute("error", "A system error occurred. Please try again.");
            req.getRequestDispatcher("/WEB-INF/pages/login.jsp").forward(req, res);
        }
    }

    private void redirectByRole(HttpServletResponse res, String ctx, String role) throws IOException {
        if ("admin".equals(role))       res.sendRedirect(ctx + "/admin");
        else if ("vendor".equals(role)) res.sendRedirect(ctx + "/vendor");
        else                            res.sendRedirect(ctx + "/buyer");
    }
}
