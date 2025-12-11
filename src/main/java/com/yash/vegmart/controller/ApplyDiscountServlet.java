package com.yash.vegmart.controller;

import com.yash.vegmart.service.ProductService;
import com.yash.vegmart.serviceimpl.ProductServiceImpl;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;

/**
 * Servlet controller for applying discounts to products in the VegMart system.
 * Processes HTTP POST requests from admin discount form to update product discount percentages.
 * Validates discount range (0-90%) and redirects with success/error messages.
 *
 * Mapped to URL: /ApplyDiscountServlet
 * Expected parameters: pid (product ID), discount (percentage)
 *
 * @author Palak Jain
 */
@WebServlet("/ApplyDiscountServlet")
public class ApplyDiscountServlet extends HttpServlet {

    /**
     * Handles HTTP POST requests to apply discount to a specific product.
     * Parses product ID and discount percentage, validates discount range (0-90%),
     * updates product via ProductService, and redirects to appropriate pages with session messages.
     *
     * @param req HttpServletRequest containing form parameters:
     *            - pid: Product ID (Integer, required)
     *            - discount: Discount percentage (Integer, 0-90, required)
     * @param resp HttpServletResponse for redirecting to success/error pages
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an input/output error occurs
     */
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        try {
            // Parse form parameters
            int pid = Integer.parseInt(req.getParameter("pid"));
            int discount = Integer.parseInt(req.getParameter("discount"));

            // Validate discount range (0-90%)
            if (discount < 0 || discount > 90) {
                HttpSession session = req.getSession();
                session.setAttribute("msg", "Invalid discount");
                resp.sendRedirect("applyDiscount.jsp?pid=" + pid);
                return;
            }

            // Update discount via service layer
            ProductService ps = new ProductServiceImpl();
            boolean updated = ps.updateDiscount(pid, discount);

            HttpSession session = req.getSession();

            // Handle success/failure with appropriate redirects
            if (updated) {
                session.setAttribute("msg", "Discount applied successfully!");
                resp.sendRedirect("viewProducts.jsp");
            } else {
                session.setAttribute("msg", "Failed to apply discount");
                resp.sendRedirect("applyDiscount.jsp?pid=" + pid);
            }

        } catch (Exception e) {
            e.printStackTrace();
            resp.sendRedirect("error.jsp");
        }
    }
}
