package com.yash.vegmart.controller;

import com.yash.vegmart.service.UserService;
import com.yash.vegmart.serviceimpl.UserServiceImpl;
import com.yash.vegmart.entity.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

/**
 * Servlet controller for deleting admin users in the VegMart system.
 * Processes HTTP POST requests from admin management interface to remove admin accounts.
 * Validates admin existence and role before deletion via UserService.
 *
 * Mapped to URL: /DeleteAdminServlet
 * Expected parameter: adminId (admin user ID)
 *
 * @author Palak Jain
 */
@WebServlet("/DeleteAdminServlet")
public class DeleteAdminServlet extends HttpServlet {

    /**
     * Handles HTTP POST requests to delete a specific admin user.
     * Parses admin ID, fetches user details, validates admin role, deletes via UserService,
     * and redirects to addAdmin.jsp with success/error session messages.
     *
     * @param req HttpServletRequest containing form parameter:
     *            - adminId: ID of admin user to delete (Integer, required)
     * @param resp HttpServletResponse for redirecting to admin management page
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an input/output error occurs
     */
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        int adminId = Integer.parseInt(req.getParameter("adminId"));

        HttpSession session = req.getSession();
        UserService userService = new UserServiceImpl();


        User admin = userService.getUserById(adminId);
        if (admin != null && admin.getUserType().equals("admin")) {

            boolean deleted = userService.deleteAdmin(adminId);
            if (deleted) {
                session.setAttribute("successAdmin", "Admin deleted successfully!");
            } else {
                session.setAttribute("errorAdmin", "Unable to delete admin. Try again.");
            }
        } else {

            session.setAttribute("errorAdmin", "Invalid admin selected!");
        }

        resp.sendRedirect("addAdmin.jsp");
    }
}
