package com.yash.vegmart.controller;
import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import com.yash.vegmart.service.UserService;
import com.yash.vegmart.serviceimpl.UserServiceImpl;

@WebServlet("/DeleteUserServlet")
public class DeleteUserServlet extends HttpServlet {

    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        int uid = Integer.parseInt(req.getParameter("uid"));
        UserService us = new UserServiceImpl();
        boolean deleted=us.deleteUser(uid);
        if (deleted) {
            req.setAttribute("message", "User deleted successfully!");
            req.setAttribute("messageType", "success");
        } else {
            req.setAttribute("message", "Delete failed - only normal users can be deleted!");
            req.setAttribute("messageType", "danger");
        }
        req.getRequestDispatcher("manageUsers.jsp").forward(req, resp);
    }
}