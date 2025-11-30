package com.yash.vegmart.daoimpl;

import com.yash.vegmart.dao.CategoryDAO;
import com.yash.vegmart.entity.Category;
import com.yash.vegmart.utilities.HibernateUtil;
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.hibernate.query.Query;

import java.util.List;

public class CategoryDAOImpl implements CategoryDAO {

    @Override
    public boolean saveCategory(Category category) {

        Transaction tx = null;
        boolean success = false;

        try (Session session = HibernateUtil.getSessionFactory().openSession()) {

            tx = session.beginTransaction();
            session.save(category);
            tx.commit();
            success = true;

        } catch (Exception e) {
            e.printStackTrace();
            if (tx != null) tx.rollback();
        }

        return success;
    }
   public List<Category> getCategory()
   {
       List<Category> list=null;
       try(Session session = HibernateUtil.getSessionFactory().openSession()) {
           Query<Category> query = session.createQuery("from Category", Category.class);
           list = query.list();
       }
       catch (Exception e) {
           e.printStackTrace();
       }
       return list;
   }

}