package com.yash.vegmart.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

/**
 * Servlet controller for handling user logout in the VegMart system.
 * Processes HTTP GET requests to clear session attributes and invalidate session.
 * Removes cart data, user object, and redirects to homepage.
 *
 * Mapped to URL: /LogoutServlet
 *
 * @author Palak Jain
 */
@WebServlet("/LogoutServlet")
public class LogoutServlet extends HttpServlet {

    /**
     * Handles HTTP GET requests for user logout.
     * Retrieves session (false = don't create new if none exists), removes shopping cart attributes,
     * user session object, invalidates session completely, and redirects to index.jsp.
     *
     * @param request HttpServletRequest from logout link/button
     * @param response HttpServletResponse for redirecting to homepage
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an input/output error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Get existing session only (don't create new session)
        HttpSession httpSession = request.getSession(false);

        if (httpSession != null) {
            // Remove shopping cart related attributes
            httpSession.removeAttribute("cart");
            httpSession.removeAttribute("cartCount");
            httpSession.removeAttribute("cartTotal");

            // Remove user authentication
            httpSession.removeAttribute("userObj");

            // Completely invalidate session
            httpSession.invalidate();
        }

        // Redirect to homepage after logout
        response.sendRedirect("index.jsp");
    }
}
