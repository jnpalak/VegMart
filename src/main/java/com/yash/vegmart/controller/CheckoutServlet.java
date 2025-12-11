package com.yash.vegmart.controller;

import com.yash.vegmart.entity.CartItem;
import com.yash.vegmart.entity.Vegetable;
import com.yash.vegmart.service.ProductService;
import com.yash.vegmart.serviceimpl.ProductServiceImpl;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.Map;

/**
 * Servlet controller for processing checkout and order completion in the VegMart system.
 * Updates product stock by deducting cart quantities, clears shopping cart session,
 * and redirects to order success page.
 *
 * Mapped to URL: /Checkout
 * Requires active cart session attribute for processing.
 *
 * @author Palak Jain
 */
@WebServlet("/Checkout")
public class CheckoutServlet extends HttpServlet {

    /**
     * Handles HTTP POST requests to complete checkout process.
     * Iterates through cart items, fetches each product, deducts purchased quantity from stock,
     * updates database, clears cart session, and redirects to success page.
     *
     * @param req HttpServletRequest containing cart session data
     * @param resp HttpServletResponse for redirecting to order success page
     * @throws IOException if an input/output error occurs
     */
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {

        HttpSession session = req.getSession();
        @SuppressWarnings("unchecked")
        Map<Integer, CartItem> cart = (Map<Integer, CartItem>) session.getAttribute("cart");

        ProductService ps = new ProductServiceImpl();

        // Process each cart item: update stock and persist changes
        for (CartItem item : cart.values()) {
            Vegetable v = ps.getProductById(item.getVegetableId());

            // Deduct purchased quantity from available stock
            int newStock = v.getQuantityInStock() - item.getQuantity();
            v.setQuantityInStock(newStock);

            // Update product in database
            ps.updateProduct(v);
        }

        // Clear cart after successful processing
        cart.clear();
        session.setAttribute("cart", cart); // Update empty cart in session

        // Redirect to order success page
        resp.sendRedirect("orderSuccess.jsp");
    }
}
