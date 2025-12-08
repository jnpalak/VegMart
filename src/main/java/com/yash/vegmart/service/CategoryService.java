package com.yash.vegmart.service;

import com.yash.vegmart.entity.Category;
import java.util.List;

/**
 * Service interface for Category-related business operations.
 * Defines the contract for adding and retrieving categories.
 * Implementations of this interface encapsulate the business logic.
 *
 * @author Palak Jain
 */
public interface CategoryService {

    /**
     * Adds a new category.
     *
     * @param category The category entity to add.
     * @return true if the category was added successfully; false otherwise.
     */
    boolean addCategory(Category category);

    /**
     * Retrieves all categories.
     *
     * @return List of all Category entities.
     */
    List<Category> getCategory();
}
