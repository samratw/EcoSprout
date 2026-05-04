package com.ecosprout.controllers;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import com.ecosprout.dao.OrderDAO;
import com.ecosprout.model.*;
import com.ecosprout.service.ProductService;

/**
 * PlaceOrderServlet - Allows a buyer to place a purchase order for a product.
 */
@WebServlet("/placeorder")
public class PlaceOrderServlet extends HttpServlet {

    private final OrderDAO       orderDAO       = new OrderDAO();
    private final ProductService productService = new ProductService();

    protected void doPost(HttpServletRequest req, HttpServletResponse res)
            throws IOException, ServletException {

        UserModel buyer = (UserModel) req.getSession().getAttribute("user");

        try {
            int productId = Integer.parseInt(req.getParameter("productId"));
            int qty       = Integer.parseInt(req.getParameter("quantity"));

            ProductModel p = productService.getProductById(productId);
            if (p == null || qty < 1) {
                res.sendRedirect(req.getContextPath() + "/buyer");
                return;
            }

            OrderModel order = new OrderModel();
            order.setBuyerId(buyer.getId());
            order.setProductId(productId);
            order.setQuantity(qty);
            order.setTotalPrice(p.getPrice() * qty);
            orderDAO.placeOrder(order);

            req.getSession().setAttribute("orderSuccess", "Order placed successfully for " + p.getName() + "!");

        } catch (Exception e) {
            req.getSession().setAttribute("orderError", "Could not place order. Please try again.");
        }

        res.sendRedirect(req.getContextPath() + "/buyer");
    }
}
