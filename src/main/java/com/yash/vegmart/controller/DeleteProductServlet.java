package com.yash.vegmart.controller;

import com.yash.vegmart.service.ProductService;
import com.yash.vegmart.serviceimpl.ProductServiceImpl;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

/**
 * Servlet controller for deleting products in the VegMart system.
 * Processes HTTP GET requests from admin product management interface to remove products.
 * Deletes product via ProductService and redirects with success/error messages.
 *
 * Mapped to URL: /DeleteProductServlet
 * Expected parameter: pid (product ID)
 *
 * @author Palak Jain
 */
@WebServlet("/DeleteProductServlet")
public class DeleteProductServlet extends HttpServlet {

    private ProductService productService = new ProductServiceImpl();

    /**
     * Handles HTTP GET requests to delete a specific product.
     * Parses product ID from query parameter, deletes product via ProductService,
     * sets session success/error message, and redirects to product listing page.
     *
     * @param req HttpServletRequest containing query parameter:
     *            - pid: Product ID to delete (Integer, required)
     * @param resp HttpServletResponse for redirecting to product management page
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an input/output error occurs
     */
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        // Parse product ID from query parameter
        String pidStr = req.getParameter("pid");

        if (pidStr != null) {
            int pid = Integer.parseInt(pidStr);

            // Delete product and handle response
            boolean success = productService.deleteProduct(pid);
            HttpSession session = req.getSession();

            if (success) {
                session.setAttribute("msg", "Product deleted successfully!");
            } else {
                session.setAttribute("error", "Failed to delete product!");
            }
        }

        // Redirect to product listing page
        resp.sendRedirect("viewProducts.jsp");
    }
}
