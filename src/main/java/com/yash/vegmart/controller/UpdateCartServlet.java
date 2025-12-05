package com.yash.vegmart.controller;


import com.yash.vegmart.entity.CartItem;
import com.yash.vegmart.utilities.CartUtils;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.Map;

@WebServlet("/UpdateCartServlet")
public class UpdateCartServlet extends HttpServlet {
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