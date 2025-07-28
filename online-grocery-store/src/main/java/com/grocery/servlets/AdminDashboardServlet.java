package com.grocery.servlets;

import com.grocery.services.*;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.Map;

/**
 * AdminDashboardServlet handles admin dashboard display
 */
public class AdminDashboardServlet extends HttpServlet {
    
    private UserService userService;
    private ProductService productService;
    private OrderService orderService;
    
    @Override
    public void init() throws ServletException {
        userService = new UserService();
        productService = new ProductService();
        orderService = new OrderService();
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
        
        // Get statistics for dashboard
        try {
            // User statistics
            int totalUsers = userService.getAllUsers().size();
            long activeUsers = userService.getAllUsers().stream().filter(u -> u.isActive()).count();
            
            // Product statistics
            int totalProducts = productService.getAllProductsForAdmin().size();
            long activeProducts = productService.getAllProducts().size();
            long lowStockProducts = productService.getAllProducts().stream()
                    .filter(p -> p.getStockQuantity() <= 5 && p.getStockQuantity() > 0).count();
            long outOfStockProducts = productService.getAllProducts().stream()
                    .filter(p -> p.getStockQuantity() == 0).count();
            
            // Order statistics
            Map<String, Object> orderStats = orderService.getOrderStatistics();
            
            // Set attributes for JSP
            request.setAttribute("totalUsers", totalUsers);
            request.setAttribute("activeUsers", activeUsers);
            request.setAttribute("totalProducts", totalProducts);
            request.setAttribute("activeProducts", activeProducts);
            request.setAttribute("lowStockProducts", lowStockProducts);
            request.setAttribute("outOfStockProducts", outOfStockProducts);
            request.setAttribute("orderStats", orderStats);
            
            // Recent data
            request.setAttribute("recentOrders", orderService.getAllOrders().stream().limit(5).toArray());
            request.setAttribute("recentUsers", userService.getAllUsers().stream().limit(5).toArray());
            
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Error loading dashboard data");
        }
        
        // Forward to admin dashboard page
        request.getRequestDispatcher("/WEB-INF/views/admin/dashboard.jsp").forward(request, response);
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        doGet(request, response);
    }
}