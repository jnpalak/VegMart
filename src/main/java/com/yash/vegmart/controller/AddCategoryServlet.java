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

/**
 * Servlet controller for handling category creation with image upload in the VegMart system.
 * Processes HTTP POST multipart requests from admin category form to add new categories.
 * Handles file upload to server filesystem and saves category metadata to database.
 *
 * Mapped to URL: /AddCategoryServlet
 * Supports multipart file uploads via @MultipartConfig annotation.
 *
 * @author Palak Jain
 */
@MultipartConfig
@WebServlet("/AddCategoryServlet")
public class AddCategoryServlet extends HttpServlet {

    private CategoryService categoryService = new CategoryServiceImpl();

    /**
     * Handles HTTP POST requests for adding new categories with image upload.
     * Extracts form parameters and file part, saves image to server filesystem under 'img' directory,
     * creates Category entity, persists to database, and redirects to admin.jsp with success/error message.
     *
     * @param req HttpServletRequest containing multipart form data:
     *            - catTitle: Category name (String)
     *            - catDescription: Category description (String)
     *            - cImage: Image file part for category icon
     * @param resp HttpServletResponse for redirecting to admin dashboard
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an input/output error occurs during file handling
     */
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {


        String name = req.getParameter("catTitle");
        String description = req.getParameter("catDescription");
        Part part = req.getPart("cImage");
        String fileName = part.getSubmittedFileName();


        Category category = new Category();
        category.setCategoryName(name);
        category.setCategoryDescription(description);
        category.setcImage(fileName);


        String path = req.getRealPath("img") + File.separator + fileName;
        try (FileOutputStream fos = new FileOutputStream(path);
             InputStream is = part.getInputStream()) {

            // Read and write file data
            byte[] data = new byte[is.available()];
            is.read(data);
            fos.write(data);
        }
        catch (Exception e) {
            e.printStackTrace();
        }


        HttpSession session = req.getSession();
        boolean success = categoryService.addCategory(category);
        if (success) {
            session.setAttribute("catMsg", "Category Added Successfully!");
        } else {
            session.setAttribute("catMsg", "Failed To Add Category!");
        }

        resp.sendRedirect("admin.jsp");
    }
}
