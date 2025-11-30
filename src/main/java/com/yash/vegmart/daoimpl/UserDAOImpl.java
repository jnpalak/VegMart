package com.yash.vegmart.daoimpl;

import com.yash.vegmart.dao.UserDAO;
import com.yash.vegmart.entity.User;
import com.yash.vegmart.utilities.HibernateUtil;
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.hibernate.query.Query;

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
    public boolean emailExist(String email) {
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
}