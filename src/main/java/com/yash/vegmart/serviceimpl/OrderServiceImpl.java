package com.yash.vegmart.serviceimpl;

import com.yash.vegmart.dao.OrderDAO;

import com.yash.vegmart.dao.ProductDAO;

import com.yash.vegmart.daoimpl.OrderDAOImpl;

import com.yash.vegmart.daoimpl.ProductDAOImpl;

import com.yash.vegmart.entity.*;

        import com.yash.vegmart.service.OrderService;

import java.util.*;

public class OrderServiceImpl implements OrderService {

    private OrderDAO orderDAO = new OrderDAOImpl();

    private ProductDAO productDAO = new ProductDAOImpl();

    @Override

    public Order placeOrder(User user, Map<Integer, CartItem> cart, String paymentMode, double totalAmount) {
        return orderDAO.placeOrder(user,cart,paymentMode,totalAmount);
    }
    @Override
    public List<Order> getAllOrders()
    {
        return orderDAO.getAllOrders();
    }
    @Override
    public int saveOrder(Order order)
    {
        return orderDAO.saveOrder(order);
    }
    @Override
    public List<Order> getOrdersByUser(int userId)
    {
        return orderDAO.getOrdersByUser(userId);
    }
    @Override
    public boolean updateOrderStatus(int orderId, String status)
    {
        return orderDAO.updateOrderStatus(orderId,status);
    }
    @Override
    public void savePayment(Payment payment)
    {
        orderDAO.savePayment(payment);
    }

    @Override
    public Order getOrderById(int orderId)
    {
        return orderDAO.getOrderById(orderId);
    }
}

