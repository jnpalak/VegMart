package com.yash.vegmart.controller;

import com.yash.vegmart.entity.CartItem;
import com.yash.vegmart.entity.Order;
import com.yash.vegmart.entity.Payment;
import com.yash.vegmart.entity.User;
import com.yash.vegmart.service.OrderService;
import com.yash.vegmart.serviceimpl.OrderServiceImpl;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.Map;

@WebServlet("/PaymentSuccessServlet")

public class PaymentSuccessServlet extends HttpServlet {

    @Override

    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        HttpSession session = req.getSession();
        User user = (User) session.getAttribute("userObj");

        @SuppressWarnings("unchecked")
        Map<Integer, CartItem> cart = (Map<Integer, CartItem>) session.getAttribute("cart");
        Double amount = (Double) session.getAttribute("amountToPay");

        String razorpayPaymentId = req.getParameter("razorpay_payment_id");
        if (user == null || cart == null || amount == null || razorpayPaymentId == null) {
            resp.sendRedirect("payment_failed.jsp");
            return;
        }

        OrderService os = new OrderServiceImpl();
        Order orderId = os.placeOrder(user, cart, "ONLINE", amount);
        Payment payment = new Payment();
        payment.setOrder(orderId);
        payment.setUserId(user.getUserId());
        payment.setRazorpayPaymentId(razorpayPaymentId);
        payment.setPaymentMethod("ONLINE");
        payment.setPaymentStatus("SUCCESS");
        payment.setAmount(amount);
        os.savePayment(payment);

        session.setAttribute("lastPaymentMode", "ONLINE");
        session.removeAttribute("cart");
        session.removeAttribute("amountToPay");
        session.removeAttribute("razorpayAmount");

        resp.sendRedirect("thankyou.jsp");
    }

}

