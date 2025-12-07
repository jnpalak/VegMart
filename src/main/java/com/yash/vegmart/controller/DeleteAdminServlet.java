package com.yash.vegmart.controller;

import com.yash.vegmart.service.UserService;

import com.yash.vegmart.serviceimpl.UserServiceImpl;

import com.yash.vegmart.entity.User;

import javax.servlet.ServletException;

import javax.servlet.annotation.WebServlet;

import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/DeleteAdminServlet")

public class DeleteAdminServlet extends HttpServlet {

    @Override

    protected void doPost(HttpServletRequest req, HttpServletResponse resp)

            throws ServletException, IOException {

        int adminId = Integer.parseInt(req.getParameter("adminId"));

        HttpSession session = req.getSession();

        UserService userService = new UserServiceImpl();

        // Fetch admin object (you might already have a method, if not I’ll help)

        User admin = userService.getUserById(adminId);

        // Safety check – don't allow deleting normal users through admin delete

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

