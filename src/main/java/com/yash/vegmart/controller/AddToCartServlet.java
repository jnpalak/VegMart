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

@WebServlet("/AddToCartServlet")
public class AddToCartServlet extends HttpServlet {

    private ProductService productService = new ProductServiceImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // accept vid (vegetable id) and optional qty
        String vidStr = req.getParameter("vid");
        String qtyStr = req.getParameter("qty");
        HttpSession session = req.getSession();
        if (vidStr == null) {
            resp.sendRedirect(req.getHeader("referer") != null ? req.getHeader("referer") : "products.jsp");
            return;
        }

        int vid = Integer.parseInt(vidStr);
        int qty = 1;
        try { if (qtyStr != null) qty = Math.max(1, Integer.parseInt(qtyStr)); } catch (Exception ignored) {}

        Vegetable veg = productService.getProductById(vid);
        if (veg == null) {
            resp.sendRedirect(req.getHeader("referer") != null ? req.getHeader("referer") : "products.jsp");
            return;
        }
        if (veg.getQuantityInStock() <= 0) {
            session.setAttribute("error", "This product is out of stock!");
            resp.sendRedirect("categoryProducts.jsp?pid=" + vidStr);
            return;
        }

        Map<Integer, CartItem> cart = (Map<Integer, CartItem>) session.getAttribute("cart");
        if (cart == null) {
            cart = new HashMap<>();
        }

        if (cart.containsKey(vid)) {
            CartItem item = cart.get(vid);
            item.setQuantity(item.getQuantity() + qty);
        } else {
            // Use price after discount if you have such field, else use veg.getPrice()
            double unitPrice = veg.getPriceAfterDis() != 0 ? veg.getPriceAfterDis() : veg.getPrice();
            CartItem item = new CartItem(
                    veg.getVegetableId(),
                    veg.getName(),
                    veg.getpImage(),
                    unitPrice,
                    qty,
                    veg.getQuantityInStock());
            cart.put(vid, item);
        }

        session.setAttribute("cart", cart);
        session.setAttribute("cartCount", CartUtils.getTotalItems(cart));
        session.setAttribute("cartTotal", CartUtils.getCartTotal(cart));
        String referer = req.getHeader("referer");
        resp.sendRedirect(referer != null ? referer : "products.jsp");
    }
    
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doGet(req, resp);
    }
}