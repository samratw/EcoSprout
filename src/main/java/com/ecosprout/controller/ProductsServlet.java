package com.ecosprout.controller;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.WebServlet;
import java.io.IOException;

@WebServlet("/products")
public class ProductsServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Session check (important)
        HttpSession session = request.getSession(false);

        

        // Forward to protected JSP
        RequestDispatcher rd = request.getRequestDispatcher("/WEB-INF/pages/products.jsp");
        rd.forward(request, response);
    }
}