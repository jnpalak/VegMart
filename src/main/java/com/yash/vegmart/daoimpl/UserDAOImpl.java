package com.yash.vegmart.daoimpl;

import com.yash.vegmart.dao.UserDAO;
import com.yash.vegmart.entity.User;
import com.yash.vegmart.utilities.HibernateUtil;
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.hibernate.query.Query;

import java.util.List;

public class UserDAOImpl implements UserDAO {

    @Override
    public Integer save(User user) {
        Transaction tx = null;
        Integer userId = null;

        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            tx = session.beginTransaction();
            userId = (Integer) session.save(user);
            tx.commit();
        } catch (Exception e) {
            if (tx != null) tx.rollback();
            e.printStackTrace();
        }
        return userId;
    }

    @Override
    public boolean emailExists(String email) {
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            Query<User> query = session.createQuery("FROM User WHERE email = :email", User.class);
            query.setParameter("email", email);

            User user = query.uniqueResult();
            return user != null;
        }
    }

    @Override
    public User validateUser(String email, String pass) {
        User user = null;
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            String hql = "FROM User WHERE email = :em AND password = :pw";
            Query<User> query = session.createQuery(hql, User.class);
            query.setParameter("em", email);
            query.setParameter("pw", pass);
            user = query.uniqueResult();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return user;
    }
    @Override
    public List<User> getAllUsers() {
        List<User> list=null;
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            list = session.createQuery("from User").list();

        }
        catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }
    @Override
    public boolean deleteUser(int userId) {
        Transaction tx = null;
        Session session = null;
        try {
            session = HibernateUtil.getSessionFactory().openSession();
            tx = session.beginTransaction();

            // 1. Delete OrderItems first (if any cascade issues)
            int itemsDeleted = session.createQuery(
                            "DELETE FROM OrderItem oi WHERE oi.order.user.userId = :userId")
                    .setParameter("userId", userId)
                    .executeUpdate();
            System.out.println("Deleted " + itemsDeleted + " order items");

            // 2. Delete Orders for this user
            int ordersDeleted = session.createQuery(
                            "DELETE FROM Order o WHERE o.user.userId = :userId")  // Fixed: o.user.userId
                    .setParameter("userId", userId)
                    .executeUpdate();
            System.out.println("Deleted " + ordersDeleted + " orders for user " + userId);

            // 3. Now delete the user
            User u = session.get(User.class, userId);
            if (u != null && "normal".equals(u.getUserType())) {
                session.delete(u);
                tx.commit();
                return true;
            } else {
                tx.rollback();
                return false;
            }
        } catch (Exception e) {
            if (tx != null && tx.isActive()) {
                tx.rollback();
            }
            e.printStackTrace();
            return false;
        } finally {
            if (session != null && session.isOpen()) {
                session.close();
            }
        }
    }

    @Override
    public boolean updateUser(User user) {
        Transaction tx = null;
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            tx = session.beginTransaction();
            session.update(user);
            tx.commit();
            return true;
        } catch (Exception e) {
            if (tx != null) tx.rollback();
            e.printStackTrace();
        }
        return false;
    }
    @Override
    public User getUserById(int id) {
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            return session.get(User.class, id);
        }
    }
    @Override
    public boolean deleteAdmin(int adminId) {
        Transaction tx = null;
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            tx = session.beginTransaction();
            User u = session.get(User.class, adminId);
            if (u != null && (u.getUserType().equals("admin") && !u.getEmail().equals("palakjain88277@gmail.com")))
            {
                session.delete(u);
                tx.commit();
                return true;
            }
            return false;
        } catch (Exception e) {
            if (tx != null) tx.rollback();
            e.printStackTrace();
            return false;
        }
    }

}