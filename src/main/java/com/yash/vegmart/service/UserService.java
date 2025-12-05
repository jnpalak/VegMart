package com.yash.vegmart.service;

import com.yash.vegmart.entity.User;

import java.util.List;

public interface UserService {

    Integer registerUser(User user);

    boolean emailExists(String email);

    User loginUser(String email, String password);
    List<User> getAllUsers();

    boolean deleteUser(int uid);
}