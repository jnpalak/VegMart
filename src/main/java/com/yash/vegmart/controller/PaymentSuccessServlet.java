package com.yash.vegmart.controller;
import com.yash.vegmart.entity.CartItem;
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
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        HttpSession session = req.getSession();
        User user = (User) session.getAttribute("userObj");
        Map<Integer, CartItem> cart = (Map<Integer, CartItem>) session.getAttribute("cart");
        Double amount = (Double) session.getAttribute("amountToPay");

        if (user == null || cart == null || amount == null) {
            resp.sendRedirect("index.jsp");
            return;
        }
        OrderService os = new OrderServiceImpl();
        os.placeOrder(user, cart, "ONLINE", amount);
        session.setAttribute("lastPaymentMode","ONLINE");
        // clear cart

        session.removeAttribute("cart");
        session.removeAttribute("amountToPay");
        resp.sendRedirect("thankyou.jsp");
    }
}

