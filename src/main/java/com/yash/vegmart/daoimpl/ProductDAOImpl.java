package com.yash.vegmart.daoimpl;

import com.yash.vegmart.dao.ProductDAO;
import com.yash.vegmart.entity.Category;
import com.yash.vegmart.entity.Vegetable;
import com.yash.vegmart.utilities.HibernateUtil;
import org.hibernate.Session;
import org.hibernate.Transaction;

public class ProductDAOImpl implements ProductDAO
{
    @Override
    public Category getcategoryById(int id)
    {
        Category cat=null;
        try(Session session = HibernateUtil.getSessionFactory().openSession()) {
            cat=session.get(Category.class,id);

        }
        catch (Exception e) {
            e.printStackTrace();
        }
        return cat;
    }
    @Override
    public boolean saveProduct(Vegetable  veg) {
        Transaction tx = null;
        boolean saved = false;

        try (Session session = HibernateUtil.getSessionFactory().openSession()) {

            tx = session.beginTransaction();
            session.save(veg);
            tx.commit();
            saved = true;

        } catch (Exception e) {
            e.printStackTrace();
            if (tx != null) tx.rollback();

        }

        return saved;
    }
}
