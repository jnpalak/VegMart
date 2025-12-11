package com.yash.vegmart.controller;

import com.yash.vegmart.entity.CartItem;
import com.yash.vegmart.utilities.CartUtils;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.Map;

/**
 * Servlet controller for updating the quantity of an item in the shopping cart in the VegMart system.
 *
 * Processes HTTP POST requests containing the vegetable ID and the new quantity.
 * Updates the CartItem quantity in the user's session cart,
 * recalculates the total number of items and total cart value,
 * and updates these values in the session.
 *
 * Redirects back to cart.jsp after the update.
 *
 * Mapped to URL: /UpdateCartServlet
 *
 * Expected request parameters:
 * - vid: Integer ID of the vegetable/cart item to update.
 * - qty: Desired quantity (minimum 1).
 *
 * Session attributes accessed and updated:
 * - cart: Map<Integer, CartItem> representing the current user's shopping cart.
 * - cartCount: Total number of items in the cart, updated after quantity change.
 * - cartTotal: Total price of the cart, updated after quantity change.
 *
 * Does not perform user authentication or detailed input validation beyond minimal checks.
 *
 * Author: Palak Jain
 */
@WebServlet("/UpdateCartServlet")
public class UpdateCartServlet extends HttpServlet {

    /**
     * Handles HTTP POST requests to update the quantity of a cart item.
     *
     * If the parameters are missing or invalid, redirects to cart.jsp without changes.
     * Otherwise, updates the quantity and recalculates cart totals in session.
     *
     * @param req  HttpServletRequest containing parameters "vid" and "qty".
     * @param resp HttpServletResponse redirecting to cart.jsp after processing.
     * @throws ServletException if a servlet-specific error occurs.
     * @throws IOException      if an I/O error occurs during request processing.
     */
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String vidStr = req.getParameter("vid");
        String qtyStr = req.getParameter("qty");

        if (vidStr == null || qtyStr == null) {
            resp.sendRedirect("cart.jsp");
            return;
        }

        int vid = Integer.parseInt(vidStr);
        int qty = Math.max(1, Integer.parseInt(qtyStr));

        HttpSession session = req.getSession();
        @SuppressWarnings("unchecked")
        Map<Integer, CartItem> cart = (Map<Integer, CartItem>) session.getAttribute("cart");

        if (cart != null && cart.containsKey(vid)) {
            CartItem item = cart.get(vid);
            item.setQuantity(qty);
            session.setAttribute("cart", cart);
            session.setAttribute("cartCount", CartUtils.getTotalItems(cart));
            session.setAttribute("cartTotal", CartUtils.getCartTotal(cart));
        }

        resp.sendRedirect("cart.jsp");
    }
}
