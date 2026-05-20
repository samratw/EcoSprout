package com.ecosprout.controllers;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import com.ecosprout.dao.OrderDAO;
import com.ecosprout.model.*;
import com.ecosprout.service.ProductService;

/** Lets a buyer place a purchase order (with delivery location). */
@WebServlet("/placeorder")
public class PlaceOrderServlet extends HttpServlet {

    private final OrderDAO       orderDAO       = new OrderDAO();
    private final ProductService productService = new ProductService();

    protected void doPost(HttpServletRequest req, HttpServletResponse res)
            throws IOException, ServletException {

        UserModel buyer = (UserModel) req.getSession().getAttribute("user");
        if (buyer == null) {
            res.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        // 1. productId must be a positive integer
        int productId = parseInt(req.getParameter("productId"), -1);
        if (productId <= 0) {
            req.getSession().setAttribute("orderError", "Invalid product.");
            res.sendRedirect(req.getContextPath() + "/buyer");
            return;
        }

        // 2. quantity must be a positive integer
        int qty = parseInt(req.getParameter("quantity"), 0);
        if (qty < 1) {
            req.getSession().setAttribute("orderError", "Quantity must be at least 1.");
            res.sendRedirect(req.getContextPath() + "/buyer");
            return;
        }

        // 3. delivery location must be non-empty
        String locationRaw = req.getParameter("deliveryLocation");
        String location = locationRaw == null ? "" : locationRaw.trim();
        if (location.isEmpty()) {
            req.getSession().setAttribute("orderError", "Please enter a delivery location.");
            res.sendRedirect(req.getContextPath() + "/buyer");
            return;
        }
        if (location.length() > 255) {
            req.getSession().setAttribute("orderError", "Delivery location is too long (max 255 chars).");
            res.sendRedirect(req.getContextPath() + "/buyer");
            return;
        }

        try {
            ProductModel p = productService.getProductById(productId);
            if (p == null) {
                req.getSession().setAttribute("orderError", "Product no longer available.");
                res.sendRedirect(req.getContextPath() + "/buyer");
                return;
            }
            // 4. quantity cannot exceed available stock
            if (qty > p.getQuantity()) {
                req.getSession().setAttribute("orderError",
                    "Only " + p.getQuantity() + " " + p.getUnit() + " available in stock.");
                res.sendRedirect(req.getContextPath() + "/buyer");
                return;
            }
            // 5. product must not be out-of-stock status
            if ("out_of_stock".equals(p.getStatus())) {
                req.getSession().setAttribute("orderError", "This product is currently out of stock.");
                res.sendRedirect(req.getContextPath() + "/buyer");
                return;
            }

            // Reduce stock first; the DAO guard fails if another buyer
            // grabbed the last units between the check above and now.
            boolean stockReduced = productService.decreaseStock(productId, qty);
            if (!stockReduced) {
                req.getSession().setAttribute("orderError",
                    "Sorry, " + p.getName() + " just went out of stock.");
                res.sendRedirect(req.getContextPath() + "/buyer");
                return;
            }

            OrderModel order = new OrderModel();
            order.setBuyerId(buyer.getId());
            order.setProductId(productId);
            order.setQuantity(qty);
            order.setTotalPrice(p.getPrice() * qty);
            order.setDeliveryLocation(location);
            orderDAO.placeOrder(order);

            req.getSession().setAttribute("orderSuccess",
                "Order placed successfully for " + p.getName()
                + ". Remaining stock: " + (p.getQuantity() - qty) + " " + p.getUnit() + ".");
        } catch (Exception e) {
            req.getSession().setAttribute("orderError",
                "Could not place order. Please try again.");
        }

        res.sendRedirect(req.getContextPath() + "/buyer");
    }

    private static int parseInt(String s, int fallback) {
        try { return Integer.parseInt(s); } catch (Exception e) { return fallback; }
    }
}
