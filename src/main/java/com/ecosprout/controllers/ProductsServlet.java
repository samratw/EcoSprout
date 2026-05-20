package com.ecosprout.controllers;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import com.ecosprout.model.UserModel;
import com.ecosprout.service.ProductService;

/** Public product catalogue - visible to guests and to logged-in users. */
@WebServlet("/products")
public class ProductsServlet extends HttpServlet {

    private final ProductService productService = new ProductService();

    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        // If a logged-in buyer reaches here, send them to the full buyer page.
        HttpSession session = req.getSession(false);
        if (session != null) {
            UserModel user = (UserModel) session.getAttribute("user");
            if (user != null && "buyer".equals(user.getRole())) {
                res.sendRedirect(req.getContextPath() + "/buyer");
                return;
            }
        }

        String keyword = req.getParameter("search");
        try {
            req.setAttribute("products", productService.searchProducts(keyword));
            req.setAttribute("search",   keyword);
        } catch (Exception e) {
            req.setAttribute("error", "Could not load products.");
        }

        req.getRequestDispatcher("/WEB-INF/pages/products.jsp").forward(req, res);
    }
}
