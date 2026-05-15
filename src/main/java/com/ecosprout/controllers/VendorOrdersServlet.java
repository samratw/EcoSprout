package com.ecosprout.controllers;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;
import com.ecosprout.dao.OrderDAO;
import com.ecosprout.model.OrderModel;
import com.ecosprout.model.UserModel;

/** Lists orders placed against a vendor's products. */
@WebServlet("/vendororders")
public class VendorOrdersServlet extends HttpServlet {

    private final OrderDAO orderDAO = new OrderDAO();

    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        UserModel vendor = (UserModel) req.getSession().getAttribute("user");
        if (vendor == null) {
            res.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        try {
            List<OrderModel> orders = orderDAO.getOrdersByVendor(vendor.getId());
            double total = 0;
            for (OrderModel o : orders) total += o.getTotalPrice();

            req.setAttribute("orders",     orders);
            req.setAttribute("orderCount", orders.size());
            req.setAttribute("revenue",    total);
        } catch (Exception e) {
            req.setAttribute("error", "Could not load orders.");
        }

        req.getRequestDispatcher("/WEB-INF/pages/vendororders.jsp").forward(req, res);
    }
}
