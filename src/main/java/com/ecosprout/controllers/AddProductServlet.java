package com.ecosprout.controllers;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.*;
import jakarta.servlet.http.*;
import java.io.*;
import com.ecosprout.model.*;
import com.ecosprout.service.ProductService;
import com.ecosprout.util.AppConfig;

/**
 * AddProductServlet - Handles adding a new agro product (with image upload).
 * Pushes categories, units from AppConfig so JSP never hardcodes lists.
 */
@WebServlet("/addproduct")
@MultipartConfig(maxFileSize = 5 * 1024 * 1024)
public class AddProductServlet extends HttpServlet {

    private final ProductService productService = new ProductService();

    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {
        // Push all dropdown data from backend
        req.setAttribute("categories",      AppConfig.CATEGORIES);
        req.setAttribute("units",           AppConfig.UNITS);
        req.getRequestDispatcher("/WEB-INF/pages/addproduct.jsp").forward(req, res);
    }

    protected void doPost(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        UserModel user = (UserModel) req.getSession().getAttribute("user");

        try {
            Part filePart = req.getPart("image");
            String fileName = null;

            if (filePart != null && filePart.getSize() > 0) {
                fileName = System.currentTimeMillis() + "_" + filePart.getSubmittedFileName();
                String uploadPath = getServletContext().getRealPath("") + File.separator + "images";
                new File(uploadPath).mkdirs();
                filePart.write(uploadPath + File.separator + fileName);
            }

            ProductModel p = new ProductModel();
            p.setName(req.getParameter("name"));
            p.setCategory(req.getParameter("category"));
            p.setDescription(req.getParameter("description"));
            p.setPrice(Double.parseDouble(req.getParameter("price")));
            p.setQuantity(Integer.parseInt(req.getParameter("quantity")));
            p.setUnit(req.getParameter("unit"));
            p.setImage(fileName);
            p.setVendorId(user.getId());
            p.setStatus("available");

            String error = productService.addProduct(p);
            if (error != null) {
                req.setAttribute("error",      error);
                req.setAttribute("categories", AppConfig.CATEGORIES);
                req.setAttribute("units",      AppConfig.UNITS);
                req.getRequestDispatcher("/WEB-INF/pages/addproduct.jsp").forward(req, res);
                return;
            }

            res.sendRedirect(req.getContextPath() + ("admin".equals(user.getRole()) ? "/admin" : "/vendor"));

        } catch (NumberFormatException e) {
            req.setAttribute("error",      "Price and quantity must be valid numbers.");
            req.setAttribute("categories", AppConfig.CATEGORIES);
            req.setAttribute("units",      AppConfig.UNITS);
            req.getRequestDispatcher("/WEB-INF/pages/addproduct.jsp").forward(req, res);
        } catch (Exception e) {
            req.setAttribute("error",      "An error occurred while adding the product.");
            req.setAttribute("categories", AppConfig.CATEGORIES);
            req.setAttribute("units",      AppConfig.UNITS);
            req.getRequestDispatcher("/WEB-INF/pages/addproduct.jsp").forward(req, res);
        }
    }
}
