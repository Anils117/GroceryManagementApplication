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
import java.math.BigDecimal;
import java.util.List;
import java.util.Map;

/**
 * PaymentServlet handles payment processing and order creation
 */
public class PaymentServlet extends HttpServlet {
    
    private PaymentService paymentService;
    private OrderService orderService;
    
    @Override
    public void init() throws ServletException {
        paymentService = new PaymentService();
        orderService = new OrderService();
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        
        // Check if user is logged in
        if (session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        
        // Check if cart is empty
        if (CartUtils.isCartEmpty(session)) {
            response.sendRedirect(request.getContextPath() + "/cart");
            return;
        }
        
        // Validate cart items
        String cartValidation = CartUtils.validateCart(session);
        if (cartValidation != null) {
            request.setAttribute("error", cartValidation);
            request.getRequestDispatcher("/WEB-INF/views/cart.jsp").forward(request, response);
            return;
        }
        
        // Get cart details for payment page
        List<CartItem> cartItems = CartUtils.getCartItems(session);
        BigDecimal cartTotal = CartUtils.getCartTotal(session);
        
        request.setAttribute("cartItems", cartItems);
        request.setAttribute("cartTotal", cartTotal);
        request.setAttribute("formattedCartTotal", CartUtils.getFormattedCartTotal(session));
        
        // Forward to payment page
        request.getRequestDispatcher("/WEB-INF/views/payment.jsp").forward(request, response);
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
        
        // Get payment form data
        String cardNumber = request.getParameter("cardNumber");
        String expiryDate = request.getParameter("expiryDate");
        String cvv = request.getParameter("cvv");
        String cardHolderName = request.getParameter("cardHolderName");
        String shippingAddress = request.getParameter("shippingAddress");
        
        // Use user's address if shipping address is not provided
        if (shippingAddress == null || shippingAddress.trim().isEmpty()) {
            shippingAddress = user.getAddress();
        }
        
        // Get cart items and total
        List<CartItem> cartItems = CartUtils.getCartItems(session);
        BigDecimal cartTotal = CartUtils.getCartTotal(session);
        
        // Validate cart again
        String cartValidation = orderService.validateCartForOrder(cartItems);
        if (cartValidation != null) {
            request.setAttribute("error", cartValidation);
            request.setAttribute("cartItems", cartItems);
            request.setAttribute("cartTotal", cartTotal);
            request.setAttribute("formattedCartTotal", CartUtils.getFormattedCartTotal(session));
            request.getRequestDispatcher("/WEB-INF/views/payment.jsp").forward(request, response);
            return;
        }
        
        // Process payment
        Map<String, Object> paymentResult = paymentService.processPayment(
            cardNumber, expiryDate, cvv, cardHolderName, cartTotal);
        
        if ((Boolean) paymentResult.get("success")) {
            // Payment successful - create order
            String transactionId = (String) paymentResult.get("transactionId");
            String paymentMethod = (String) paymentResult.get("paymentMethod");
            
            Order order = orderService.createOrder(
                user.getUserId(), cartItems, cartTotal, shippingAddress, paymentMethod, transactionId);
            
            if (order != null) {
                // Order created successfully
                CartUtils.clearCart(session); // Clear cart after successful order
                
                // Set order details for confirmation page
                request.setAttribute("order", order);
                request.setAttribute("paymentResult", paymentResult);
                request.setAttribute("success", true);
                
                request.getRequestDispatcher("/WEB-INF/views/payment_success.jsp").forward(request, response);
            } else {
                // Order creation failed
                request.setAttribute("error", "Order creation failed. Please contact support.");
                request.setAttribute("cartItems", cartItems);
                request.setAttribute("cartTotal", cartTotal);
                request.setAttribute("formattedCartTotal", CartUtils.getFormattedCartTotal(session));
                request.getRequestDispatcher("/WEB-INF/views/payment.jsp").forward(request, response);
            }
            
        } else {
            // Payment failed
            String errorMessage = (String) paymentResult.get("error");
            request.setAttribute("error", errorMessage);
            request.setAttribute("cartItems", cartItems);
            request.setAttribute("cartTotal", cartTotal);
            request.setAttribute("formattedCartTotal", CartUtils.getFormattedCartTotal(session));
            
            // Preserve form data
            request.setAttribute("cardHolderName", cardHolderName);
            request.setAttribute("shippingAddress", shippingAddress);
            
            request.getRequestDispatcher("/WEB-INF/views/payment.jsp").forward(request, response);
        }
    }
}