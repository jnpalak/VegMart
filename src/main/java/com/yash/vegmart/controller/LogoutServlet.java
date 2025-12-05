package com.yash.vegmart.controller;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/LogoutServlet")
public class LogoutServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession httpSession = request.getSession(false);
        if(httpSession!=null) {
            httpSession.removeAttribute("cart");
            httpSession.removeAttribute("cartCount");
            httpSession.removeAttribute("cartTotal");
            httpSession.removeAttribute("userObj");
            httpSession.invalidate();
        }
        response.sendRedirect("index.jsp");

    }
}