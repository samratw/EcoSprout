package com.ecosprout.controllers;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import com.ecosprout.dao.ContactDAO;

/** Admin page listing every contact-form submission, with soft-delete. */
@WebServlet("/managecontacts")
public class ManageContactsServlet extends HttpServlet {

    private final ContactDAO contactDAO = new ContactDAO();

    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {
        try {
            req.setAttribute("contacts",      contactDAO.getAllContacts());
            req.setAttribute("totalContacts", contactDAO.countContacts());
        } catch (Exception e) {
            req.setAttribute("error", "Could not load contact messages.");
        }
        req.getRequestDispatcher("/WEB-INF/pages/managecontacts.jsp").forward(req, res);
    }

    protected void doPost(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {
        try {
            int id = Integer.parseInt(req.getParameter("contactId"));
            contactDAO.deleteContact(id);   // soft delete
        } catch (Exception e) {
            req.setAttribute("error", "Could not delete the message.");
        }
        res.sendRedirect(req.getContextPath() + "/managecontacts");
    }
}
