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


@WebServlet("/searchProducts")
public class SearchProductsServlet extends HttpServlet {

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


