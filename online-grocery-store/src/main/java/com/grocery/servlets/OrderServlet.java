package com.grocery.servlets;

import com.grocery.models.*;
import com.grocery.services.*;
import com.grocery.utils.CartUtils;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

/**
 * OrderServlet handles order placement and management
 */
public class OrderServlet extends HttpServlet {
    
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
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        
        String action = request.getParameter("action");
        
        if ("checkout".equals(action)) {
            // Show checkout page
            List<CartItem> cartItems = CartUtils.getCartItems(session);
            
            if (cartItems.isEmpty()) {
                response.sendRedirect(request.getContextPath() + "/cart");
                return;
            }
            
            // Validate cart
            String cartValidation = CartUtils.validateCart(session);
            if (cartValidation != null) {
                request.setAttribute("error", cartValidation);
                request.getRequestDispatcher("/WEB-INF/views/cart.jsp").forward(request, response);
                return;
            }
            
            request.setAttribute("cartItems", cartItems);
            request.setAttribute("cartTotal", CartUtils.getFormattedCartTotal(session));
            request.setAttribute("user", user);
            
            request.getRequestDispatcher("/WEB-INF/views/checkout.jsp").forward(request, response);
            
        } else {
            // Redirect to cart by default
            response.sendRedirect(request.getContextPath() + "/cart");
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
        
        if ("place".equals(action)) {
            // Place order - redirect to payment
            List<CartItem> cartItems = CartUtils.getCartItems(session);
            
            if (cartItems.isEmpty()) {
                response.sendRedirect(request.getContextPath() + "/cart");
                return;
            }
            
            // Validate cart
            String cartValidation = orderService.validateCartForOrder(cartItems);
            if (cartValidation != null) {
                request.setAttribute("error", cartValidation);
                request.setAttribute("cartItems", cartItems);
                request.setAttribute("cartTotal", CartUtils.getFormattedCartTotal(session));
                request.setAttribute("user", user);
                request.getRequestDispatcher("/WEB-INF/views/checkout.jsp").forward(request, response);
                return;
            }
            
            // Redirect to payment page
            response.sendRedirect(request.getContextPath() + "/payment");
        }
    }
}