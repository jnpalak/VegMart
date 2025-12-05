package com.yash.vegmart.serviceimpl;
import com.yash.vegmart.dao.ProductDAO;
import com.yash.vegmart.daoimpl.ProductDAOImpl;
import com.yash.vegmart.entity.Category;
import com.yash.vegmart.entity.Vegetable;
import com.yash.vegmart.service.ProductService;

import java.util.List;

public class ProductServiceImpl implements ProductService {

    private ProductDAO productDAO = new ProductDAOImpl();

    @Override
    public Category getcategoryById(int id) {
        return productDAO.getcategoryById(id);
    }

    @Override
    public boolean saveProduct(Vegetable veg) {
        return productDAO.saveProduct(veg);
    }
    @Override
    public List<Vegetable> getAllProducts() {
        return productDAO.getAllProducts();
    }
    @Override
    public List<Vegetable> getProductsByCategory(int categoryId) {
        return productDAO.getProductsByCategory(categoryId);
    }
    @Override
    public Vegetable getProductById(int id) {
        return productDAO.getProductById(id);
    }
    @Override
    public void updateProduct(Vegetable v) {
        productDAO.updateProduct(v);
    }



}
