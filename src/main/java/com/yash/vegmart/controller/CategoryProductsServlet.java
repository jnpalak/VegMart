package com.yash.vegmart.controller;

import com.yash.vegmart.entity.Category;
import com.yash.vegmart.entity.Vegetable;
import com.yash.vegmart.service.CategoryService;
import com.yash.vegmart.service.ProductService;
import com.yash.vegmart.serviceimpl.CategoryServiceImpl;
import com.yash.vegmart.serviceimpl.ProductServiceImpl;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

/**
 * Servlet controller for displaying products filtered by category in the VegMart system.
 * Fetches current category details, products belonging to that category, and all categories
 * for navigation sidebar, then forwards to categoryProducts.jsp view.
 *
 * Mapped to URL: /categoryProducts
 * Expected parameter: catId (category ID, required)
 *
 * @author Palak Jain
 */
@WebServlet("/categoryProducts")
public class CategoryProductsServlet extends HttpServlet {

    private ProductService productService = new ProductServiceImpl();
    private CategoryService categoryService = new CategoryServiceImpl();

    /**
     * Handles HTTP GET requests to display products for a specific category.
     * Parses category ID from query parameter, fetches category details, category-specific products,
     * and all categories for navigation, then forwards to JSP view with request attributes.
     *
     * @param req HttpServletRequest containing query parameter:
     *            - catId: Category ID (Integer, required)
     * @param resp HttpServletResponse for forwarding to JSP view
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an input/output error occurs
     */
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        // Parse category ID from request parameter
        int catId = Integer.parseInt(req.getParameter("catId"));

        // Fetch current category details, products in category, and all categories for navigation
        Category currentCategory = productService.getcategoryById(catId);
        List<Vegetable> vegList = productService.getProductsByCategory(catId);
        List<Category> allCategories = categoryService.getCategory();

        // Set request attributes for JSP access
        req.setAttribute("category", currentCategory);
        req.setAttribute("products", vegList);
        req.setAttribute("allCategories", allCategories);

        // Forward to category products view
        req.getRequestDispatcher("categoryProducts.jsp").forward(req, resp);
    }
}
