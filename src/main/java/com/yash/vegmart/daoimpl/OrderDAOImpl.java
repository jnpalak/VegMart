package com.yash.vegmart.daoimpl;
import com.yash.vegmart.dao.OrderDAO;
import com.yash.vegmart.entity.*;
import com.yash.vegmart.utilities.HibernateUtil;
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.hibernate.query.Query;

import java.util.Date;
import java.util.List;
import java.util.Map;

public class OrderDAOImpl implements OrderDAO {
    @Override
    public int saveOrder(Order order) {
        Transaction tx = null;
        int id = 0;
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            tx = session.beginTransaction();
            id = (int) session.save(order);
            tx.commit();
        } catch (Exception e) {
            if (tx != null) tx.rollback();
            e.printStackTrace();
        }
        return id;
    }

    @Override
    public List<Order> getOrdersByUser(int userId) {
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            Query<Order> q = session.createQuery(
                    "FROM Order o WHERE o.user.userId = :uid ORDER BY o.orderDate DESC",
                    Order.class
            );
            q.setParameter("uid", userId);
            return q.list();
        }
    }

    @Override
    public List<Order> getAllOrders() {
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            return session.createQuery("FROM Order ORDER BY orderDate DESC", Order.class).list();
        }

    }

    @Override
    public boolean updateOrderStatus(int orderId, String status) {
        Transaction tx = null;
        boolean updated = false;
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            tx = session.beginTransaction();
            Order o = session.get(Order.class, orderId);
            if (o != null) {
                o.setStatus(status);
                session.update(o);
                updated = true;
            }
            tx.commit();
        } catch (Exception e) {
            if (tx != null) tx.rollback();
            e.printStackTrace();

        }
        return updated;

    }
    @Override
    public Order placeOrder(User user, Map<Integer, CartItem> cart, String paymentMode, double totalAmount) {

        Transaction tx = null;
        Order order = new Order();
        Session session=null;
        try
        {
            session = HibernateUtil.getSessionFactory().openSession();
            tx = session.beginTransaction();
            order.setUser(user);
            order.setOrderDate(new Date());
            order.setTotalAmount(totalAmount);
            order.setPaymentMode(paymentMode);
            order.setStatus("Order Processing");
            session.save(order);

            for (CartItem ci : cart.values()) {

                Vegetable veg = session.get(Vegetable.class, ci.getVegetableId());
                if (veg != null) {

                    if (veg.getQuantityInStock() < ci.getQuantity()) {
                        throw new RuntimeException("Not enough stock for: " + veg.getName());
                    }

                    veg.setQuantityInStock(veg.getQuantityInStock() - ci.getQuantity());
                    session.update(veg);

                    OrderItem item = new OrderItem();
                    item.setOrder(order);
                    item.setVegetable(veg);
                    item.setQuantity(ci.getQuantity());
                    session.save(item);
                }
            }
            tx.commit();
        }
        catch (Exception e)
        {
            if (tx != null)tx.rollback();
            throw e;
        }
        finally {
            if (session != null) session.close();
        }
        return order;
    }

    @Override
    public void savePayment(Payment payment)
    {
        Transaction tx = null;
        Session session = null;
        try {
            session = HibernateUtil.getSessionFactory().openSession();
            tx = session.beginTransaction();
            session.save(payment);
            tx.commit();
        } catch (Exception e) {
            if (tx != null) tx.rollback();
            throw e;
        } finally {
            if (session != null) session.close();
        }
    }
    @Override
    public Order getOrderById(int orderId)
    {
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            return session.get(Order.class,orderId);
        }
    }
}

