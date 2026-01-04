package com.yash.vegmart.dao;

import com.yash.vegmart.entity.CartItem;
import com.yash.vegmart.entity.Order;
import com.yash.vegmart.entity.Payment;
import com.yash.vegmart.entity.User;

import java.util.List;
import java.util.Map;

public interface OrderDAO {
    int saveOrder(Order order);
    List<Order> getOrdersByUser(int userId);
    List<Order> getAllOrders();
    boolean updateOrderStatus(int orderId, String status);
    void savePayment(Payment payment);
    Order placeOrder(User user, Map<Integer, CartItem> cart, String paymentMode, double totalAmount);
}