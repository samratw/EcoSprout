package com.ecosprout.controllers;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import com.ecosprout.dao.ContactDAO;
import com.ecosprout.model.ContactModel;
import com.ecosprout.util.AppConfig;

/** Contact Us page: shows the form and persists submissions to the DB. */
@WebServlet("/contact")
public class ContactServlet extends HttpServlet {

    private static final String EMAIL_REGEX =
        "^[\\w.+-]+@[\\w.-]+\\.[a-zA-Z]{2,}$";

    private final ContactDAO contactDAO = new ContactDAO();

    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {
        req.setAttribute("contactSubjects", AppConfig.CONTACT_SUBJECTS);
        req.getRequestDispatcher("/WEB-INF/pages/contact.jsp").forward(req, res);
    }

    protected void doPost(HttpServletRequest req, HttpServletResponse res)
            throws IOException, ServletException {

        String name    = trim(req.getParameter("name"));
        String email   = trim(req.getParameter("email"));
        String subject = trim(req.getParameter("subject"));
        String message = trim(req.getParameter("message"));

        // Always push subjects for the dropdown
        req.setAttribute("contactSubjects", AppConfig.CONTACT_SUBJECTS);

        // 1. Required-field check
        if (name.isEmpty() || email.isEmpty() || subject.isEmpty() || message.isEmpty()) {
            forwardWithError(req, res, "All fields are required.",
                             name, email, subject, message);
            return;
        }

        // 2. Length checks (matches DB column sizes)
        if (name.length()    > 100) { forwardWithError(req, res, "Name is too long (max 100 chars).",       name, email, subject, message); return; }
        if (email.length()   > 150) { forwardWithError(req, res, "Email is too long (max 150 chars).",      name, email, subject, message); return; }
        if (subject.length() > 150) { forwardWithError(req, res, "Subject is too long (max 150 chars).",    name, email, subject, message); return; }
        if (message.length() > 5000){ forwardWithError(req, res, "Message is too long (max 5000 chars).",   name, email, subject, message); return; }

        // 3. Format checks
        if (!name.matches("[a-zA-Z .'-]+")) {
            forwardWithError(req, res, "Name must contain letters only.", name, email, subject, message);
            return;
        }
        if (!email.matches(EMAIL_REGEX)) {
            forwardWithError(req, res, "Please enter a valid email address.", name, email, subject, message);
            return;
        }

        // 4. Subject must be one of the configured options (prevents tampering)
        if (!AppConfig.CONTACT_SUBJECTS.contains(subject)) {
            forwardWithError(req, res, "Please choose a valid subject.", name, email, subject, message);
            return;
        }

        // 5. Persist
        try {
            ContactModel c = new ContactModel();
            c.setName(name);
            c.setEmail(email);
            c.setSubject(subject);
            c.setMessage(message);
            contactDAO.addContact(c);

            req.setAttribute("success",
                "Thank you for your message! We will get back to you soon.");
        } catch (Exception e) {
            req.setAttribute("error", "Could not save your message. Please try again.");
            req.setAttribute("namePrev",    name);
            req.setAttribute("emailPrev",   email);
            req.setAttribute("subjectPrev", subject);
            req.setAttribute("messagePrev", message);
        }

        req.getRequestDispatcher("/WEB-INF/pages/contact.jsp").forward(req, res);
    }

    private void forwardWithError(HttpServletRequest req, HttpServletResponse res, String msg,
                                  String name, String email, String subject, String message)
            throws ServletException, IOException {
        req.setAttribute("error",       msg);
        req.setAttribute("namePrev",    name);
        req.setAttribute("emailPrev",   email);
        req.setAttribute("subjectPrev", subject);
        req.setAttribute("messagePrev", message);
        req.getRequestDispatcher("/WEB-INF/pages/contact.jsp").forward(req, res);
    }

    private static String trim(String s) { return s == null ? "" : s.trim(); }
}
