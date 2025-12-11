package com.yash.vegmart.controller;

import com.yash.vegmart.entity.User;
import com.yash.vegmart.service.UserService;
import com.yash.vegmart.serviceimpl.UserServiceImpl;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

/**
 * Servlet controller for updating the profile details of a logged-in user in the VegMart system.
 *
 * Handles HTTP POST requests from the profile update form,
 * validates authenticated user session,
 * applies updates to the User entity,
 * calls UserService to persist changes,
 * and manages success or error feedback via session attributes.
 *
 * Redirects to profile.jsp after processing.
 *
 * Mapped to URL: /UpdateProfileServlet
 *
 * Expected session attribute:
 * - userObj: Current logged-in User object.
 *
 * Expected request parameters:
 * - name: Updated user name.
 * - mobile: Updated mobile number.
 * - email: Updated email (optional; if blank, keeps existing email).
 * - address: Updated address.
 *
 * Session attributes set after processing:
 * - success: Success message upon successful update.
 * - error: Error message if update fails.
 *
 * Users not logged in are redirected to login.jsp with an appropriate message.
 *
 * Author: Palak Jain
 */
@WebServlet("/UpdateProfileServlet")
public class UpdateProfileServlet extends HttpServlet {

    /**
     * Handles HTTP POST requests to update user profile information.
     *
     * Validates user login session, reads updated profile fields,
     * updates the User object and persists changes through UserService.
     * Sets feedback in the session and redirects to profile.jsp.
     *
     * @param req  HttpServletRequest containing updated profile parameters.
     * @param resp HttpServletResponse used for redirecting after update.
     * @throws ServletException if servlet-specific error occurs.
     * @throws IOException      if an I/O error occurs during request processing.
     */
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        User user = (User) session.getAttribute("userObj");
        if (user == null) {
            session.setAttribute("msg", "Please login first!");
            resp.sendRedirect("login.jsp");
            return;
        }

        String name = req.getParameter("name");
        String mobile = req.getParameter("mobile");
        String email = req.getParameter("email");
        String address = req.getParameter("address");

        // If email parameter is empty, retain the existing email
        if (email == null || email.trim().equals("")) {
            email = user.getEmail();
        }

        user.setName(name);
        user.setMobile(mobile);
        user.setEmail(email);
        user.setAddress(address);

        UserService userService = new UserServiceImpl();
        boolean updated = userService.updateUser(user);

        if (updated) {
            session.setAttribute("success", "Profile updated successfully!");
            session.setAttribute("userObj", user); // refresh session user data
        } else {
            session.setAttribute("error", "Something went wrong. Try again.");
        }

        resp.sendRedirect("profile.jsp");
    }
}
