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

@MultipartConfig
@WebServlet("/AddProductServlet")
public class AddProductServlet extends HttpServlet
{
    private ProductService proService =  new ProductServiceImpl();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String pName = req.getParameter("proTitle");
        String pDescription = req.getParameter("proDescription");
        int  pOption =Integer.parseInt( req.getParameter ("categoryOption"));
        double pPrice = Double.parseDouble(req.getParameter ("proPrice"));
        int pStock = Integer.parseInt(req.getParameter("proStock"));
        int pDisount = Integer.parseInt(req.getParameter("proDis"));
        Part part = req.getPart("pPic");

        String fileName=part.getSubmittedFileName();
       Vegetable veg= new Vegetable();
       veg.setName(pName);
       veg.setDescription(pDescription);
       veg.setPrice(pPrice);
       veg.setDiscount(pDisount);
       veg.setQuantityInStock(pStock);
       veg.setpImage(fileName);

       //product save
       Category category= proService.getcategoryById(pOption);
       veg.setCategory(category);

       boolean saved = proService.saveProduct(veg);

       //pic upload
        // find out the path to uplaod image
        String path= req.getRealPath("img") + File.separator + "Products"+ File.separator +fileName;

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

       HttpSession session = req.getSession();
        if (saved) {
            session.setAttribute("proMsg", "Product Added Successfully!");
        } else {
            session.setAttribute("proMsg", "Failed To Add Product!");
        }
        resp.sendRedirect("admin.jsp");

    }

}
