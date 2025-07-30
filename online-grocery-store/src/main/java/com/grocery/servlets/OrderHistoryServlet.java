package com.grocery.servlets;

import com.grocery.models.*;
import com.grocery.services.OrderService;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.math.BigDecimal;
import java.util.Arrays;
import java.util.List;
import java.util.ArrayList;

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

            List<Order> dummyOrders = new ArrayList<>();
            List<OrderItem> items1 = Arrays.asList(
                    new OrderItem(101, "Apples", new BigDecimal("30.00"), 2),
                    new OrderItem(102, "Bananas", new BigDecimal("10.00"), 6),
                    new OrderItem(103, "Carrots", new BigDecimal("15.00"), 3)
            );
            Order order1 = new Order(1, items1, new BigDecimal("180.00"), "123 Green Street", "COD");
            order1.setOrderId(1001);
            order1.setStatus(Order.OrderStatus.DELIVERED);
            List<OrderItem> items2 = Arrays.asList(
                    new OrderItem(104, "Milk", new BigDecimal("25.00"), 2),
                    new OrderItem(105, "Eggs", new BigDecimal("5.00"), 12),
                    new OrderItem(106, "Bread", new BigDecimal("20.00"), 1),
                    new OrderItem(107, "Butter", new BigDecimal("45.00"), 1)
            );
            Order order2 = new Order(1, items2, new BigDecimal("240.00"), "456 Blue Avenue", "UPI");
            order2.setOrderId(1002);
            order2.setStatus(Order.OrderStatus.PENDING);

            dummyOrders.add(order1);
            dummyOrders.add(order2);

            request.setAttribute("orders", dummyOrders);
            request.getRequestDispatcher("/WEB-INF/views/order_history.jsp").forward(request, response);

            // Get user's orders
//            System.out.println("Loading order history for user: " + user.getUserId());
//            List<Order> orders = orderService.getOrdersByUser(user.getUserId());
//            System.out.println("Found " + orders.size() + " orders for user: " + user.getUserId());
//            request.setAttribute("orders", orders);
//
//            // Forward to order history page
//            request.getRequestDispatcher("/WEB-INF/views/order_history.jsp").forward(request, response);
            
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Error loading order history: " + e.getMessage());
            request.setAttribute("orders", new ArrayList<>());
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