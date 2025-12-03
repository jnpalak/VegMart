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
        us.deleteUser(uid);

        resp.sendRedirect("manageUsers.jsp");
    }
}