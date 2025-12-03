package com.yash.vegmart.controller;

import com.yash.vegmart.entity.CartItem;
import com.yash.vegmart.utilities.CartUtils;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.Map;
@WebServlet("/RemoveFromCartServlet")
public class RemoveFromCartServlet extends HttpServlet {

    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        int vid = Integer.parseInt(req.getParameter("vid"));

        HttpSession session = req.getSession();
        Map<Integer, CartItem> cart = (Map<Integer, CartItem>) session.getAttribute("cart");

        if (cart != null && cart.containsKey(vid)) {
            cart.remove(vid);
        }

        double newGrandTotal = CartUtils.getCartTotal(cart);
        int newCount = cart.size();

        session.setAttribute("cart", cart);

        resp.setContentType("text/plain");
        resp.getWriter().write(newGrandTotal + "," + newCount);
    }
}