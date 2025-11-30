package com.yash.vegmart.dao;

import com.yash.vegmart.entity.Category;
import com.yash.vegmart.entity.Vegetable;

public interface ProductDAO
{
    Category getcategoryById(int id);
    boolean saveProduct(Vegetable veg);
}
