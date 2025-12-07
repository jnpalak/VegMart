package com.yash.vegmart.controller;

import com.yash.vegmart.entity.User;
import com.yash.vegmart.service.UserService;
import com.yash.vegmart.serviceimpl.UserServiceImpl;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/UpdateProfileServlet")
public class UpdateProfileServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        User user = (User) session.getAttribute("userObj");
        if (user == null) {
            session.setAttribute("msg", "Please login first!");
            resp.sendRedirect("login.jsp");
            return;
        }
        // Get updated values
        String name = req.getParameter("name");
        String mobile = req.getParameter("mobile");
        String email = req.getParameter("email");
        String address = req.getParameter("address");

        if(email==null || email.trim().equals(""))
        {
            email= user.getEmail();
        }

        user.setName(name);
        user.setMobile(mobile);
        user.setEmail(email);
        user.setAddress(address);
        // Call service to update DB
        UserService userService = new UserServiceImpl();
        boolean updated = userService.updateUser(user);
        if (updated) {
            session.setAttribute("success", "Profile updated successfully!");
            session.setAttribute("userObj", user); // Update session user
        } else {
            session.setAttribute("error", "Something went wrong. Try again.");
        }
        resp.sendRedirect("profile.jsp");
    }

}

