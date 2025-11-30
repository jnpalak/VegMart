package com.yash.vegmart.serviceimpl;

import com.yash.vegmart.dao.CategoryDAO;
import com.yash.vegmart.daoimpl.CategoryDAOImpl;
import com.yash.vegmart.entity.Category;
import com.yash.vegmart.service.CategoryService;

import java.util.List;

public class CategoryServiceImpl implements CategoryService {

    private CategoryDAO categoryDAO = new CategoryDAOImpl();

    @Override
    public boolean addCategory(Category category) {
        return categoryDAO.saveCategory(category);
    }
    public List<Category> getCategory()
    {
        return categoryDAO.getCategory();
    }
}