package com.yash.vegmart.controller;

import com.yash.vegmart.entity.CartItem;
import com.yash.vegmart.entity.Order;
import com.yash.vegmart.entity.User;
import com.yash.vegmart.service.OrderService;
import com.yash.vegmart.serviceimpl.OrderServiceImpl;
import com.yash.vegmart.utilities.EmailUtil;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.Map;

/**
 * Servlet controller for placing orders in the VegMart system.
 * Processes HTTP POST requests from the checkout page, validates user and cart,
 * calculates order amount (items total, shipping, tax), and either redirects
 * to online payment or immediately creates the order based on selected payment mode.
 *
 * Mapped to URL: /PlaceOrderServlet
 * Requires authenticated user and a non-empty cart in session.
 *
 * Payment modes:
 * - "ONLINE" → redirects to payment.jsp
 * - Other modes (e.g., "COD") → order is placed immediately
 *
 * Session attributes used:
 * - userObj: Logged-in User
 * - cart: Map<Integer, CartItem> representing current cart
 * - amountToPay: Total amount for online payment
 * - lastPaymentMode: Last used payment mode (for thank-you/order pages)
 *
 * Forward/redirect targets:
 * - login.jsp (when not logged in or cart invalid)
 * - payment.jsp (for online payment flow)
 * - thankyou.jsp (for non-online modes)
 *
 * @author Palak Jain
 */
@WebServlet("/PlaceOrderServlet")
public class PlaceOrderServlet extends HttpServlet {

    /**
     * Handles HTTP POST requests to initiate order placement.
     * Validates user and cart session data, calculates item total, shipping, and tax,
     * then either stores amount for online payment and redirects to payment.jsp
     * or directly places the order (for offline modes) and redirects to thankyou.jsp.
     *
     * @param req HttpServletRequest containing:
     *            - paymentMode: Selected payment method (e.g., "ONLINE", "COD")
     * @param resp HttpServletResponse for redirecting to login, payment, or thank-you pages
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an input/output error occurs
     */
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        HttpSession session = req.getSession();
        User user = (User) session.getAttribute("userObj");
        @SuppressWarnings("unchecked")
        Map<Integer, CartItem> cart = (Map<Integer, CartItem>) session.getAttribute("cart");
        if (user == null || cart == null || cart.isEmpty()) {
            resp.sendRedirect("login.jsp");
            return;
        }

        String mode = req.getParameter("paymentMode");
        System.out.println(mode);


        double amount = 0;
        for (CartItem ci : cart.values()) {
            amount += ci.getTotalPrice();
        }


        double shipping = (amount > 500) ? 0 : 50;
        double tax = amount * 0.05;
        double totalAmount = amount + shipping + tax;

        OrderService os = new OrderServiceImpl();


        if ("ONLINE".equals(mode))
        {
            int razorpayAmount=(int) (totalAmount*100);
            session.setAttribute("amountToPay", totalAmount);
            session.setAttribute("razorpayAmount", razorpayAmount);
            session.setAttribute("cart", cart);
            resp.sendRedirect("payment.jsp");
            return;
        }
        session.setAttribute("lastPaymentMode", mode);
        os.placeOrder(user, cart, mode, totalAmount);

        String subject = "VegMart - Order Placed Successfully";
        String message =
                "Hello " + user.getName() + ",\n\n" +
                        "Your order has been placed successfully.\n\n" +
                        "Total Amount: ₹" + totalAmount + "\n" +
                        "Payment Mode: " + mode + "\n\n" +
                        "You will receive another email once your order is delivered.\n\n" +
                        "Thank you for shopping with VegMart!\n\n" +
                        "Regards,\nVegMart Team";

        EmailUtil.sendEmail(user.getEmail(), subject, message);
        session.removeAttribute("cart");
        resp.sendRedirect("thankyou.jsp");
    }
}
