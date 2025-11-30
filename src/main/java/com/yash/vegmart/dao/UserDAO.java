package com.yash.vegmart.dao;

import com.yash.vegmart.entity.User;

public interface UserDAO {

    Integer save(User user);

    boolean emailExist(String email);

    User validateUser(String email, String pass);
}