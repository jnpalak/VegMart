package com.yash.vegmart.serviceimpl;

import com.yash.vegmart.dao.UserDAO;
import com.yash.vegmart.daoimpl.UserDAOImpl;
import com.yash.vegmart.entity.User;
import com.yash.vegmart.service.UserService;

import java.util.List;

public class UserServiceImpl implements UserService {

    private UserDAO userDAO;

    public UserServiceImpl() {
        userDAO = new UserDAOImpl();
    }

    @Override
    public Integer registerUser(User user) {
        return userDAO.save(user);
    }

    @Override
    public boolean emailExists(String email) {
        return userDAO.emailExists(email);
    }

    @Override
    public User loginUser(String email, String password) {
        return userDAO.validateUser(email, password);
    }
    @Override
    public List<User> getAllUsers()
    {
        return userDAO.getAllUsers();
    }

    @Override
    public boolean deleteUser(int uid) {
        return userDAO.deleteUser(uid);
    }
    @Override
   public  boolean updateUser(User user)
    {
        return userDAO.updateUser(user);
    }

    @Override
    public Integer save(User user)
    {
        return userDAO.save(user);
    }
    @Override
    public User getUserById(int adminId)
    {
         return userDAO.getUserById(adminId);
    }
    @Override
    public  boolean deleteAdmin(int adminId)
    {
        return userDAO.deleteAdmin(adminId);
    }
}