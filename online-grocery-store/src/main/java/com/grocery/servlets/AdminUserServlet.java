package com.grocery.servlets;

import com.grocery.models.User;
import com.grocery.services.UserService;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

/**
 * AdminUserServlet handles user management for admin
 */
public class AdminUserServlet extends HttpServlet {
    
    private UserService userService;
    
    @Override
    public void init() throws ServletException {
        userService = new UserService();
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // Check if admin is logged in
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("admin") == null) {
            response.sendRedirect(request.getContextPath() + "/admin/login");
            return;
        }
        
        // Get all users
        List<User> users = userService.getAllUsers();
        request.setAttribute("users", users);
        
        // Forward to admin users page
        request.getRequestDispatcher("/WEB-INF/views/admin/users.jsp").forward(request, response);
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // Check if admin is logged in
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("admin") == null) {
            response.sendRedirect(request.getContextPath() + "/admin/login");
            return;
        }
        
        String action = request.getParameter("action");
        String userIdStr = request.getParameter("userId");
        
        if ("toggle".equals(action) && userIdStr != null) {
            // Toggle user status (activate/deactivate)
            try {
                int userId = Integer.parseInt(userIdStr);
                boolean success = userService.toggleUserStatus(userId);
                
                if (success) {
                    User user = userService.getUserById(userId);
                    String status = user.isActive() ? "activated" : "deactivated";
                    request.setAttribute("success", "User " + status + " successfully!");
                } else {
                    request.setAttribute("error", "Failed to update user status");
                }
                
            } catch (NumberFormatException e) {
                request.setAttribute("error", "Invalid user ID");
            }
            
        } else if ("delete".equals(action) && userIdStr != null) {
            // Delete user
            try {
                int userId = Integer.parseInt(userIdStr);
                boolean success = userService.deleteUser(userId);
                
                if (success) {
                    request.setAttribute("success", "User deleted successfully!");
                } else {
                    request.setAttribute("error", "Failed to delete user");
                }
                
            } catch (NumberFormatException e) {
                request.setAttribute("error", "Invalid user ID");
            }
        }
        
        // Redirect to users list
        response.sendRedirect(request.getContextPath() + "/admin/users");
    }
}