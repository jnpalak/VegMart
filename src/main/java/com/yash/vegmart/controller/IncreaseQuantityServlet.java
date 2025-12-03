package com.yash.vegmart.controller;
import com.yash.vegmart.entity.CartItem;
import com.yash.vegmart.service.ProductService;
import com.yash.vegmart.serviceimpl.ProductServiceImpl;
import com.yash.vegmart.utilities.CartUtils;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.Map;

@WebServlet("/IncreaseQuantity")
public class IncreaseQuantityServlet extends HttpServlet {

    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        int vid = Integer.parseInt(req.getParameter("vid"));

        HttpSession session = req.getSession();
        Map<Integer, CartItem> cart = (Map<Integer, CartItem>) session.getAttribute("cart");

        CartItem item = cart.get(vid);
        item.setQuantity(item.getQuantity() + 1);

        session.setAttribute("cart", cart);

        resp.setContentType("text/plain");
        resp.setCharacterEncoding("UTF-8");

        int newQty = item.getQuantity();
        double newTotal = item.getTotalPrice();
        double grandTotal= CartUtils.getCartTotal(cart);

        resp.getWriter().write(newQty + "," + newTotal + "," +grandTotal);
    }
}