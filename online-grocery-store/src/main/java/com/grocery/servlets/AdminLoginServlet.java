package com.grocery.servlets;

import com.grocery.services.UserService;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

/**
 * AdminLoginServlet handles admin authentication
 */
public class AdminLoginServlet extends HttpServlet {
    
    private UserService userService;
    
    @Override
    public void init() throws ServletException {
        userService = new UserService();
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // Check if admin is already logged in
        HttpSession session = request.getSession(false);
        if (session != null && session.getAttribute("admin") != null) {
            response.sendRedirect(request.getContextPath() + "/admin/dashboard");
            return;
        }
        
        // Forward to admin login page
        request.getRequestDispatcher("/WEB-INF/views/admin/login.jsp").forward(request, response);
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        
        // Validate input
        if (email == null || email.trim().isEmpty() || 
            password == null || password.trim().isEmpty()) {
            request.setAttribute("error", "Email and password are required");
            request.getRequestDispatcher("/WEB-INF/views/admin/login.jsp").forward(request, response);
            return;
        }
        
        // Authenticate admin
        boolean isValidAdmin = userService.loginAdmin(email.trim(), password);
        
        if (isValidAdmin) {
            // Admin login successful
            HttpSession session = request.getSession(true);
            session.setAttribute("admin", true);
            session.setAttribute("adminEmail", email);
            
            // Redirect to admin dashboard
            response.sendRedirect(request.getContextPath() + "/admin/dashboard");
            
        } else {
            // Admin login failed
            request.setAttribute("error", "Invalid admin credentials");
            request.setAttribute("email", email); // Preserve email for user convenience
            request.getRequestDispatcher("/WEB-INF/views/admin/login.jsp").forward(request, response);
        }
    }
}