package com.grocery.servlets;

import com.grocery.models.User;
import com.grocery.services.OrderService;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.Map;

/**
 * OrderTrackingServlet handles order tracking functionality
 */
public class OrderTrackingServlet extends HttpServlet {
    
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
                                request.getContextPath() + "/track-order");
            return;
        }
        
        String orderIdStr = request.getParameter("orderId");
        
        if (orderIdStr != null) {
            try {
                int orderId = Integer.parseInt(orderIdStr);
                
                // Get tracking information
                Map<String, Object> trackingInfo = orderService.trackOrder(orderId, user.getUserId());
                
                if (trackingInfo != null) {
                    request.setAttribute("trackingInfo", trackingInfo);
                    request.setAttribute("orderId", orderId);
                } else {
                    request.setAttribute("error", "Order not found or access denied");
                }
                
            } catch (NumberFormatException e) {
                request.setAttribute("error", "Invalid order ID format");
            }
        }
        
        // Forward to order tracking page
        request.getRequestDispatcher("/WEB-INF/views/order_tracking.jsp").forward(request, response);
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
        
        String orderIdStr = request.getParameter("orderId");
        
        if (orderIdStr != null && !orderIdStr.trim().isEmpty()) {
            // Redirect to GET with order ID parameter
            response.sendRedirect(request.getContextPath() + "/track-order?orderId=" + orderIdStr.trim());
        } else {
            request.setAttribute("error", "Please enter a valid order ID");
            request.getRequestDispatcher("/WEB-INF/views/order_tracking.jsp").forward(request, response);
        }
    }
}