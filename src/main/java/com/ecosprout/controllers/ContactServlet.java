package com.ecosprout.controllers;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import com.ecosprout.util.AppConfig;

/**
 * ContactServlet - Displays the Contact Us page and handles inquiry form submissions.
 * Pushes contact subjects from AppConfig so JSP never hardcodes them.
 */
@WebServlet("/contact")
public class ContactServlet extends HttpServlet {

    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {
        req.setAttribute("contactSubjects", AppConfig.CONTACT_SUBJECTS);
        req.getRequestDispatcher("/WEB-INF/pages/contact.jsp").forward(req, res);
    }

    protected void doPost(HttpServletRequest req, HttpServletResponse res)
            throws IOException, ServletException {
        req.setAttribute("success",         "Thank you for your message! We will get back to you soon.");
        req.setAttribute("contactSubjects", AppConfig.CONTACT_SUBJECTS);
        req.getRequestDispatcher("/WEB-INF/pages/contact.jsp").forward(req, res);
    }
}
