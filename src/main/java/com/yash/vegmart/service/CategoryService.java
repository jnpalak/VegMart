package com.yash.vegmart.service;

import com.yash.vegmart.entity.Category;

import java.util.List;

public interface CategoryService {
    boolean addCategory(Category category);
    List<Category> getCategory();
}