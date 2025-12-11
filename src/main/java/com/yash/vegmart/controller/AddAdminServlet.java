package com.yash.vegmart.controller;

import com.yash.vegmart.entity.User;
import com.yash.vegmart.service.UserService;
import com.yash.vegmart.serviceimpl.UserServiceImpl;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

/**
 * Servlet controller for handling admin user registration in the VegMart system.
 * Processes HTTP POST requests from addAdmin.jsp form to create new admin accounts.
 * Validates email uniqueness and redirects back to the form with success/error messages.
 *
 * Mapped to URL: /AddAdminServlet
 *
 * @author Palak Jain
 */
@WebServlet("/AddAdminServlet")
public class AddAdminServlet extends HttpServlet {

    /**
     * Handles HTTP POST requests for adding new admin users.
     * Extracts form parameters, validates email uniqueness via UserService,
     * creates and saves a new User entity with admin role, and redirects to addAdmin.jsp
     * with appropriate session messages.
     *
     * @param req HttpServletRequest containing form parameters: name, mobile, email, password
     * @param resp HttpServletResponse for redirecting back to the form page
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an input/output error occurs
     */
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        // Extract form parameters
        String name = req.getParameter("name");
        String mobile = req.getParameter("mobile");
        String email = req.getParameter("email");
        String password = req.getParameter("password");

        // Initialize service and session
        UserService userService = new UserServiceImpl();
        HttpSession session = req.getSession();

        // Check if email already registered
        if (userService.emailExists(email)) {
            session.setAttribute("msg", "Email already exists!");
            resp.sendRedirect("addAdmin.jsp");
            return;
        }

        // Create new admin user with default values
        User admin = new User();
        admin.setName(name);
        admin.setMobile(mobile);
        admin.setEmail(email);
        admin.setPassword(password);
        admin.setAddress("N/A");   // default address
        admin.setUserType("admin");

        // Save admin and handle response
        Integer id = userService.save(admin);
        if (id != null && id > 0) {
            session.setAttribute("success", "Admin added successfully!");
        } else {
            session.setAttribute("error", "Failed to register admin!");
        }
        resp.sendRedirect("addAdmin.jsp");
    }
}
