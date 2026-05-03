package com.ecosprout.filter;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import java.io.IOException;

import com.ecosprout.model.UserModel;

@WebFilter("/*")
public class AuthFilter implements Filter {

    public void doFilter(ServletRequest req, ServletResponse res, FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest request = (HttpServletRequest) req;
        HttpServletResponse response = (HttpServletResponse) res;

        String uri = request.getRequestURI();

        // Allow these without login
        if(uri.contains("login") || uri.contains("register") || uri.contains("images")) {
            chain.doFilter(req, res);
            return;
        }

        HttpSession session = request.getSession(false);

        if(session == null || session.getAttribute("user") == null) {
            response.sendRedirect("login");
            return;
        }

        UserModel user = (UserModel) session.getAttribute("user");

        // ROLE CHECK
        if(uri.contains("admin") && !user.getRole().equals("admin")) {
            response.sendRedirect("login");
            return;
        }

        if(uri.contains("vendor") && !user.getRole().equals("vendor")) {
            response.sendRedirect("login");
            return;
        }

        if(uri.contains("buyer") && !user.getRole().equals("buyer")) {
            response.sendRedirect("login");
            return;
        }

        chain.doFilter(req, res); // allow request
    }
}