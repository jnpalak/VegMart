package com.yash.vegmart.controller;

import com.yash.vegmart.entity.Category;
import com.yash.vegmart.service.CategoryService;
import com.yash.vegmart.serviceimpl.CategoryServiceImpl;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;

@MultipartConfig
@WebServlet("/AddCategoryServlet")
public class AddCategoryServlet extends HttpServlet {

    private CategoryService categoryService = new CategoryServiceImpl();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String name = req.getParameter("catTitle");
        String description = req.getParameter("catDescription");
        Part part = req.getPart("cImage");

        String fileName=part.getSubmittedFileName();
        Category category = new Category();
        category.setCategoryName(name);
        category.setCategoryDescription(description);
        category.setcImage(fileName);

        String path= req.getRealPath("img") + File.separator +fileName;

        try {
            //uplaoding file
            FileOutputStream fos = new FileOutputStream(path);
            InputStream is = part.getInputStream();

            //reading data
            byte[] data = new byte[is.available()];
            is.read(data);
            //Writing the data
            fos.write(data);
            fos.close();
        }
        catch(Exception e)
        {
            e.printStackTrace();
        }
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