package com.yash.vegmart.dao;

import com.yash.vegmart.entity.User;

import java.util.List;

public interface UserDAO {

    Integer save(User user);

    boolean emailExist(String email);

    User validateUser(String email, String pass);

    List<User> getAllUsers();

    boolean deleteUser(int uid);
}