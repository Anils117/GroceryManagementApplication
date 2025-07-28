package com.grocery.servlets;

import com.grocery.models.Order;
import com.grocery.services.OrderService;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

/**
 * AdminOrderServlet handles order management in admin panel
 */
public class AdminOrderServlet extends HttpServlet {
    
    private OrderService orderService;
    
    @Override
    public void init() throws ServletException {
        orderService = new OrderService();
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        
        // Check if user is admin
        if (session.getAttribute("admin") == null) {
            response.sendRedirect(request.getContextPath() + "/admin/login");
            return;
        }
        
        try {
            // Get all orders
            List<Order> orders = orderService.getAllOrders();
            request.setAttribute("orders", orders);
            
            // Get filter parameter
            String statusFilter = request.getParameter("status");
            if (statusFilter != null && !statusFilter.isEmpty()) {
                orders = orders.stream()
                    .filter(order -> order.getStatus().toString().equals(statusFilter))
                    .collect(java.util.stream.Collectors.toList());
                request.setAttribute("orders", orders);
                request.setAttribute("statusFilter", statusFilter);
            }
            
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Error loading orders");
        }
        
        // Forward to admin orders page
        request.getRequestDispatcher("/WEB-INF/views/admin/orders.jsp").forward(request, response);
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        
        // Check if user is admin
        if (session.getAttribute("admin") == null) {
            response.sendRedirect(request.getContextPath() + "/admin/login");
            return;
        }
        
        String action = request.getParameter("action");
        String orderIdStr = request.getParameter("orderId");
        
        try {
            if ("updateStatus".equals(action) && orderIdStr != null) {
                int orderId = Integer.parseInt(orderIdStr);
                String newStatus = request.getParameter("status");
                
                boolean success = orderService.updateOrderStatus(orderId, Order.OrderStatus.valueOf(newStatus));
                
                if (success) {
                    request.setAttribute("success", "Order status updated successfully!");
                } else {
                    request.setAttribute("error", "Failed to update order status");
                }
            }
            
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Error processing request: " + e.getMessage());
        }
        
        // Redirect to refresh the page
        response.sendRedirect(request.getContextPath() + "/admin/orders");
    }
}