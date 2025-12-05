package com.yash.vegmart.dao;

import com.yash.vegmart.entity.Category;
import com.yash.vegmart.entity.Vegetable;

import java.util.List;

public interface ProductDAO
{
    Category getcategoryById(int id);
    boolean saveProduct(Vegetable veg);
    List<Vegetable> getAllProducts();

    List<Vegetable> getProductsByCategory(int categoryId);

    Vegetable getProductById(int id);

    void updateProduct(Vegetable v);
}
