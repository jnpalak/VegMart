package com.yash.vegmart.utilities;
import org.hibernate.SessionFactory;
import org.hibernate.cfg.Configuration;

public class HibernateUtil {

    private static SessionFactory factory;

    static {
        try {
            factory = new Configuration().configure("hibernate.cfg.xml").buildSessionFactory();
        } catch (Exception e) {
            System.out.println("Error building SessionFactory: " + e);
        }
    }

    public static SessionFactory getSessionFactory() {
        return factory;
    }
}