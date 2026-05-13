package com.ecosprout.filter;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import java.io.IOException;
import java.util.Arrays;
import java.util.HashSet;
import java.util.Set;
import com.ecosprout.model.UserModel;

/** Enforces authentication and role-based access on every request. */
@WebFilter("/*")
public class AuthFilter implements Filter {

    // Public pages, static folders, and static file suffixes.
    private static final Set<String> PUBLIC_PATHS = new HashSet<>(Arrays.asList(
        "/", "/index.jsp", "/login", "/register", "/about", "/contact"
    ));
    private static final String[] PUBLIC_PREFIXES = { "/css/", "/js/", "/images/" };
    private static final String[] STATIC_SUFFIXES = {
        ".css", ".js", ".png", ".jpg", ".jpeg", ".gif", ".ico", ".svg"
    };

    @Override
    public void doFilter(ServletRequest req, ServletResponse res, FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest  request  = (HttpServletRequest) req;
        HttpServletResponse response = (HttpServletResponse) res;

        String ctx  = request.getContextPath();
        String uri  = request.getRequestURI();
        String path = uri.startsWith(ctx) ? uri.substring(ctx.length()) : uri;
        if (path.isEmpty()) path = "/";

        // Static resources & public pages
        for (String prefix : PUBLIC_PREFIXES) {
            if (path.startsWith(prefix)) { chain.doFilter(req, res); return; }
        }
        for (String suffix : STATIC_SUFFIXES) {
            if (path.endsWith(suffix)) { chain.doFilter(req, res); return; }
        }
        if (PUBLIC_PATHS.contains(path)) { chain.doFilter(req, res); return; }

        // Authentication required
        HttpSession session = request.getSession(false);
        UserModel user = (session != null) ? (UserModel) session.getAttribute("user") : null;
        if (user == null) { response.sendRedirect(ctx + "/login"); return; }

        // Role-based access control
        String role = user.getRole();
        if (path.equals("/admin") || path.equals("/manageusers")
                || path.equals("/viewproducts") || path.equals("/reports")) {
            if (!"admin".equals(role)) { redirectToDashboard(response, ctx, role); return; }
        }
        else if (path.equals("/vendor")) {
            if (!"vendor".equals(role)) { redirectToDashboard(response, ctx, role); return; }
        }
        else if (path.equals("/buyer") || path.equals("/placeorder")
                || path.equals("/wishlist") || path.equals("/myorders")) {
            if (!"buyer".equals(role)) { redirectToDashboard(response, ctx, role); return; }
        }
        else if (path.equals("/addproduct") || path.equals("/updateproduct")
                || path.equals("/deleteproduct")) {
            if (!"vendor".equals(role) && !"admin".equals(role)) {
                redirectToDashboard(response, ctx, role); return;
            }
        }
        // /profile and /changepassword require any logged-in user (already passed auth)

        chain.doFilter(req, res);
    }

    /** Redirect to the dashboard matching the user's role. */
    private void redirectToDashboard(HttpServletResponse res, String ctx, String role) throws IOException {
        if      ("admin".equals(role))  res.sendRedirect(ctx + "/admin");
        else if ("vendor".equals(role)) res.sendRedirect(ctx + "/vendor");
        else if ("buyer".equals(role))  res.sendRedirect(ctx + "/buyer");
        else                            res.sendRedirect(ctx + "/login");
    }

    @Override public void init(FilterConfig config) { }
    @Override public void destroy() { }
}
