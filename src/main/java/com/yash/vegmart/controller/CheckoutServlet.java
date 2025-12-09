package com.yash.vegmart.controller;

import com.yash.vegmart.entity.CartItem;
import com.yash.vegmart.entity.Vegetable;
import com.yash.vegmart.service.ProductService;
import com.yash.vegmart.serviceimpl.ProductServiceImpl;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.Map;

@WebServlet("/Checkout")
public class CheckoutServlet extends HttpServlet {

    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {

        HttpSession session = req.getSession();
        Map<Integer, CartItem> cart = (Map<Integer, CartItem>) session.getAttribute("cart");

        ProductService ps = new ProductServiceImpl();

        for (CartItem item : cart.values()) {
            Vegetable v = ps.getProductById(item.getVegetableId());

            int newStock = v.getQuantityInStock() - item.getQuantity();
            v.setQuantityInStock(newStock);

            ps.updateProduct(v);
        }

        cart.clear();
        resp.sendRedirect("orderSuccess.jsp");
    }
}