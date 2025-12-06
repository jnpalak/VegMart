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

@WebServlet("/categoryProducts")
public class  CategoryProductsServlet extends HttpServlet {

    private ProductService productService = new ProductServiceImpl();
    private CategoryService categoryService = new CategoryServiceImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        int catId = Integer.parseInt(req.getParameter("catId"));

        // get category name
        Category currentCategory = productService.getcategoryById(catId);
        List<Vegetable> vegList = productService.getProductsByCategory(catId);
        List<Category> allCategories = categoryService.getCategory();

        req.setAttribute("category", currentCategory);
        req.setAttribute("products", vegList);
        req.setAttribute("allCategories", allCategories);

        req.getRequestDispatcher("categoryProducts.jsp").forward(req, resp);
    }
}