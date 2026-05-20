package com.ecosprout.controllers;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import com.ecosprout.dao.OrderDAO;
import com.ecosprout.dao.ReviewDAO;
import com.ecosprout.model.OrderModel;
import com.ecosprout.model.UserModel;
import com.ecosprout.util.AppConfig;

/** Order detail page: any of the three roles may view (when permitted) or
 *  update status (admin and vendor only). */
@WebServlet("/orderdetail")
public class OrderDetailServlet extends HttpServlet {

    private final OrderDAO  orderDAO  = new OrderDAO();
    private final ReviewDAO reviewDAO = new ReviewDAO();

    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {
        loadAndForward(req, res, parseInt(req.getParameter("id"), -1));
    }

    protected void doPost(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        UserModel user = (UserModel) req.getSession().getAttribute("user");
        int orderId = parseInt(req.getParameter("id"), -1);
        String newStatus = req.getParameter("status");

        if (user == null) {
            res.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        try {
            OrderModel order = orderDAO.getById(orderId);
            if (order == null) {
                req.setAttribute("error", "Order not found.");
            } else if (!canEdit(user, order)) {
                req.setAttribute("error", "You are not allowed to update this order.");
            } else if (newStatus == null || !AppConfig.ORDER_STATUSES.containsKey(newStatus)) {
                req.setAttribute("error", "Please select a valid status.");
            } else {
                orderDAO.updateStatus(orderId, newStatus);
                req.setAttribute("success", "Order status updated to "
                                            + AppConfig.ORDER_STATUSES.get(newStatus) + ".");
            }
        } catch (Exception e) {
            req.setAttribute("error", "Could not update order status.");
        }

        loadAndForward(req, res, orderId);
    }

    /** Forward to orderdetail.jsp after running RBAC. */
    private void loadAndForward(HttpServletRequest req, HttpServletResponse res, int orderId)
            throws ServletException, IOException {

        UserModel user = (UserModel) req.getSession().getAttribute("user");
        if (user == null) {
            res.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        try {
            OrderModel order = orderDAO.getById(orderId);

            if (order == null) {
                req.setAttribute("error", "Order not found.");
            } else if (!canView(user, order)) {
                req.setAttribute("error", "You are not allowed to view this order.");
                order = null;
            } else {
                req.setAttribute("order", order);
                req.setAttribute("orderStatuses", AppConfig.ORDER_STATUSES);
                req.setAttribute("canEdit", canEdit(user, order));
                if ("buyer".equals(user.getRole())) {
                    req.setAttribute("alreadyReviewed",
                        reviewDAO.hasReviewed(order.getProductId(), user.getId()));
                }
            }
        } catch (Exception e) {
            req.setAttribute("error", "Could not load this order.");
        }

        req.getRequestDispatcher("/WEB-INF/pages/orderdetail.jsp").forward(req, res);
    }

    /** Buyer may view own order; vendor may view orders for his products; admin sees all. */
    private boolean canView(UserModel u, OrderModel o) {
        String role = u.getRole();
        if ("admin".equals(role))  return true;
        if ("vendor".equals(role)) return u.getId() == o.getVendorId();
        if ("buyer".equals(role))  return u.getId() == o.getBuyerId();
        return false;
    }

    /** Only admin and the order's vendor can change the status. */
    private boolean canEdit(UserModel u, OrderModel o) {
        if ("admin".equals(u.getRole())) return true;
        return "vendor".equals(u.getRole()) && u.getId() == o.getVendorId();
    }

    private static int parseInt(String s, int fallback) {
        try { return Integer.parseInt(s); } catch (Exception e) { return fallback; }
    }
}
