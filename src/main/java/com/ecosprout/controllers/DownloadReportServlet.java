package com.ecosprout.controllers;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import java.util.Map;
import com.ecosprout.dao.ContactDAO;
import com.ecosprout.dao.OrderDAO;
import com.ecosprout.dao.ProductDAO;
import com.ecosprout.model.ContactModel;
import com.ecosprout.service.UserService;

/** Streams an admin report as a downloadable CSV file. */
@WebServlet("/downloadreport")
public class DownloadReportServlet extends HttpServlet {

    private final ProductDAO  productDAO  = new ProductDAO();
    private final OrderDAO    orderDAO    = new OrderDAO();
    private final ContactDAO  contactDAO  = new ContactDAO();
    private final UserService userService = new UserService();

    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        String type = req.getParameter("type");
        if (type == null) type = "";

        res.setContentType("text/csv");
        res.setCharacterEncoding("UTF-8");
        res.setHeader("Content-Disposition",
                      "attachment; filename=\"ecosprout-" + safe(type) + ".csv\"");

        PrintWriter out = res.getWriter();

        try {
            switch (type) {
                case "products-by-category":
                    writeMap(out, "Category", "Product Count", productDAO.countByCategory());
                    break;
                case "orders-by-status":
                    writeMap(out, "Status", "Order Count", orderDAO.countByStatus());
                    break;
                case "users-by-role":
                    writeMap(out, "Role", "User Count", userService.countByRole());
                    break;
                case "top-sellers":
                    out.println("Product,Units Sold");
                    for (Map<String, Object> row : orderDAO.topSellingProducts(20)) {
                        out.println(csv(String.valueOf(row.get("name"))) + ","
                                  + csv(String.valueOf(row.get("qty"))));
                    }
                    break;
                case "contacts":
                    out.println("ID,Name,Email,Subject,Message,Date");
                    for (ContactModel c : contactDAO.getAllContacts()) {
                        out.println(c.getId() + ","
                                  + csv(c.getName()) + ","
                                  + csv(c.getEmail()) + ","
                                  + csv(c.getSubject()) + ","
                                  + csv(c.getMessage()) + ","
                                  + csv(c.getCreatedAt()));
                    }
                    break;
                default:
                    out.println("Error,Unknown report type");
            }
        } catch (Exception e) {
            out.println("Error,Could not generate the report");
        }
        out.flush();
    }

    /** Write a two-column report from a Map. */
    private void writeMap(PrintWriter out, String col1, String col2,
                          Map<String, Integer> data) {
        out.println(csv(col1) + "," + csv(col2));
        for (Map.Entry<String, Integer> e : data.entrySet()) {
            out.println(csv(e.getKey()) + "," + e.getValue());
        }
    }

    /** Quote a CSV field and escape embedded quotes / commas / newlines. */
    private String csv(String value) {
        if (value == null) return "";
        String v = value.replace("\"", "\"\"");
        return "\"" + v + "\"";
    }

    /** Keep the filename component safe. */
    private String safe(String s) {
        return s.replaceAll("[^a-zA-Z0-9_-]", "");
    }
}
