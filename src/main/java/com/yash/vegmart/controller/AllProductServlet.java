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

@WebServlet("/allproducts")
public class AllProductServlet extends HttpServlet
{
    private ProductService productService = new ProductServiceImpl();
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        List<Vegetable> allVeggies=productService.getAllProducts();
        req.setAttribute("allVeggies",allVeggies);
        req.getRequestDispatcher("allProducts.jsp").forward(req,resp);
    }
}
