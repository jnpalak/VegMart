package com.yash.vegmart.controller;
import com.yash.vegmart.entity.User;
import com.yash.vegmart.service.UserService;
import com.yash.vegmart.serviceimpl.UserServiceImpl;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/ChangePasswordServlet")
public class ChangePasswordServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        HttpSession session = req.getSession();
        User user = (User) session.getAttribute("userObj");
        // If user not logged in
        if (user == null) {
            session.setAttribute("msg", "Please login first!");
            resp.sendRedirect("login.jsp");
            return;
        }
        String oldPass = req.getParameter("oldPassword");
        String newPass = req.getParameter("newPassword");
        UserService userService = new UserServiceImpl();
        // Validate old password
        if (!user.getPassword().equals(oldPass)) {
            session.setAttribute("error", "Old password is incorrect!");
            resp.sendRedirect("profile.jsp");
            return;
        }
        // Update new password
        user.setPassword(newPass);
        boolean updated = userService.updateUser(user);
        if (updated) {
            session.setAttribute("success", "Password updated successfully!");
            // also update session object with new password
            session.setAttribute("userObj", user);
        } else {
            session.setAttribute("error", "Password update failed!");
        }
        resp.sendRedirect("profile.jsp");

    }

}

