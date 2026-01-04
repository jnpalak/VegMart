package com.yash.vegmart.controller;

import com.yash.vegmart.entity.Category;
import com.yash.vegmart.entity.Vegetable;
import com.yash.vegmart.service.ProductService;
import com.yash.vegmart.serviceimpl.ProductServiceImpl;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;

/**
 * Servlet controller for handling product creation with image upload in the VegMart system.
 * Processes HTTP POST multipart requests from admin product form to add new vegetables/products.
 * Fetches category by ID, handles file upload to Products/img subdirectory, and saves to database.
 *
 * Mapped to URL: /AddProductServlet
 * Supports multipart file uploads via @MultipartConfig annotation.
 *
 * @author Palak Jain
 */
@MultipartConfig
@WebServlet("/AddProductServlet")
public class AddProductServlet extends HttpServlet {

    private ProductService proService = new ProductServiceImpl();

    /**
     * Handles HTTP POST requests for adding new products/vegetables with image upload.
     * Extracts form parameters, parses numeric values, fetches category by ID,
     * saves product to database, uploads image to Products/img directory,
     * and redirects to admin.jsp with success/error message.
     *
     * @param req HttpServletRequest containing multipart form data:
     *            - proTitle: Product name (String)
     *            - proDescription: Product description (String)
     *            - categoryOption: Category ID (Integer)
     *            - proPrice: Product price (Double)
     *            - proStock: Quantity in stock (Integer)
     *            - proDis: Discount percentage (Integer)
     *            - pPic: Product image file part
     * @param resp HttpServletResponse for redirecting to admin dashboard
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an input/output error occurs during file handling or parameter parsing
     */
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {


        String pName = req.getParameter("proTitle");
        String pDescription = req.getParameter("proDescription");
        int pOption = Integer.parseInt(req.getParameter("categoryOption"));
        double pPrice = Double.parseDouble(req.getParameter("proPrice"));
        int pStock = Integer.parseInt(req.getParameter("proStock"));
        int pDiscount = Integer.parseInt(req.getParameter("proDis"));


        Part part = req.getPart("pPic");
        String fileName = part.getSubmittedFileName();


        Vegetable veg = new Vegetable();
        veg.setName(pName);
        veg.setDescription(pDescription);
        veg.setPrice(pPrice);
        veg.setDiscount(pDiscount);
        veg.setQuantityInStock(pStock);
        veg.setpImage(fileName);


        Category category = proService.getcategoryById(pOption);
        veg.setCategory(category);


        boolean saved = proService.saveProduct(veg);


        String path = req.getRealPath("img") + File.separator + "Products" + File.separator + fileName;
        try (FileOutputStream fos = new FileOutputStream(path);
             InputStream is = part.getInputStream()) {


            byte[] data = new byte[is.available()];
            is.read(data);
            fos.write(data);
        } catch (Exception e) {
            e.printStackTrace();
        }


        HttpSession session = req.getSession();
        if (saved) {
            session.setAttribute("proMsg", "Product Added Successfully!");
        } else {
            session.setAttribute("proMsg", "Failed To Add Product!");
        }
        resp.sendRedirect("admin.jsp");
    }
}
