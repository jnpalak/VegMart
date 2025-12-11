package com.yash.vegmart.controller;

import com.yash.vegmart.entity.CartItem;
import com.yash.vegmart.utilities.CartUtils;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.Map;

/**
 * Servlet controller for removing an item from the shopping cart in the VegMart system.
 *
 * Processes HTTP POST requests containing the ID of the cart item to remove,
 * updates the cart stored in the user session,
 * recalculates the grand total and item count,
 * and responds with updated cart summary as plain text.
 *
 * Mapped to URL: /RemoveFromCartServlet
 *
 * Expected request parameter:
 * - vid: Integer ID of the vegetable/cart item to remove
 *
 * Session attribute used and updated:
 * - cart: Map<Integer, CartItem> representing the current user's shopping cart
 *
 * Response:
 * - Content-Type: text/plain
 * - Body: a comma-separated string with two values:
 *   - new grand total after removal (double)
 *   - new cart item count (int)
 *
 * This servlet does not perform user authentication or validation of vid beyond presence in cart.
 *
 * Author: Palak Jain
 */
@WebServlet("/RemoveFromCartServlet")
public class RemoveFromCartServlet extends HttpServlet {

    /**
     * Handles HTTP POST requests to remove a specified cart item by its ID.
     * Updates the cart in session and sends back updated total and count.
     *
     * @param req  HttpServletRequest containing parameter "vid" to identify cart item to remove.
     * @param resp HttpServletResponse returning updated cart totals as plain text.
     * @throws ServletException if servlet-specific error occurs.
     * @throws IOException      if an I/O error occurs during request processing.
     */
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        int vid = Integer.parseInt(req.getParameter("vid"));

        HttpSession session = req.getSession();
        @SuppressWarnings("unchecked")
        Map<Integer, CartItem> cart = (Map<Integer, CartItem>) session.getAttribute("cart");

        if (cart != null && cart.containsKey(vid)) {
            cart.remove(vid);
        }

        double newGrandTotal = CartUtils.getCartTotal(cart);
        int newCount = (cart == null) ? 0 : cart.size();

        session.setAttribute("cart", cart);

        resp.setContentType("text/plain");
        resp.getWriter().write(newGrandTotal + "," + newCount);
    }
}
