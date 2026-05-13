package com.ecosprout.controllers;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.*;
import com.ecosprout.model.ProductModel;
import com.ecosprout.service.ProductService;

/** Loads products for buyers with search and wishlist filtering. */
@WebServlet("/buyer")
public class BuyerServlet extends HttpServlet {

    private final ProductService productService = new ProductService();

    @SuppressWarnings("unchecked")
    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        HttpSession session = req.getSession();

        // Session-scoped wishlist (lazy init)
        Set<Integer> wishlist = (Set<Integer>) session.getAttribute("wishlist");
        if (wishlist == null) {
            wishlist = new HashSet<>();
            session.setAttribute("wishlist", wishlist);
        }

        // Build a Map for ${wishlistMap[p.id]} lookups in JSTL
        Map<Integer, Boolean> wishlistMap = new HashMap<>();
        for (Integer id : wishlist) wishlistMap.put(id, Boolean.TRUE);

        String  keyword      = req.getParameter("search");
        boolean showWishlist = "1".equals(req.getParameter("showWishlist"));

        try {
            List<ProductModel> all = productService.searchProducts(keyword);
            List<ProductModel> display = new ArrayList<>();

            if (all != null) {
                for (ProductModel p : all) {
                    if (!showWishlist || wishlist.contains(p.getId())) {
                        display.add(p);
                    }
                }
            }

            req.setAttribute("products",     display);
            req.setAttribute("wishlistMap",  wishlistMap);
            req.setAttribute("wishCount",    wishlist.size());
            req.setAttribute("showWishlist", showWishlist);
            req.setAttribute("search",       keyword);
        } catch (Exception e) {
            req.setAttribute("error",        "Could not load products.");
            req.setAttribute("products",     new ArrayList<ProductModel>());
            req.setAttribute("wishlistMap",  wishlistMap);
            req.setAttribute("wishCount",    wishlist.size());
            req.setAttribute("showWishlist", showWishlist);
        }

        req.getRequestDispatcher("/WEB-INF/pages/buyer.jsp").forward(req, res);
    }
}
