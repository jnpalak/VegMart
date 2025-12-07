package com.yash.vegmart.controller;
import com.yash.vegmart.entity.User;
import com.yash.vegmart.service.UserService;
import com.yash.vegmart.serviceimpl.UserServiceImpl;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
@WebServlet("/AddAdminServlet")
public class AddAdminServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)

            throws ServletException, IOException {

        String name = req.getParameter("name");

        String mobile = req.getParameter("mobile");

        String email = req.getParameter("email");

        String password = req.getParameter("password");

        UserService userService = new UserServiceImpl();

        HttpSession session = req.getSession();

        // Check if email already registered

        if (userService.emailExists(email)) {

            session.setAttribute("msg", "Email already exists!");

            resp.sendRedirect("addAdmin.jsp");

            return;

        }

        // Create new admin user

        User admin = new User();

        admin.setName(name);

        admin.setMobile(mobile);

        admin.setEmail(email);

        admin.setPassword(password);

        admin.setAddress("N/A");   // default

        admin.setUserType("admin");

        Integer id = userService.save(admin);

        if (id != null && id > 0) {

            session.setAttribute("success", "Admin added successfully!");

        } else {
            session.setAttribute("error", "Failed to register admin!");

        }

        resp.sendRedirect("addAdmin.jsp");

    }

}


