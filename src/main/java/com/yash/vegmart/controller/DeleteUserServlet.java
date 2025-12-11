package com.yash.vegmart.controller;

import com.yash.vegmart.service.UserService;
import com.yash.vegmart.serviceimpl.UserServiceImpl;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * Servlet controller for deleting normal users in the VegMart system.
 * Processes HTTP POST requests from admin user management interface to remove user accounts.
 * Handles role-based deletion restrictions and forwards to manageUsers.jsp with status messages.
 *
 * Mapped to URL: /DeleteUserServlet
 * Expected parameter: uid (user ID)
 *
 * @author Palak Jain
 */
@WebServlet("/DeleteUserServlet")
public class DeleteUserServlet extends HttpServlet {

    /**
     * Handles HTTP POST requests to delete a specific user account.
     * Parses user ID, deletes via UserService (with built-in role validation),
     * sets request attributes with success/danger messages, and forwards to manageUsers.jsp.
     *
     * @param req HttpServletRequest containing form parameter:
     *            - uid: User ID to delete (Integer, required)
     * @param resp HttpServletResponse for forwarding to user management page
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an input/output error occurs
     */
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        // Parse user ID from request parameter
        int uid = Integer.parseInt(req.getParameter("uid"));

        UserService us = new UserServiceImpl();

        // Delete user (service handles role validation - only normal users)
        boolean deleted = us.deleteUser(uid);

        // Set request attributes for JSP display
        if (deleted) {
            req.setAttribute("message", "User deleted successfully!");
            req.setAttribute("messageType", "success");
        } else {
            req.setAttribute("message", "Delete failed - only normal users can be deleted!");
            req.setAttribute("messageType", "danger");
        }

        // Forward to user management page with status
        req.getRequestDispatcher("manageUsers.jsp").forward(req, resp);
    }
}
