package com.grocery.services;

import com.grocery.models.*;
import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.*;
import java.util.concurrent.atomic.AtomicInteger;
import java.util.stream.Collectors;

/**
 * OrderService class for managing order operations
 * Uses in-memory storage for demo purposes - replace with database in production
 */
public class OrderService {
    
    // In-memory storage (replace with database in production)
    private static final Map<Integer, Order> orders = new HashMap<>();
    private static final AtomicInteger orderIdCounter = new AtomicInteger(1001); // Start with 1001
    
    private final ProductService productService;
    
    public OrderService() {
        this.productService = new ProductService();
    }
    
    /**
     * Create a new order from cart items
     */
    public Order createOrder(int userId, List<CartItem> cartItems, String shippingAddress, 
                           String paymentMethod, String transactionId) {
        try {
            // Convert cart items to order items
            List<OrderItem> orderItems = cartItems.stream()
                    .map(OrderItem::new)
                    .collect(Collectors.toList());
            
            // Calculate total amount
            BigDecimal totalAmount = cartItems.stream()
                    .map(CartItem::getTotalPrice)
                    .reduce(BigDecimal.ZERO, BigDecimal::add);
            
            // Create order
            Order order = new Order(userId, orderItems, totalAmount, shippingAddress, paymentMethod);
            order.setOrderId(orderIdCounter.getAndIncrement());
            order.setTransactionId(transactionId);
            order.setStatus(Order.OrderStatus.CONFIRMED);
            
            // Update product stock
            for (CartItem cartItem : cartItems) {
                productService.updateProductStock(
                    cartItem.getProduct().getProductId(), 
                    cartItem.getQuantity()
                );
            }
            
            // Store order
            orders.put(order.getOrderId(), order);
            
            return order;
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }
    
    /**
     * Get order by ID
     */
    public Order getOrderById(int orderId) {
        return orders.get(orderId);
    }
    
    /**
     * Get all orders for a user
     */
    public List<Order> getOrdersByUser(int userId) {
        return orders.values().stream()
                .filter(order -> order.getUserId() == userId)
                .sorted((o1, o2) -> o2.getOrderDate().compareTo(o1.getOrderDate())) // Latest first
                .collect(Collectors.toList());
    }
    
    /**
     * Get all orders (for admin)
     */
    public List<Order> getAllOrders() {
        return orders.values().stream()
                .sorted((o1, o2) -> o2.getOrderDate().compareTo(o1.getOrderDate())) // Latest first
                .collect(Collectors.toList());
    }
    
    /**
     * Update order status
     */
    public boolean updateOrderStatus(int orderId, Order.OrderStatus newStatus) {
        try {
            Order order = orders.get(orderId);
            if (order != null) {
                order.setStatus(newStatus);
                
                // Set delivery date if order is delivered
                if (newStatus == Order.OrderStatus.DELIVERED) {
                    order.setDeliveryDate(LocalDateTime.now());
                }
                
                return true;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }
    
    /**
     * Cancel order
     */
    public boolean cancelOrder(int orderId, int userId) {
        try {
            Order order = orders.get(orderId);
            if (order != null && order.getUserId() == userId) {
                // Only allow cancellation if order is not shipped or delivered
                if (order.getStatus() == Order.OrderStatus.PENDING || 
                    order.getStatus() == Order.OrderStatus.CONFIRMED ||
                    order.getStatus() == Order.OrderStatus.PROCESSING) {
                    
                    order.setStatus(Order.OrderStatus.CANCELLED);
                    
                    // Restore product stock
                    for (OrderItem item : order.getOrderItems()) {
                        Product product = productService.getProductById(item.getProductId());
                        if (product != null) {
                            product.setStockQuantity(product.getStockQuantity() + item.getQuantity());
                        }
                    }
                    
                    return true;
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }
    
    /**
     * Track order - get order status and tracking info
     */
    public Map<String, Object> trackOrder(int orderId, int userId) {
        Map<String, Object> trackingInfo = new HashMap<>();
        
        try {
            Order order = orders.get(orderId);
            if (order != null && order.getUserId() == userId) {
                trackingInfo.put("order", order);
                trackingInfo.put("status", order.getStatus());
                trackingInfo.put("orderDate", order.getOrderDate());
                trackingInfo.put("estimatedDelivery", getEstimatedDeliveryDate(order));
                trackingInfo.put("trackingSteps", getTrackingSteps(order));
                return trackingInfo;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        
        return null;
    }
    
    /**
     * Get estimated delivery date
     */
    private LocalDateTime getEstimatedDeliveryDate(Order order) {
        // Simple logic: 3-5 business days from order date
        LocalDateTime estimatedDate = order.getOrderDate().plusDays(4);
        
        if (order.getStatus() == Order.OrderStatus.DELIVERED && order.getDeliveryDate() != null) {
            return order.getDeliveryDate();
        }
        
        return estimatedDate;
    }
    
    /**
     * Get tracking steps for display
     */
    private List<Map<String, Object>> getTrackingSteps(Order order) {
        List<Map<String, Object>> steps = new ArrayList<>();
        
        // Order Placed
        Map<String, Object> step1 = new HashMap<>();
        step1.put("title", "Order Placed");
        step1.put("description", "Your order has been placed successfully");
        step1.put("completed", true);
        step1.put("date", order.getOrderDate());
        steps.add(step1);
        
        // Order Confirmed
        Map<String, Object> step2 = new HashMap<>();
        step2.put("title", "Order Confirmed");
        step2.put("description", "Your order has been confirmed and is being prepared");
        step2.put("completed", order.getStatus().ordinal() >= Order.OrderStatus.CONFIRMED.ordinal());
        step2.put("date", order.getOrderDate().plusMinutes(30)); // Dummy date
        steps.add(step2);
        
        // Processing
        Map<String, Object> step3 = new HashMap<>();
        step3.put("title", "Processing");
        step3.put("description", "Your order is being processed and packed");
        step3.put("completed", order.getStatus().ordinal() >= Order.OrderStatus.PROCESSING.ordinal());
        step3.put("date", order.getOrderDate().plusHours(2)); // Dummy date
        steps.add(step3);
        
        // Shipped
        Map<String, Object> step4 = new HashMap<>();
        step4.put("title", "Shipped");
        step4.put("description", "Your order has been shipped and is on the way");
        step4.put("completed", order.getStatus().ordinal() >= Order.OrderStatus.SHIPPED.ordinal());
        step4.put("date", order.getOrderDate().plusDays(1)); // Dummy date
        steps.add(step4);
        
        // Delivered
        Map<String, Object> step5 = new HashMap<>();
        step5.put("title", "Delivered");
        step5.put("description", "Your order has been delivered successfully");
        step5.put("completed", order.getStatus() == Order.OrderStatus.DELIVERED);
        step5.put("date", order.getDeliveryDate() != null ? order.getDeliveryDate() : getEstimatedDeliveryDate(order));
        steps.add(step5);
        
        return steps;
    }
    
    /**
     * Get order statistics (for admin dashboard)
     */
    public Map<String, Object> getOrderStatistics() {
        Map<String, Object> stats = new HashMap<>();
        
        List<Order> allOrders = getAllOrders();
        
        stats.put("totalOrders", allOrders.size());
        stats.put("pendingOrders", allOrders.stream()
                .filter(o -> o.getStatus() == Order.OrderStatus.PENDING).count());
        stats.put("confirmedOrders", allOrders.stream()
                .filter(o -> o.getStatus() == Order.OrderStatus.CONFIRMED).count());
        stats.put("shippedOrders", allOrders.stream()
                .filter(o -> o.getStatus() == Order.OrderStatus.SHIPPED).count());
        stats.put("deliveredOrders", allOrders.stream()
                .filter(o -> o.getStatus() == Order.OrderStatus.DELIVERED).count());
        stats.put("cancelledOrders", allOrders.stream()
                .filter(o -> o.getStatus() == Order.OrderStatus.CANCELLED).count());
        
        BigDecimal totalRevenue = allOrders.stream()
                .filter(o -> o.getStatus() != Order.OrderStatus.CANCELLED)
                .map(Order::getTotalAmount)
                .reduce(BigDecimal.ZERO, BigDecimal::add);
        stats.put("totalRevenue", totalRevenue);
        
        return stats;
    }
    
    /**
     * Validate cart items before creating order
     */
    public String validateCartForOrder(List<CartItem> cartItems) {
        if (cartItems == null || cartItems.isEmpty()) {
            return "Cart is empty";
        }
        
        for (CartItem item : cartItems) {
            Product product = productService.getProductById(item.getProduct().getProductId());
            if (product == null || !product.isActive()) {
                return "Product " + item.getProduct().getName() + " is no longer available";
            }
            if (!productService.isProductInStock(product.getProductId(), item.getQuantity())) {
                return "Insufficient stock for " + product.getName() + 
                       ". Available: " + product.getStockQuantity() + 
                       ", Requested: " + item.getQuantity();
            }
        }
        
        return null; // Valid
    }
}