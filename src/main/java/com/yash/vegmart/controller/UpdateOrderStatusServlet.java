package com.yash.vegmart.controller;
import com.yash.vegmart.service.OrderService;
import com.yash.vegmart.serviceimpl.OrderServiceImpl;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/UpdateOrderStatusServlet")
public class UpdateOrderStatusServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        try {
            // Getting values from admin_orders.jsp
            int orderId = Integer.parseInt(req.getParameter("orderId"));
            String newStatus = req.getParameter("status");
            OrderService os = new OrderServiceImpl();
            boolean updated = os.updateOrderStatus(orderId, newStatus);
            HttpSession session = req.getSession();
            if (updated) {
                session.setAttribute("msg", "Order status updated successfully!");
            } else {
                session.setAttribute("msg", "Failed to update order status!");
            }
            resp.sendRedirect("admin_orders.jsp");
        } catch (Exception e) {
            e.printStackTrace();
            resp.sendRedirect("error.jsp");
        }

    }

}

