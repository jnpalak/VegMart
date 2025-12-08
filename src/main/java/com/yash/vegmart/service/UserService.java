package com.yash.vegmart.service;

import com.yash.vegmart.entity.User;

import java.util.List;

/**
 * Service interface for user management in the VegMart system.
 * Defines operations for registering, authenticating, retrieving,
 * updating, and deleting users or admins.
 *
 * Implementations handle business logic related to user accounts.
 *
 * @author Palak Jain
 */
public interface UserService {

    /**
     * Registers a new user.
     *
     * @param user The User entity to register.
     * @return The unique ID of the registered user.
     */
    Integer registerUser(User user);

    /**
     * Checks if an email is already registered.
     *
     * @param email The email address to check.
     * @return true if the email exists; false otherwise.
     */
    boolean emailExists(String email);

    /**
     * Authenticates a user by email and password.
     *
     * @param email The email address.
     * @param password The password.
     * @return The User entity if login is successful; null otherwise.
     */
    User loginUser(String email, String password);

    /**
     * Retrieves all users.
     *
     * @return List of all User entities.
     */
    List<User> getAllUsers();

    /**
     * Deletes a user by their unique ID.
     *
     * @param uid The user ID.
     * @return true if the user was deleted successfully; false otherwise.
     */
    boolean deleteUser(int uid);

    /**
     * Updates the information of an existing user.
     *
     * @param user The User entity with updated details.
     * @return true if update was successful; false otherwise.
     */
    boolean updateUser(User user);

    /**
     * Saves a user entity (can be used for both add and update).
     *
     * @param user The User entity to save.
     * @return The unique ID of the saved user.
     */
    Integer save(User user);

    /**
     * Deletes an admin user by their ID.
     *
     * @param adminId The admin user ID.
     * @return true if the admin user was deleted; false otherwise.
     */
    boolean deleteAdmin(int adminId);

    /**
     * Retrieves a user (admin or general) by their ID.
     *
     * @param adminId The user ID.
     * @return The User entity if found; null otherwise.
     */
    User getUserById(int adminId);
}
