package com.yash.vegmart.controller;

import com.yash.vegmart.entity.Category;
import com.yash.vegmart.service.CategoryService;
import com.yash.vegmart.serviceimpl.CategoryServiceImpl;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import java.io.IOException;

@WebServlet("/AddCategoryServlet")
public class AddCategoryServlet extends HttpServlet {

    private CategoryService categoryService = new CategoryServiceImpl();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String name = req.getParameter("catTitle");
        String description = req.getParameter("catDescription");

        Category category = new Category();
        category.setCategoryName(name);
        category.setCategoryDescription(description);

        boolean success = categoryService.addCategory(category);

        HttpSession session = req.getSession();

        if (success) {
            session.setAttribute("catMsg", "Category Added Successfully!");


        } else {
            session.setAttribute("catMsg", "Failed To Add Category!");

        }
        resp.sendRedirect("admin.jsp");
    }
}