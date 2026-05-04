package com.ecosprout.controllers;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import com.ecosprout.model.UserModel;
import com.ecosprout.service.UserService;
import com.ecosprout.util.AppConfig;

/**
 * RegisterServlet - Handles user registration with full validation.
 * Pushes role options from AppConfig so the JSP never hardcodes them.
 */
@WebServlet("/register")
public class RegisterServlet extends HttpServlet {

    private final UserService userService = new UserService();

    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {
        req.setAttribute("roles", AppConfig.REGISTER_ROLES);
        req.getRequestDispatcher("/WEB-INF/pages/register.jsp").forward(req, res);
    }

    protected void doPost(HttpServletRequest req, HttpServletResponse res)
            throws IOException, ServletException {

        String name     = req.getParameter("name");
        String email    = req.getParameter("email");
        String password = req.getParameter("password");
        String phone    = req.getParameter("phone");
        String role     = req.getParameter("role");

        UserModel u = new UserModel();
        u.setName    (name     != null ? name.trim()     : "");
        u.setEmail   (email    != null ? email.trim()    : "");
        u.setPassword(password != null ? password        : "");
        u.setPhone   (phone    != null ? phone.trim()    : "");
        u.setRole    (role     != null ? role            : "");

        try {
            String error = userService.register(u);
            if (error != null) {
                req.setAttribute("error",    error);
                req.setAttribute("formData", u);
                req.setAttribute("roles",    AppConfig.REGISTER_ROLES);
                req.getRequestDispatcher("/WEB-INF/pages/register.jsp").forward(req, res);
            } else {
                req.setAttribute("success", "Registration successful! Your account is pending admin approval.");
                req.getRequestDispatcher("/WEB-INF/pages/login.jsp").forward(req, res);
            }
        } catch (Exception e) {
            req.setAttribute("error", "A system error occurred. Please try again.");
            req.setAttribute("roles", AppConfig.REGISTER_ROLES);
            req.getRequestDispatcher("/WEB-INF/pages/register.jsp").forward(req, res);
        }
    }
}
