package com.yash.vegmart.service;

import com.yash.vegmart.entity.Category;
import com.yash.vegmart.entity.Vegetable;

import java.util.List;

public interface ProductService
{
    Category getcategoryById(int id);
    boolean saveProduct(Vegetable veg);
    List<Vegetable> getAllProducts();
    List<Vegetable> getProductsByCategory(int categoryId);

    Vegetable getProductById(int vid);


    void updateProduct(Vegetable v);
}
