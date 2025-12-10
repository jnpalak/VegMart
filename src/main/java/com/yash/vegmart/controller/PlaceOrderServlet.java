package com.yash.vegmart.controller;

import com.yash.vegmart.entity.CartItem;
import com.yash.vegmart.entity.User;
import com.yash.vegmart.service.OrderService;
import com.yash.vegmart.serviceimpl.OrderServiceImpl;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.Map;

@WebServlet("/PlaceOrderServlet")

public class PlaceOrderServlet extends HttpServlet {

    protected void doPost(HttpServletRequest req, HttpServletResponse resp)

            throws ServletException, IOException {

        HttpSession session = req.getSession();

        User user = (User) session.getAttribute("userObj");

        Map<Integer, CartItem> cart = (Map<Integer, CartItem>) session.getAttribute("cart");

        if (user == null || cart == null || cart.isEmpty()) {

            resp.sendRedirect("login.jsp");

            return;

        }

        String mode = req.getParameter("paymentMode");
        double amount = 0;

        for (CartItem ci : cart.values()) amount += ci.getTotalPrice();

        double shipping = (amount > 500) ? 0 : 40;

        double tax = amount * 0.05;

        double totalAmount = amount + shipping + tax;

        OrderService os = new OrderServiceImpl();

        // ONLINE → payment.jsp first

        if ("ONLINE".equals(mode)) {

            session.setAttribute("amountToPay", totalAmount);

            session.setAttribute("cart", cart);

            resp.sendRedirect("payment.jsp");

            return;

        }

        // COD → save order immediately
        session.setAttribute("lastPaymentMode",mode);
        os.placeOrder(user, cart, "COD", totalAmount);

        session.removeAttribute("cart");

        resp.sendRedirect("thankyou.jsp");

    }

}

