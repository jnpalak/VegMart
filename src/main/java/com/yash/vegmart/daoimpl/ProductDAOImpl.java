package com.yash.vegmart.daoimpl;

import com.yash.vegmart.dao.ProductDAO;
import com.yash.vegmart.entity.Category;
import com.yash.vegmart.entity.Vegetable;
import com.yash.vegmart.utilities.HibernateUtil;
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.hibernate.query.Query;

import java.util.ArrayList;
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
    @Override
    public boolean updateProductAdmin(Vegetable oldProduct)
    {
        boolean success=false;
        Transaction tx = null;
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            tx = session.beginTransaction();
            session.update(oldProduct);
            tx.commit();
            success=true;
        } catch (Exception e) {
            if (tx != null) tx.rollback();
            e.printStackTrace();
        }

        return success;
    }

    @Override
    public boolean updateDiscount(int pid, int discount)
    {
        boolean result = false;
        Transaction tx = null;
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            tx = session.beginTransaction();
            Vegetable v = session.get(Vegetable.class, pid);
            if (v != null) {
                v.setDiscount(discount);
                session.update(v);
                tx.commit();
                result = true;
            }
        } catch (Exception e) {

            e.printStackTrace();
            if (tx != null) tx.rollback();
        }
        return result;
    }
    @Override
    public boolean deleteProduct(int productId)
    {
        Transaction tx = null;
        boolean result = false;
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            tx = session.beginTransaction();
            Vegetable veg = session.get(Vegetable.class, productId);
            if (veg != null) {
                session.delete(veg);
                result = true;
            }
            tx.commit();
        } catch (Exception e)
        {
            if (tx != null) tx.rollback();
            e.printStackTrace();
        }
        return result;

    }
    @Override

    public List<Vegetable> searchVegetables(String keyword) {

        List<Vegetable> list = new ArrayList<>();

        try (Session session = HibernateUtil.getSessionFactory().openSession()) {

            String hql = "FROM Vegetable v WHERE v.name LIKE :key OR v.description LIKE :key";

            Query<Vegetable> query = session.createQuery(hql, Vegetable.class);

            query.setParameter("key", "%" + keyword + "%");

            list = query.getResultList();

        } catch (Exception e) {

            e.printStackTrace();

        }

        return list;

    }



}
