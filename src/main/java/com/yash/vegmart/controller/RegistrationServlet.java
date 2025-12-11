package com.yash.vegmart.controller;
import com.yash.vegmart.entity.User;
import com.yash.vegmart.service.UserService;
import com.yash.vegmart.serviceimpl.UserServiceImpl;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import java.io.IOException;

/**
 * Servlet controller for handling user registration in the VegMart system.
 * Processes HTTP POST requests from the registration form,
 * checks email uniqueness, creates new user accounts,
 * and forwards to appropriate JSP pages based on registration success or failure.
 *
 * Mapped to URL: /RegistrationServlet
 * Uses UserService to perform email existence checking and user registration.
 *
 * Request parameters expected:
 * - name: User's full name
 * - email: User's email address (must be unique)
 * - address: User's address
 * - password: User's chosen password
 * - mobile: User's contact mobile number
 *
 * Forward/redirect targets:
 * - index.jsp (if email is already registered)
 * - login.jsp (upon successful registration)
 * - register.jsp (upon failure or server error)
 *
 * Session attributes are not used in this servlet; uses request attributes for messages and errors.
 *
 * Author: Palak Jain
 */
@WebServlet("/RegistrationServlet")
public class RegistrationServlet extends HttpServlet {

    private UserService userService;

    /**
     * Initializes the servlet and its dependencies.
     * Creates an instance of UserServiceImpl to handle user registration business logic.
     */
    @Override
    public void init() {
        userService = new UserServiceImpl();
    }

    /**
     * Handles HTTP POST requests for user registration.
     *
     * Workflow:
     * - Reads registration form parameters.
     * - Checks if the email is already registered.
     * - If email exists, sets error message and forwards to index.jsp.
     * - If email is new, creates a User object and attempts to register via UserService.
     * - On success, sets success message and forwards to login.jsp.
     * - On failure, sets error message and forwards to register.jsp.
     * - Catches and logs exceptions, forwarding to register.jsp with an error message.
     *
     * @param request  HttpServletRequest containing registration form data.
     * @param response HttpServletResponse used for forwarding to JSP pages.
     * @throws ServletException if servlet-specific errors occur.
     * @throws IOException      if an I/O error occurs during request processing.
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            String name = request.getParameter("name");
            String email = request.getParameter("email");
            String address = request.getParameter("address");
            String password = request.getParameter("password");
            String contact = request.getParameter("mobile");

            if (userService.emailExists(email)) {
                request.setAttribute("emailerror", "Email already registered. Try logging in.");
                request.getRequestDispatcher("index.jsp").forward(request, response);
                return;
            }

            User user = new User();
            user.setName(name);
            user.setEmail(email);
            user.setPassword(password);
            user.setAddress(address);
            user.setMobile(contact);
            user.setUserType("normal");

            Integer id = userService.registerUser(user);

            if (id != null) {
                request.setAttribute("msg", "Registration Successful! Please login.");
                request.getRequestDispatcher("login.jsp").forward(request, response);
            } else {
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
