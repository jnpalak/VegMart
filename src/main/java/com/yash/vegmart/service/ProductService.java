package com.yash.vegmart.service;

import com.yash.vegmart.entity.Category;
import com.yash.vegmart.entity.Vegetable;

import java.util.List;

/**
 * Service interface for managing products (vegetables) and categories in VegMart.
 * Defines operations for retrieving, saving, updating, deleting, and searching products.
 * Also allows fetching category details by ID.
 *
 * Implementations encapsulate product-related business logic.
 *
 * @author Palak Jain

 */
public interface ProductService {

    /**
     * Retrieves a category by its unique ID.
     *
     * @param id The category ID.
     * @return The Category object if found; null otherwise.
     */
    Category getcategoryById(int id);

    /**
     * Saves a new vegetable product.
     *
     * @param veg The Vegetable entity to save.
     * @return true if successfully saved; false otherwise.
     */
    boolean saveProduct(Vegetable veg);

    /**
     * Retrieves all vegetable products.
     *
     * @return List of all Vegetable entities.
     */
    List<Vegetable> getAllProducts();

    /**
     * Retrieves all vegetable products belonging to a specific category.
     *
     * @param categoryId The ID of the category.
     * @return List of Vegetable entities in the category.
     */
    List<Vegetable> getProductsByCategory(int categoryId);

    /**
     * Retrieves a vegetable product by its unique ID.
     *
     * @param vid The vegetable product ID.
     * @return The Vegetable object if found; null otherwise.
     */
    Vegetable getProductById(int vid);

    /**
     * Updates an existing vegetable product.
     *
     * @param v The Vegetable entity with updated details.
     */
    void updateProduct(Vegetable v);

    /**
     * Updates a vegetable product with administrative privileges.
     *
     * @param oldProduct The Vegetable entity containing updated information.
     * @return true if the update was successful; false otherwise.
     */
    boolean updateProductAdmin(Vegetable oldProduct);

    /**
     * Updates the discount percentage for a specific product.
     *
     * @param pid The product ID.
     * @param discount The discount percentage to apply.
     * @return true if discount updated successfully; false otherwise.
     */
    boolean updateDiscount(int pid, int discount);

    /**
     * Deletes a product by its ID.
     *
     * @param pid The product ID.
     * @return true if the product was deleted; false otherwise.
     */
    boolean deleteProduct(int pid);

    /**
     * Searches vegetable products by a keyword.
     *
     * @param keyword The search keyword.
     * @return List of matching Vegetable entities.
     */
    List<Vegetable> searchVegetables(String keyword);
}
