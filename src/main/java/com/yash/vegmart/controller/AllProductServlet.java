package com.yash.vegmart.controller;

import com.yash.vegmart.entity.Vegetable;
import com.yash.vegmart.service.ProductService;
import com.yash.vegmart.serviceimpl.ProductServiceImpl;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

/**
 * Servlet controller for displaying all products/vegetables in the VegMart system.
 * Fetches complete product catalog from ProductService and forwards to JSP view.
 * Used for product listing pages showing entire inventory.
 *
 * Mapped to URL: /allproducts
 *
 * @author Palak Jain
 */
@WebServlet("/allproducts")
public class AllProductServlet extends HttpServlet {

    private ProductService productService = new ProductServiceImpl();

    /**
     * Handles HTTP GET requests to retrieve and display all products.
     * Calls ProductService to fetch complete list of Vegetable entities,
     * sets request attribute for JSP access, and forwards to allProducts.jsp.
     *
     * @param req HttpServletRequest to set request attributes
     * @param resp HttpServletResponse for forwarding to JSP view
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an input/output error occurs
     */
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        // Fetch all products from database
        List<Vegetable> allVeggies = productService.getAllProducts();

        // Set products list as request attribute for JSP
        req.setAttribute("allVeggies", allVeggies);

        // Forward to JSP view for rendering
        req.getRequestDispatcher("allProducts.jsp").forward(req, resp);
    }
}
