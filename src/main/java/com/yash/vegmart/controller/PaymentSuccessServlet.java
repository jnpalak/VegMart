package com.yash.vegmart.controller;

import com.yash.vegmart.entity.CartItem;
import com.yash.vegmart.entity.User;
import com.yash.vegmart.service.OrderService;
import com.yash.vegmart.serviceimpl.OrderServiceImpl;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.Map;

/**
 * Servlet controller for handling successful payment completion in the VegMart system.
 * Processes HTTP POST requests after payment gateway callback to place final order,
 * clear cart, and redirect to thank you page.
 *
 * Mapped to URL: /PaymentSuccessServlet
 * Requires active user session, cart, and payment amount attributes.
 *
 * @author Palak Jain
 */
@WebServlet("/PaymentSuccessServlet")
public class PaymentSuccessServlet extends HttpServlet {

    /**
     * Handles HTTP POST requests from payment gateway success callback.
     * Validates required session attributes (user, cart, amount), places order via OrderService
     * with "ONLINE" payment mode, clears cart and payment data, and redirects to thank you page.
     *
     * @param req HttpServletRequest from payment gateway callback
     * @param resp HttpServletResponse for redirecting to thank you page
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an input/output error occurs
     */
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        HttpSession session = req.getSession();

        // Retrieve required session attributes
        User user = (User) session.getAttribute("userObj");
        @SuppressWarnings("unchecked")
        Map<Integer, CartItem> cart = (Map<Integer, CartItem>) session.getAttribute("cart");
        Double amount = (Double) session.getAttribute("amountToPay");

        // Validate all required session data exists
        if (user == null || cart == null || amount == null) {
            resp.sendRedirect("index.jsp");
            return;
        }

        // Place final order via OrderService
        OrderService os = new OrderServiceImpl();
        os.placeOrder(user, cart, "ONLINE", amount);

        // Track payment mode for order history
        session.setAttribute("lastPaymentMode", "ONLINE");

        // Clear cart and payment session data after successful order
        session.removeAttribute("cart");
        session.removeAttribute("amountToPay");

        // Redirect to thank you page
        resp.sendRedirect("thankyou.jsp");
    }
}

