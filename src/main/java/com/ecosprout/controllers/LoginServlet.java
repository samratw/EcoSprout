package com.ecosprout.controllers;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

import com.ecosprout.dao.UserDAO;
import com.ecosprout.model.UserModel;
import com.ecosprout.util.PasswordUtil;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {

    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {
        req.getRequestDispatcher("/WEB-INF/pages/login.jsp").forward(req,res);
    }

    protected void doPost(HttpServletRequest req, HttpServletResponse res)
            throws IOException, ServletException {

        String email = req.getParameter("email");
        String password = PasswordUtil.encrypt(req.getParameter("password"));

        UserModel user = new UserDAO().login(email, password);

        if(user != null) {
            HttpSession session = req.getSession();
            session.setAttribute("user", user);

            Cookie c = new Cookie("email", email);
            c.setMaxAge(86400);
            res.addCookie(c);

            if("admin".equals(user.getRole())) res.sendRedirect(req.getContextPath() + "/admin");
            else if("vendor".equals(user.getRole())) res.sendRedirect(req.getContextPath() + "/vendor");
            else res.sendRedirect(req.getContextPath() + "/buyer");

        } else {
            req.setAttribute("error", "Invalid login");
            req.getRequestDispatcher("/WEB-INF/pages/login.jsp").forward(req,res);
        }
    }
}
