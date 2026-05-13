package com.ecosprout.controllers;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import com.ecosprout.model.UserModel;
import com.ecosprout.service.UserService;

/** Shows and updates the logged-in user's profile (name, phone, password). */
@WebServlet("/profile")
public class ProfileServlet extends HttpServlet {

    private final UserService userService = new UserService();

    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {
        forwardWithUser(req, res);
    }

    protected void doPost(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        UserModel sessionUser = (UserModel) req.getSession().getAttribute("user");
        if (sessionUser == null) {
            res.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        String action = req.getParameter("action");
        try {
            if ("profile".equals(action)) {
                String name  = req.getParameter("name");
                String phone = req.getParameter("phone");
                String err = userService.updateProfile(sessionUser.getId(), name, phone);
                if (err != null) {
                    req.setAttribute("error", err);
                } else {
                    sessionUser.setName(name.trim());
                    sessionUser.setPhone(phone.trim());
                    req.getSession().setAttribute("user", sessionUser);
                    req.setAttribute("success", "Profile updated successfully.");
                }
            } else if ("password".equals(action)) {
                String current = req.getParameter("currentPassword");
                String fresh   = req.getParameter("newPassword");
                String confirm = req.getParameter("confirmPassword");
                String err = userService.changePassword(sessionUser.getId(), current, fresh, confirm);
                if (err != null) {
                    req.setAttribute("error", err);
                } else {
                    req.setAttribute("success", "Password changed successfully.");
                }
            }
        } catch (Exception e) {
            req.setAttribute("error", "A system error occurred. Please try again.");
        }

        forwardWithUser(req, res);
    }

    /** Forwards to profile.jsp with the freshest user record from the DB. */
    private void forwardWithUser(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {
        UserModel sessionUser = (UserModel) req.getSession().getAttribute("user");
        if (sessionUser == null) {
            res.sendRedirect(req.getContextPath() + "/login");
            return;
        }
        try {
            UserModel fresh = userService.getById(sessionUser.getId());
            if (fresh != null) req.setAttribute("profile", fresh);
            else               req.setAttribute("profile", sessionUser);
        } catch (Exception e) {
            req.setAttribute("profile", sessionUser);
        }
        req.getRequestDispatcher("/WEB-INF/pages/profile.jsp").forward(req, res);
    }
}
