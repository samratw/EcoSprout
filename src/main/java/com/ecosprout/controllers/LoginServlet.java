package com.ecosprout.controllers;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import com.ecosprout.model.UserModel;
import com.ecosprout.service.UserService;

/** Handles login GET (show form) and POST (authenticate). */
@WebServlet("/login")
public class LoginServlet extends HttpServlet {

    private static final String EMAIL_REGEX =
        "^[\\w.+-]+@[\\w.-]+\\.[a-zA-Z]{2,}$";

    private final UserService userService = new UserService();

    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {
        // Already logged in? Skip to dashboard.
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

        String emailRaw    = req.getParameter("email");
        String passwordRaw = req.getParameter("password");

        // Trim only the email; passwords may legitimately contain edge whitespace
        String email    = emailRaw    == null ? "" : emailRaw.trim();
        String password = passwordRaw == null ? "" : passwordRaw;

        // 1. Required field check
        if (email.isEmpty() || password.isEmpty()) {
            req.setAttribute("error", "Both email and password are required.");
            req.setAttribute("emailPrev", email);
            req.getRequestDispatcher("/WEB-INF/pages/login.jsp").forward(req, res);
            return;
        }

        // 2. Email format check
        if (!email.matches(EMAIL_REGEX)) {
            req.setAttribute("error", "Please enter a valid email address.");
            req.setAttribute("emailPrev", email);
            req.getRequestDispatcher("/WEB-INF/pages/login.jsp").forward(req, res);
            return;
        }

        // 3. Minimum password length
        if (password.length() < 6) {
            req.setAttribute("error", "Password must be at least 6 characters.");
            req.setAttribute("emailPrev", email);
            req.getRequestDispatcher("/WEB-INF/pages/login.jsp").forward(req, res);
            return;
        }

        // 4. Authenticate
        try {
            UserModel user = userService.login(email, password);
            if (user != null) {
                HttpSession session = req.getSession();
                session.setAttribute("user", user);
                redirectByRole(res, req.getContextPath(), user.getRole());
            } else {
                req.setAttribute("error", "Invalid credentials or account not yet approved.");
                req.setAttribute("emailPrev", email);
                req.getRequestDispatcher("/WEB-INF/pages/login.jsp").forward(req, res);
            }
        } catch (Exception e) {
            req.setAttribute("error", "A system error occurred. Please try again.");
            req.setAttribute("emailPrev", email);
            req.getRequestDispatcher("/WEB-INF/pages/login.jsp").forward(req, res);
        }
    }

    private void redirectByRole(HttpServletResponse res, String ctx, String role) throws IOException {
        if      ("admin".equals(role))  res.sendRedirect(ctx + "/admin");
        else if ("vendor".equals(role)) res.sendRedirect(ctx + "/vendor");
        else                            res.sendRedirect(ctx + "/buyer");
    }
}
