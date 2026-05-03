package com.ecosprout.controllers;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;

import java.io.File;
import java.io.IOException;

import com.ecosprout.dao.ProductDAO;
import com.ecosprout.model.ProductModel;
import com.ecosprout.model.UserModel;

@WebServlet("/addproduct")
@MultipartConfig
public class AddProductServlet extends HttpServlet {

    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {
        req.getRequestDispatcher("/WEB-INF/pages/addproduct.jsp").forward(req,res);
    }

    protected void doPost(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        Part file = req.getPart("image");
        String fileName = System.currentTimeMillis()+"_"+file.getSubmittedFileName();

        String path = getServletContext().getRealPath("") + "images";
        new File(path).mkdir();
        file.write(path + File.separator + fileName);

        UserModel user = (UserModel) req.getSession().getAttribute("user");

        ProductModel p = new ProductModel();
        p.setName(req.getParameter("name"));
        p.setCategory(req.getParameter("category"));
        p.setImage(fileName);
        p.setVendorId(user.getId());

        new ProductDAO().addProduct(p);

        res.sendRedirect(req.getContextPath() + "/viewproducts");
    }
}
