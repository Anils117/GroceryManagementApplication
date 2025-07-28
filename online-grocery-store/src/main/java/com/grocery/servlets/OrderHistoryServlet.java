package com.grocery.servlets;

import com.grocery.models.*;
import com.grocery.services.OrderService;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

/**
 * OrderHistoryServlet handles displaying user's order history
 */
public class OrderHistoryServlet extends HttpServlet {
    
    private OrderService orderService;
    
    @Override
    public void init() throws ServletException {
        orderService = new OrderService();
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        
        // Check if user is logged in
        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login?redirect=" + 
                                request.getContextPath() + "/order-history");
            return;
        }
        
        try {
            // Get user's orders
            List<Order> orders = orderService.getOrdersByUser(user.getUserId());
            request.setAttribute("orders", orders);
            
            // Forward to order history page
            request.getRequestDispatcher("/WEB-INF/views/order_history.jsp").forward(request, response);
            
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Error loading order history");
            request.getRequestDispatcher("/WEB-INF/views/order_history.jsp").forward(request, response);
        }
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        
        // Check if user is logged in
        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        
        String action = request.getParameter("action");
        String orderIdStr = request.getParameter("orderId");
        
        if ("cancel".equals(action) && orderIdStr != null) {
            try {
                int orderId = Integer.parseInt(orderIdStr);
                boolean success = orderService.cancelOrder(orderId, user.getUserId());
                
                if (success) {
                    request.setAttribute("success", "Order cancelled successfully!");
                } else {
                    request.setAttribute("error", "Unable to cancel order. Order may have already been shipped.");
                }
                
            } catch (NumberFormatException e) {
                request.setAttribute("error", "Invalid order ID");
            }
        }
        
        // Redirect to order history to refresh the page
        response.sendRedirect(request.getContextPath() + "/order-history");
    }
}