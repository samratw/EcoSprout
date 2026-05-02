package com.ecosprout.controllers;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import java.io.IOException;
import com.ecosprout.daos.UserDAO;
import com.ecosprout.models.UserModel;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {

    protected void doPost(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        String email = req.getParameter("email");
        String password = req.getParameter("password");

        UserDAO dao = new UserDAO();
        UserModel user = dao.login(email, password);

        if(user != null) {
            HttpSession session = req.getSession();
            session.setAttribute("user", user);

            if("admin".equals(user.getRole())) {
                res.sendRedirect("admin.jsp");
            } else {
                res.sendRedirect("home.jsp");
            }
        } else {
            res.sendRedirect("login.jsp?error=1");
        }
    }
}