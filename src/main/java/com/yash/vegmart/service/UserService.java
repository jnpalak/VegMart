package com.yash.vegmart.service;

import com.yash.vegmart.entity.User;

public interface UserService {

    Integer registerUser(User user);

    boolean emailExists(String email);

    User loginUser(String email, String password);
}