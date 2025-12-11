package com.yash.vegmart.controller;

import com.yash.vegmart.entity.Vegetable;
import com.yash.vegmart.service.ProductService;
import com.yash.vegmart.serviceimpl.ProductServiceImpl;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.File;
import java.io.IOException;

/**
 * Servlet controller for updating product details in the VegMart system.
 *
 * Handles HTTP POST requests with multipart/form-data to update product information,
 * including optional new product image upload.
 * Retrieves the existing product by ID, applies updated details,
 * saves the uploaded image (if any) to the server,
 * then updates the product via ProductService.
 *
 * On successful update, redirects to viewProducts.jsp,
 * otherwise writes an error message in the response.
 *
 * Mapped to URL: /UpdateProductServlet
 *
 * Expected request parameters:
 * - pid: Integer ID of the product to update.
 * - title: New product name.
 * - description: New product description.
 * - price: New product price as double.
 * - stock: New quantity in stock as integer.
 * - image: (optional) Multipart file part containing product image.
 *
 * Author: Palak Jain
 */
@WebServlet("/UpdateProductServlet")
@MultipartConfig
public class UpdateProductServlet extends HttpServlet {

    /**
     * Handles HTTP POST requests to update an existing product.
     *
     * Reads form parameters and file upload from request,
     * updates product details, saves new image if provided,
     * and persists changes via ProductService.
     * Responds with redirection on success or error message on failure.
     *
     * @param request  HttpServletRequest containing product update form fields and file.
     * @param response HttpServletResponse used for redirect or error output.
     * @throws ServletException if a servlet-specific error occurs.
     * @throws IOException      if an I/O error occurs during request processing.
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int pid = Integer.parseInt(request.getParameter("pid"));
        String title = request.getParameter("title");
        String description = request.getParameter("description");
        double price = Double.parseDouble(request.getParameter("price"));
        int stock = Integer.parseInt(request.getParameter("stock"));

        Part filePart = request.getPart("image");

        ProductService ps = new ProductServiceImpl();
        Vegetable oldProduct = ps.getProductById(pid);

        String fileName = oldProduct.getpImage();

        if (filePart != null && filePart.getSize() > 0) {
            fileName = filePart.getSubmittedFileName();

            String path = request.getServletContext().getRealPath("img/Products")
                    + File.separator + fileName;

            filePart.write(path);
        }

        oldProduct.setName(title);
        oldProduct.setDescription(description);
        oldProduct.setPrice(price);
        oldProduct.setQuantityInStock(stock);
        oldProduct.setpImage(fileName);

        boolean updated = ps.updateProductAdmin(oldProduct);

        if (updated) {
            response.sendRedirect("viewProducts.jsp");
        } else {
            response.getWriter().print("Failed to update product!");
        }
    }
}
