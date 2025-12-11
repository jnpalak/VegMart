package com.yash.vegmart.controller;

import com.yash.vegmart.entity.CartItem;
import com.yash.vegmart.utilities.CartUtils;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.Map;

/**
 * Servlet controller for increasing quantity of cart items in the VegMart system.
 * Processes HTTP POST requests from AJAX cart updates to increment item quantity,
 * updates session cart, and returns JSON-like response with updated values for frontend.
 *
 * Mapped to URL: /IncreaseQuantity
 * Used for dynamic cart quantity adjustment without page reload.
 *
 * @author Palak Jain
 */
@WebServlet("/IncreaseQuantity")
public class IncreaseQuantityServlet extends HttpServlet {

    /**
     * Handles HTTP POST requests to increase cart item quantity by 1.
     * Updates session cart, recalculates item total and grand total using CartUtils,
     * and returns plain text response in format: "newQty,itemTotal,grandTotal" for AJAX parsing.
     *
     * @param req HttpServletRequest containing form parameter:
     *            - vid: Vegetable/Product ID (Integer, required)
     * @param resp HttpServletResponse returning plain text response for AJAX consumption
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an input/output error occurs
     */
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        // Parse vegetable ID from request parameter
        int vid = Integer.parseInt(req.getParameter("vid"));

        HttpSession session = req.getSession();
        @SuppressWarnings("unchecked")
        Map<Integer, CartItem> cart = (Map<Integer, CartItem>) session.getAttribute("cart");

        CartItem item = cart.get(vid);

        // Increase quantity by 1
        item.setQuantity(item.getQuantity() + 1);

        // Update session cart
        session.setAttribute("cart", cart);

        // Prepare AJAX response with updated values
        resp.setContentType("text/plain");
        resp.setCharacterEncoding("UTF-8");

        int newQty = item.getQuantity();
        double newTotal = item.getTotalPrice();
        double grandTotal = CartUtils.getCartTotal(cart);

        // Return comma-separated values: newQty,itemTotal,grandTotal
        resp.getWriter().write(newQty + "," + newTotal + "," + grandTotal);
    }
}
