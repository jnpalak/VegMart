package com.yash.vegmart.controller;

import com.yash.vegmart.entity.User;
import com.yash.vegmart.service.UserService;
import com.yash.vegmart.serviceimpl.UserServiceImpl;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

import static java.lang.System.out;

/**
 * Servlet controller for handling user authentication in the VegMart system.
 * Processes HTTP POST requests from login form to authenticate users via UserService.
 * Creates user session and redirects based on user type (admin/normal).
 *
 * Mapped to URL: /LoginServlet
 * Expected parameters: email, password
 *
 * @author Palak Jain
 */
@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {

    private UserService userService;

    /**
     * Initializes UserService instance during servlet startup.
     * Called once when servlet is first loaded by container.
     */
    @Override
    public void init() {
        userService = new UserServiceImpl();  // DAO object
    }

    /**
     * Handles HTTP POST requests for user login authentication.
     * Validates credentials via UserService, creates session with user object,
     * redirects admins to admin.jsp and normal users to index.jsp, or returns to login with error.
     *
     * @param request HttpServletRequest containing form parameters:
     *                - email: User email address (String, required)
     *                - password: User password (String, required)
     * @param response HttpServletResponse for role-based redirects
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an input/output error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Extract login credentials
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        // Authenticate user via service layer
        User user = userService.loginUser(email, password);
        HttpSession session = request.getSession();

        if (user != null) {
            // Successful login - store user in session
            session.setAttribute("userObj", user);

            // Role-based redirection
            if (user.getUserType().equals("admin")) {
                response.sendRedirect("admin.jsp");
            } else if (user.getUserType().equals("normal")) {
                response.sendRedirect("index.jsp");
            } else {
                out.println("We have not identified user type");
            }
        } else {
            // Failed authentication
            session.setAttribute("error", "Invalid email or Password");
            response.sendRedirect("login.jsp");
        }
    }
}
