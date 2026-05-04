package com.ecosprout.filter;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import java.io.IOException;
import com.ecosprout.model.UserModel;

/**
 * AuthFilter - Intercepts all requests to enforce authentication and role-based access control.
 * Unauthenticated users are redirected to the login page.
 * Users accessing pages outside their role are redirected to their dashboard.
 */
@WebFilter("/*")
public class AuthFilter implements Filter {

    // Paths that are accessible without a login session
    private static final String[] PUBLIC_PATHS = { "/", "/login", "/register", "/about", "/contact" };

    public void doFilter(ServletRequest req, ServletResponse res, FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest  request  = (HttpServletRequest) req;
        HttpServletResponse response = (HttpServletResponse) res;

        String uri = request.getRequestURI();

        // Allow static resources (CSS, images, JS)
        if (uri.endsWith(".css") || uri.endsWith(".js") || uri.endsWith(".png")
                || uri.endsWith(".jpg") || uri.endsWith(".jpeg") || uri.endsWith(".ico")
                || uri.contains("/images/")) {
            chain.doFilter(req, res);
            return;
        }

        // Allow public pages without authentication
        for (String path : PUBLIC_PATHS) {
            if (uri.contains(path)) {
                chain.doFilter(req, res);
                return;
            }
        }

        // Redirect root "/" to login
        String contextPath = request.getContextPath();
        if (uri.equals(contextPath + "/") || uri.equals(contextPath)) {
            response.sendRedirect(contextPath + "/login");
            return;
        }

        // Check session
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(contextPath + "/login");
            return;
        }

        UserModel user = (UserModel) session.getAttribute("user");
        String role = user.getRole();

        // Role-based access control
        if (uri.contains("/admin") && !"admin".equals(role)) {
            redirectToDashboard(response, contextPath, role);
            return;
        }
        if ((uri.contains("/vendor") || uri.contains("/addproduct") || uri.contains("/updateproduct") || uri.contains("/deleteproduct"))
                && !"vendor".equals(role) && !"admin".equals(role)) {
            redirectToDashboard(response, contextPath, role);
            return;
        }
        if (uri.contains("/buyer") && !"buyer".equals(role)) {
            redirectToDashboard(response, contextPath, role);
            return;
        }

        chain.doFilter(req, res);
    }

    /** Redirects user to the appropriate dashboard based on role. */
    private void redirectToDashboard(HttpServletResponse response, String ctx, String role) throws IOException {
        if ("admin".equals(role))       response.sendRedirect(ctx + "/admin");
        else if ("vendor".equals(role)) response.sendRedirect(ctx + "/vendor");
        else                            response.sendRedirect(ctx + "/buyer");
    }

    public void init(FilterConfig config) {}
    public void destroy() {}
}
