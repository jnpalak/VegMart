package com.yash.vegmart.controller;
import com.yash.vegmart.service.ProductService;
import com.yash.vegmart.serviceimpl.ProductServiceImpl;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/DeleteProductServlet")
public class DeleteProductServlet extends HttpServlet {

    private ProductService productService = new ProductServiceImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String pidStr = req.getParameter("pid");

        if (pidStr != null) {
            int pid = Integer.parseInt(pidStr);

            boolean success = productService.deleteProduct(pid);

            if (success) {
                HttpSession session = req.getSession();
                session.setAttribute("msg", "Product deleted successfully!");
            } else {
                HttpSession session = req.getSession();
                session.setAttribute("error", "Failed to delete product!");
            }
        }

        resp.sendRedirect("viewProducts.jsp");
    }
}