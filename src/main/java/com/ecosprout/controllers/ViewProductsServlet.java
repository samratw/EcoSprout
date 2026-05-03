package com.ecosprout.controllers;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

import com.ecosprout.dao.ProductDAO;

@WebServlet("/viewproducts")
public class ViewProductsServlet extends HttpServlet {

    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        req.setAttribute("products", new ProductDAO().getAllProducts());
        req.getRequestDispatcher("/WEB-INF/pages/viewproducts.jsp").forward(req,res);
    }
}
