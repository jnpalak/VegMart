package com.yash.vegmart.service;

import com.yash.vegmart.entity.Category;
import com.yash.vegmart.entity.Vegetable;

public interface ProductService
{
    Category getcategoryById(int id);

    boolean saveProduct(Vegetable veg);
}
