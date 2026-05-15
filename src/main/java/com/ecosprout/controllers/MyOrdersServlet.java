package com.ecosprout.controllers;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.*;
import com.ecosprout.dao.OrderDAO;
import com.ecosprout.dao.ReviewDAO;
import com.ecosprout.model.OrderModel;
import com.ecosprout.model.UserModel;

/** Shows a buyer's order history. Each row exposes a Review form. */
@WebServlet("/myorders")
public class MyOrdersServlet extends HttpServlet {

    private final OrderDAO  orderDAO  = new OrderDAO();
    private final ReviewDAO reviewDAO = new ReviewDAO();

    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        UserModel user = (UserModel) req.getSession().getAttribute("user");
        if (user == null) {
            res.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        try {
            List<OrderModel> orders = orderDAO.getOrdersByBuyer(user.getId());
            double grandTotal = 0;
            Map<Integer, Boolean> reviewedMap = new HashMap<>();
            for (OrderModel o : orders) {
                grandTotal += o.getTotalPrice();
                // Skip the DB call if we already checked this productId.
                if (!reviewedMap.containsKey(o.getProductId())) {
                    reviewedMap.put(o.getProductId(),
                                    reviewDAO.hasReviewed(o.getProductId(), user.getId()));
                }
            }

            req.setAttribute("orders",      orders);
            req.setAttribute("orderCount",  orders.size());
            req.setAttribute("grandTotal",  grandTotal);
            req.setAttribute("reviewedMap", reviewedMap);
        } catch (Exception e) {
            req.setAttribute("error", "Could not load your orders.");
        }

        req.getRequestDispatcher("/WEB-INF/pages/myorders.jsp").forward(req, res);
    }
}
