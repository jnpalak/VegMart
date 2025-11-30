package com.yash.vegmart.dao;

import com.yash.vegmart.entity.Category;

import java.util.List;

public interface CategoryDAO {
    boolean saveCategory(Category category);
    List<Category> getCategory();

}