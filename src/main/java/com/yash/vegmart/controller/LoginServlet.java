package com.yash.vegmart.controller;
import com.yash.vegmart.entity.User;
import com.yash.vegmart.service.UserService;
import com.yash.vegmart.serviceimpl.UserServiceImpl;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import java.io.IOException;

import static java.lang.System.out;

@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet
{

    private UserService userService;

    @Override
    public void init() {
        userService = new UserServiceImpl();  // DAO object
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException
    {
        String email=request.getParameter("email");
        String password=request.getParameter("password");
        User user= userService.loginUser(email,password);
        HttpSession session= request.getSession();
        if(user!=null)
        {
            session.setAttribute("userObj",user);
            if(user.getUserType().equals("admin"))
            {
                response.sendRedirect("admin.jsp");
            }
            else if(user.getUserType().equals("normal"))
            {
                response.sendRedirect("index.jsp");
            }
            else {
                out.println("we have not identified user type");
            }
        }
        else {
            request.setAttribute("errorMsg","Invalid email or Password");
            request.getRequestDispatcher("login.jsp").forward(request,response);
        }
    }
    }