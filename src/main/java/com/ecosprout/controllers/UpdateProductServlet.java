package com.ecosprout.controllers;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import com.ecosprout.model.*;
import com.ecosprout.service.ProductService;
import com.ecosprout.util.AppConfig;

/**
 * UpdateProductServlet - Loads and saves updates for an existing product.
 * Pushes categories, units, and statuses from AppConfig so JSP never hardcodes them.
 */
@WebServlet("/updateproduct")
public class UpdateProductServlet extends HttpServlet {

    private final ProductService productService = new ProductService();

    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {
        try {
            int id = Integer.parseInt(req.getParameter("id"));
            ProductModel p = productService.getProductById(id);
            if (p == null) {
                res.sendRedirect(req.getContextPath() + "/vendor");
                return;
            }
            req.setAttribute("product",        p);
            req.setAttribute("categories",     AppConfig.CATEGORIES);
            req.setAttribute("units",          AppConfig.UNITS);
            req.setAttribute("productStatuses",AppConfig.PRODUCT_STATUSES);
        } catch (Exception e) {
            req.setAttribute("error", "Product not found.");
        }
        req.getRequestDispatcher("/WEB-INF/pages/updateproduct.jsp").forward(req, res);
    }

    protected void doPost(HttpServletRequest req, HttpServletResponse res)
            throws IOException, ServletException {

        UserModel user = (UserModel) req.getSession().getAttribute("user");

        try {
            ProductModel p = new ProductModel();
            p.setId(Integer.parseInt(req.getParameter("id")));
            p.setName(req.getParameter("name"));
            p.setCategory(req.getParameter("category"));
            p.setDescription(req.getParameter("description"));
            p.setPrice(Double.parseDouble(req.getParameter("price")));
            p.setQuantity(Integer.parseInt(req.getParameter("quantity")));
            p.setUnit(req.getParameter("unit"));
            p.setStatus(req.getParameter("status"));

            productService.updateProduct(p);

        } catch (Exception e) {
            req.setAttribute("error",          "Could not update product.");
            req.setAttribute("categories",     AppConfig.CATEGORIES);
            req.setAttribute("units",          AppConfig.UNITS);
            req.setAttribute("productStatuses",AppConfig.PRODUCT_STATUSES);
            req.getRequestDispatcher("/WEB-INF/pages/updateproduct.jsp").forward(req, res);
            return;
        }

        res.sendRedirect(req.getContextPath() + ("admin".equals(user.getRole()) ? "/admin" : "/vendor"));
    }
}
