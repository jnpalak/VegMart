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
 * Servlet controller for searching products in the VegMart system.
 *
 * Handles HTTP GET requests for product search using a keyword query parameter.
 * Uses the ProductService to search for matching vegetables,
 * sets the search results and keyword as request attributes,
 * and forwards to the search results JSP page for display.
 *
 * Mapped to URL: /searchProducts
 *
 * Expected request parameter:
 * - keyword: String keyword to search for matching vegetables.
 *
 * Request attributes set:
 * - searchResult: List of Vegetable objects matching the search.
 * - keyword: The original search keyword string.
 *
 * Forward target:
 * - search_results.jsp for displaying search results to the user.
 *
 * Does not modify session or user state.
 *
 * Author: Palak Jain
 */
@WebServlet("/searchProducts")
public class SearchProductsServlet extends HttpServlet {

    /**
     * Handles HTTP GET requests to search vegetables by keyword.
     *
     * @param req  HttpServletRequest containing the "keyword" search parameter.
     * @param resp HttpServletResponse for forwarding results page.
     * @throws ServletException if a servlet-specific error occurs.
     * @throws IOException      if an I/O error occurs during request processing.
     */
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String keyword = req.getParameter("keyword");

        ProductService ps = new ProductServiceImpl();
        List<Vegetable> list = ps.searchVegetables(keyword);

        req.setAttribute("searchResult", list);
        req.setAttribute("keyword", keyword);

        req.getRequestDispatcher("search_results.jsp").forward(req, resp);
    }
}
