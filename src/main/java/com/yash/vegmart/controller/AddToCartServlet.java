package com.yash.vegmart.controller;

import com.yash.vegmart.entity.Vegetable;
import com.yash.vegmart.entity.CartItem;
import com.yash.vegmart.service.ProductService;
import com.yash.vegmart.serviceimpl.ProductServiceImpl;
import com.yash.vegmart.utilities.CartUtils;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

/**
 * Servlet controller for handling "Add to Cart" functionality in the VegMart system.
 * Processes GET/POST requests to add products to user's session-based shopping cart.
 * Handles quantity updates, stock validation, and cart total calculations using CartUtils.
 *
 * Mapped to URL: /AddToCartServlet
 * Expected parameters: vid (vegetable ID, required), qty (optional, defaults to 1)
 *
 * @author Palak Jain
 */
@WebServlet("/AddToCartServlet")
public class AddToCartServlet extends HttpServlet {

    private ProductService productService = new ProductServiceImpl();

    /**
     * Handles HTTP GET requests to add products to shopping cart.
     * Validates vegetable existence and stock availability, updates session cart,
     * calculates totals using CartUtils, and redirects to referring page.
     *
     * @param req HttpServletRequest containing query parameters:
     *            - vid: Vegetable/Product ID (Integer, required)
     *            - qty: Quantity to add (Integer, optional, min=1, defaults to 1)
     * @param resp HttpServletResponse for redirecting back to product page or products.jsp
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an input/output error occurs
     */
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        // Extract and validate vegetable ID parameter
        String vidStr = req.getParameter("vid");
        String qtyStr = req.getParameter("qty");
        HttpSession session = req.getSession();

        if (vidStr == null) {
            resp.sendRedirect(req.getHeader("referer") != null ?
                    req.getHeader("referer") : "products.jsp");
            return;
        }

        // Parse vegetable ID and quantity (default qty=1, min=1)
        int vid = Integer.parseInt(vidStr);
        int qty = 1;
        try {
            if (qtyStr != null) qty = Math.max(1, Integer.parseInt(qtyStr));
        } catch (Exception ignored) {}

        // Fetch product and validate availability
        Vegetable veg = productService.getProductById(vid);
        if (veg == null) {
            resp.sendRedirect(req.getHeader("referer") != null ?
                    req.getHeader("referer") : "products.jsp");
            return;
        }

        if (veg.getQuantityInStock() <= 0) {
            session.setAttribute("error", "This product is out of stock!");
            resp.sendRedirect("categoryProducts.jsp?pid=" + vidStr);
            return;
        }

        // Get or initialize session cart
        @SuppressWarnings("unchecked")
        Map<Integer, CartItem> cart = (Map<Integer, CartItem>) session.getAttribute("cart");
        if (cart == null) {
            cart = new HashMap<>();
        }

        // Update cart: increment existing item or add new item
        if (cart.containsKey(vid)) {
            CartItem item = cart.get(vid);
            item.setQuantity(item.getQuantity() + qty);
        } else {
            // Use discounted price if available, otherwise original price
            double unitPrice = veg.getPriceAfterDis() != 0 ?
                    veg.getPriceAfterDis() : veg.getPrice();
            CartItem item = new CartItem(
                    veg.getVegetableId(),
                    veg.getName(),
                    veg.getpImage(),
                    unitPrice,
                    qty,
                    veg.getQuantityInStock());
            cart.put(vid, item);
        }

        // Update session attributes with cart summary
        session.setAttribute("cart", cart);
        session.setAttribute("cartCount", CartUtils.getTotalItems(cart));
        session.setAttribute("cartTotal", CartUtils.getCartTotal(cart));

        // Redirect to referring page or fallback
        String referer = req.getHeader("referer");
        resp.sendRedirect(referer != null ? referer : "products.jsp");
    }

    /**
     * Delegates POST requests to doGet for consistent cart addition behavior.
     *
     * @param req HttpServletRequest
     * @param resp HttpServletResponse
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an input/output error occurs
     */
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        doGet(req, resp);
    }
}
