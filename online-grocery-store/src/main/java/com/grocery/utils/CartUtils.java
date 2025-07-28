package com.grocery.utils;

import com.grocery.models.CartItem;
import com.grocery.models.Product;
import javax.servlet.http.HttpSession;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;

/**
 * Utility class for cart management operations
 */
public class CartUtils {
    
    private static final String CART_SESSION_KEY = "cart";
    
    /**
     * Get cart items from session
     */
    @SuppressWarnings("unchecked")
    public static List<CartItem> getCartItems(HttpSession session) {
        List<CartItem> cartItems = (List<CartItem>) session.getAttribute(CART_SESSION_KEY);
        if (cartItems == null) {
            cartItems = new ArrayList<>();
            session.setAttribute(CART_SESSION_KEY, cartItems);
        }
        return cartItems;
    }
    
    /**
     * Add item to cart
     */
    public static boolean addToCart(HttpSession session, Product product, int quantity) {
        try {
            List<CartItem> cartItems = getCartItems(session);
            
            // Check if product already exists in cart
            for (CartItem item : cartItems) {
                if (item.getProduct().getProductId() == product.getProductId()) {
                    // Update quantity
                    item.setQuantity(item.getQuantity() + quantity);
                    return true;
                }
            }
            
            // Add new item to cart
            CartItem newItem = new CartItem(product, quantity);
            cartItems.add(newItem);
            return true;
            
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
    
    /**
     * Update item quantity in cart
     */
    public static boolean updateCartItem(HttpSession session, int productId, int newQuantity) {
        try {
            List<CartItem> cartItems = getCartItems(session);
            
            for (CartItem item : cartItems) {
                if (item.getProduct().getProductId() == productId) {
                    if (newQuantity <= 0) {
                        cartItems.remove(item);
                    } else {
                        item.setQuantity(newQuantity);
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
     * Remove item from cart
     */
    public static boolean removeFromCart(HttpSession session, int productId) {
        try {
            List<CartItem> cartItems = getCartItems(session);
            
            cartItems.removeIf(item -> item.getProduct().getProductId() == productId);
            return true;
            
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
    
    /**
     * Clear entire cart
     */
    public static void clearCart(HttpSession session) {
        session.removeAttribute(CART_SESSION_KEY);
    }
    
    /**
     * Get total number of items in cart
     */
    public static int getCartItemCount(HttpSession session) {
        List<CartItem> cartItems = getCartItems(session);
        return cartItems.stream().mapToInt(CartItem::getQuantity).sum();
    }
    
    /**
     * Get cart total amount
     */
    public static BigDecimal getCartTotal(HttpSession session) {
        List<CartItem> cartItems = getCartItems(session);
        return cartItems.stream()
                .map(CartItem::getTotalPrice)
                .reduce(BigDecimal.ZERO, BigDecimal::add);
    }
    
    /**
     * Check if cart is empty
     */
    public static boolean isCartEmpty(HttpSession session) {
        List<CartItem> cartItems = getCartItems(session);
        return cartItems.isEmpty();
    }
    
    /**
     * Get formatted cart total
     */
    public static String getFormattedCartTotal(HttpSession session) {
        return "$" + getCartTotal(session).toString();
    }
    
    /**
     * Validate cart items (check stock availability)
     */
    public static String validateCart(HttpSession session) {
        List<CartItem> cartItems = getCartItems(session);
        
        if (cartItems.isEmpty()) {
            return "Cart is empty";
        }
        
        for (CartItem item : cartItems) {
            Product product = item.getProduct();
            if (!product.isActive()) {
                return "Product " + product.getName() + " is no longer available";
            }
            if (item.getQuantity() > product.getStockQuantity()) {
                return "Insufficient stock for " + product.getName() + 
                       ". Available: " + product.getStockQuantity() + 
                       ", In cart: " + item.getQuantity();
            }
        }
        
        return null; // Valid
    }
}