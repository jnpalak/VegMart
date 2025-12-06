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

@WebServlet("/UpdateProductServlet")
@MultipartConfig
public class UpdateProductServlet extends HttpServlet {

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