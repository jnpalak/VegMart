package com.yash.vegmart.daoimpl;

import com.yash.vegmart.dao.ProductDAO;
import com.yash.vegmart.entity.Category;
import com.yash.vegmart.entity.Vegetable;
import com.yash.vegmart.utilities.HibernateUtil;
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.hibernate.query.Query;

import java.util.List;

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
    @Override
    public List<Vegetable> getAllProducts()
    {
        List<Vegetable> list=null;
        try(Session session = HibernateUtil.getSessionFactory().openSession()) {
            Query<Vegetable> query = session.createQuery("from Vegetable", Vegetable.class);
            list = query.list();
        }
        catch (Exception e) {
            e.printStackTrace();
        }
        return list;

    }
    @Override
    public List<Vegetable> getProductsByCategory(int categoryId)
    {
        List<Vegetable> list=null;
        try(Session session = HibernateUtil.getSessionFactory().openSession())
        {
            Query<Vegetable> query=session.createQuery("FROM Vegetable v WHERE v.category.categoryId = :catId", Vegetable.class);
            query.setParameter("catId",categoryId);
            list= query.list();
        }
        catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }
    @Override
    public Vegetable getProductById(int id)
    {
        Vegetable cat=null;
        try(Session session = HibernateUtil.getSessionFactory().openSession()) {
            cat=session.get(Vegetable.class,id);

        }
        catch (Exception e) {
            e.printStackTrace();
        }
        return cat;
    }
    @Override
    public void updateProduct(Vegetable veg) {
        Transaction tx = null;
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            tx = session.beginTransaction();
            session.update(veg);
            tx.commit();
        } catch (Exception e) {
            if (tx != null) tx.rollback();
            e.printStackTrace();
        }
    }
}
