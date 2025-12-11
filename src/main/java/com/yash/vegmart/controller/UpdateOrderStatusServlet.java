package com.yash.vegmart.controller;

import com.yash.vegmart.service.OrderService;
import com.yash.vegmart.serviceimpl.OrderServiceImpl;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

/**
 * Servlet controller for updating the status of an order in the VegMart system.
 *
 * Handles HTTP POST requests from the admin interface to change the status of an order.
 * Calls OrderService to perform the update and sets a message in session indicating
 * success or failure. Redirects back to admin_orders.jsp after processing.
 *
 * Mapped to URL: /UpdateOrderStatusServlet
 *
 * Expected request parameters:
 * - orderId: Integer ID of the order to update.
 * - status: New status string (e.g., "Pending", "Shipped", "Delivered").
 *
 * Session attributes used:
 * - msg: String message indicating success or failure of the update.
 *
 * On exception, redirects to error.jsp.
 *
 * Author: Palak Jain
 */
@WebServlet("/UpdateOrderStatusServlet")
public class UpdateOrderStatusServlet extends HttpServlet {

    /**
     * Handles HTTP POST requests to update the order status.
     *
     * Extracts orderId and new status from the request,
     * invokes OrderService to update the status,
     * sets appropriate feedback message in the session,
     * then redirects to admin_orders.jsp.
     * On errors, logs the exception and redirects to error.jsp.
     *
     * @param req  HttpServletRequest containing "orderId" and "status" parameters.
     * @param resp HttpServletResponse used to redirect after processing.
     * @throws ServletException if a servlet-specific error occurs.
     * @throws IOException      if an I/O error occurs during request processing.
     */
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        try {
            int orderId = Integer.parseInt(req.getParameter("orderId"));
            String newStatus = req.getParameter("status");

            OrderService os = new OrderServiceImpl();
            boolean updated = os.updateOrderStatus(orderId, newStatus);

            HttpSession session = req.getSession();
            if (updated) {
                session.setAttribute("msg", "Order status updated successfully!");
            } else {
                session.setAttribute("msg", "Failed to update order status!");
            }

            resp.sendRedirect("admin_orders.jsp");
        } catch (Exception e) {
            e.printStackTrace();
            resp.sendRedirect("error.jsp");
        }
    }
}
