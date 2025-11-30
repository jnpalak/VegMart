package com.yash.vegmart.controller;

import com.yash.vegmart.dao.UserDAO;
import com.yash.vegmart.entity.User;
import com.yash.vegmart.service.UserService;
import com.yash.vegmart.serviceimpl.UserServiceImpl;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import java.io.IOException;

@WebServlet("/RegistrationServlet")
public class RegistrationServlet extends HttpServlet {

    private UserService userService;

    @Override
    public void init() {
        userService = new UserServiceImpl();  // DAO object
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            // Read form data
            String name = request.getParameter("name");
            String email = request.getParameter("email");
            String address=request.getParameter("address");
            String password = request.getParameter("password");
            String contact = request.getParameter("mobile");

            if(userService.emailExists(email))
            {
                request.setAttribute("emailerror","Email already registered. Try logging in.");
                request.getRequestDispatcher("index.jsp").forward(request,response);
                return;
            }
            // Create User object
            User user = new User();
            user.setName(name);
            user.setEmail(email);
            user.setPassword(password);
            user.setAddress(address);
            user.setMobile(contact);
            user.setUserType("normal");

            // Save using DAO
            Integer id = userService.registerUser(user);

            if (id != null) {
                // Registration success
                request.setAttribute("msg", "Registration Successful! Please login.");
                request.getRequestDispatcher("login.jsp").forward(request, response);
            } else {
                // Failure
                request.setAttribute("error", "Registration failed. Try again!");
                request.getRequestDispatcher("register.jsp").forward(request, response);
            }

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Server Error! " + e.getMessage());
            request.getRequestDispatcher("register.jsp").forward(request, response);
        }
    }
}