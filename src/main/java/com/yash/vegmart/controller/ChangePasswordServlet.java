package com.yash.vegmart.controller;

import com.yash.vegmart.entity.User;
import com.yash.vegmart.service.UserService;
import com.yash.vegmart.serviceimpl.UserServiceImpl;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

/**
 * Servlet controller for handling user password changes in the VegMart system.
 * Processes HTTP POST requests from user profile page to update password after
 * validating old password and updating via UserService.
 *
 * Mapped to URL: /ChangePasswordServlet
 * Requires authenticated user session with userObj attribute.
 *
 * @author Palak Jain
 */
@WebServlet("/ChangePasswordServlet")
public class ChangePasswordServlet extends HttpServlet {

    /**
     * Handles HTTP POST requests for changing user password.
     * Validates user authentication and old password match, updates password
     * via UserService, refreshes session user object, and redirects to profile page
     * with appropriate success/error messages.
     *
     * @param req HttpServletRequest containing form parameters:
     *            - oldPassword: Current password for validation (String, required)
     *            - newPassword: New password to set (String, required)
     * @param resp HttpServletResponse for redirecting to profile.jsp
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an input/output error occurs
     */
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        HttpSession session = req.getSession();
        User user = (User) session.getAttribute("userObj");

        // Check if user is authenticated
        if (user == null) {
            session.setAttribute("msg", "Please login first!");
            resp.sendRedirect("login.jsp");
            return;
        }

        // Extract form parameters
        String oldPass = req.getParameter("oldPassword");
        String newPass = req.getParameter("newPassword");

        UserService userService = new UserServiceImpl();

        // Validate old password matches current password
        if (!user.getPassword().equals(oldPass)) {
            session.setAttribute("error", "Old password is incorrect!");
            resp.sendRedirect("profile.jsp");
            return;
        }

        // Update password and refresh session object
        user.setPassword(newPass);
        boolean updated = userService.updateUser(user);

        if (updated) {
            session.setAttribute("success", "Password updated successfully!");
            // Update session with new password
            session.setAttribute("userObj", user);
        } else {
            session.setAttribute("error", "Password update failed!");
        }

        resp.sendRedirect("profile.jsp");
    }
}
