package com.yash.vegmart.controller;

import com.yash.vegmart.service.ProductService;
import com.yash.vegmart.serviceimpl.ProductServiceImpl;

import javax.servlet.*;
import javax.servlet.http.*;
 import javax.servlet.annotation.*;
 import java.io.IOException;

@WebServlet("/ApplyDiscountServlet")
public class ApplyDiscountServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        try {
            int pid = Integer.parseInt(req.getParameter("pid"));
            int discount = Integer.parseInt(req.getParameter("discount"));

            // validation
            if (discount < 0 || discount > 90) {
                HttpSession session = req.getSession();
                session.setAttribute("msg", "Invalid discount");
                resp.sendRedirect("applyDiscount.jsp?pid=" + pid);
                return;
            }

            ProductService ps = new ProductServiceImpl();
            boolean updated = ps.updateDiscount(pid, discount);

            HttpSession session = req.getSession();

            if (updated) {
                session.setAttribute("msg", "Discount applied successfully!");
                resp.sendRedirect("viewProducts.jsp");
            } else {
                session.setAttribute("msg", "Failed to apply discount");
                resp.sendRedirect("applyDiscount.jsp?pid=" + pid);
            }

        } catch (Exception e) {
            e.printStackTrace();
            resp.sendRedirect("error.jsp");
        }
    }
}