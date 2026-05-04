package com.ecosprout.controllers;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.HashSet;
import java.util.Set;

/**
 * WishlistServlet - Manages a buyer's wishlist using HTTP session (no database needed).
 * Toggles a product in/out of the session-based wishlist.
 */
@WebServlet("/wishlist")
public class WishlistServlet extends HttpServlet {

    @SuppressWarnings("unchecked")
    protected void doPost(HttpServletRequest req, HttpServletResponse res)
            throws IOException, ServletException {
        HttpSession session = req.getSession();

        Set<Integer> wishlist = (Set<Integer>) session.getAttribute("wishlist");
        if (wishlist == null) {
            wishlist = new HashSet<>();
            session.setAttribute("wishlist", wishlist);
        }

        try {
            int productId = Integer.parseInt(req.getParameter("productId"));
            if (wishlist.contains(productId)) {
                wishlist.remove(productId);   // toggle off
            } else {
                wishlist.add(productId);       // toggle on
            }
        } catch (NumberFormatException ignored) {}

        res.sendRedirect(req.getContextPath() + "/buyer");
    }
}
