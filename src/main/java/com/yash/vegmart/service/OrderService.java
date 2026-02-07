package com.yash.vegmart.service;

import com.yash.vegmart.entity.CartItem;
import com.yash.vegmart.entity.Order;
import com.yash.vegmart.entity.Payment;
import com.yash.vegmart.entity.User;

import java.util.List;
import java.util.Map;

/**
 * Service interface for managing orders in the VegMart system.
 * Defines methods for placing orders, retrieving orders,
 * saving new orders, updating order status, and querying orders by user.
 *
 * Implementations of this interface handle business logic related to orders.
 *
 * @author Palak Jain
 */
public interface OrderService {

    /**
     * Places a new order for the given user.
     *
     * @param user        The user placing the order.
     * @param cart        A map of cart item IDs to CartItem objects representing the user's shopping cart.
     * @param paymentMode The payment method chosen by the user (e.g., "Credit Card", "Cash").
     * @param totalAmount The total amount payable for the order.
     * @return
     */
    Order placeOrder(User user, Map<Integer, CartItem> cart, String paymentMode, double totalAmount);

    /**
     * Retrieves a list of all orders in the system.
     *
     * @return List of Order objects representing all orders.
     */
    List<Order> getAllOrders();

    /**
     * Saves a new order to the database.
     *
     * @param order The Order entity to save.
     * @return The generated order ID after successful save.
     */
    int saveOrder(Order order);

    /**
     * Retrieves a list of orders placed by a specific user.
     *
     * @param userId The unique ID of the user.
     * @return List of Order objects belonging to the given user.
     */
    List<Order> getOrdersByUser(int userId);

    /**
     * Updates the status of an existing order.
     *
     * @param orderId The unique ID of the order to update.
     * @param status The new status string (e.g., "Pending", "Shipped", "Delivered").
     * @return true if the update was successful; false otherwise.
     */
    boolean updateOrderStatus(int orderId, String status);

    void savePayment(Payment payment);

    Order getOrderById(int orderId);
}
