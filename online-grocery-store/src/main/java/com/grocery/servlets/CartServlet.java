package com.grocery.servlets;

import com.grocery.models.CartItem;
import com.grocery.models.Product;
import com.grocery.services.ProductService;
import com.grocery.utils.CartUtils;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

/**
 * CartServlet handles shopping cart operations
 */
public class CartServlet extends HttpServlet {
    
    private ProductService productService;
    
    @Override
    public void init() throws ServletException {
        productService = new ProductService();
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String action = request.getParameter("action");
        HttpSession session = request.getSession();
        
        if ("view".equals(action) || action == null) {
            // Display cart
            List<CartItem> cartItems = CartUtils.getCartItems(session);
            request.setAttribute("cartItems", cartItems);
            request.setAttribute("cartTotal", CartUtils.getFormattedCartTotal(session));
            request.setAttribute("cartItemCount", CartUtils.getCartItemCount(session));
            
            request.getRequestDispatcher("/WEB-INF/views/cart.jsp").forward(request, response);
            
        } else if ("remove".equals(action)) {
            // Remove item from cart
            String productIdStr = request.getParameter("productId");
            if (productIdStr != null) {
                try {
                    int productId = Integer.parseInt(productIdStr);
                    CartUtils.removeFromCart(session, productId);
                } catch (NumberFormatException e) {
                    // Invalid product ID
                }
            }
            response.sendRedirect(request.getContextPath() + "/cart");
            
        } else if ("clear".equals(action)) {
            // Clear entire cart
            CartUtils.clearCart(session);
            response.sendRedirect(request.getContextPath() + "/cart");
        }
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String action = request.getParameter("action");
        HttpSession session = request.getSession();
        
        // Check if user is logged in
        if (session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/login?redirect=" + 
                                request.getContextPath() + "/cart");
            return;
        }
        
        if ("add".equals(action)) {
            // Add item to cart
            String productIdStr = request.getParameter("productId");
            String quantityStr = request.getParameter("quantity");
            
            if (productIdStr != null && quantityStr != null) {
                try {
                    int productId = Integer.parseInt(productIdStr);
                    int quantity = Integer.parseInt(quantityStr);
                    
                    if (quantity > 0) {
                        Product product = productService.getProductById(productId);
                        if (product != null && product.isActive()) {
                            // Check stock availability
                            if (productService.isProductInStock(productId, quantity)) {
                                CartUtils.addToCart(session, product, quantity);
                                request.setAttribute("success", "Product added to cart successfully!");
                            } else {
                                request.setAttribute("error", "Insufficient stock available");
                            }
                        } else {
                            request.setAttribute("error", "Product not found or unavailable");
                        }
                    } else {
                        request.setAttribute("error", "Invalid quantity");
                    }
                } catch (NumberFormatException e) {
                    request.setAttribute("error", "Invalid product or quantity");
                }
            }
            
            // Redirect back to products page
            response.sendRedirect(request.getContextPath() + "/products");
            
        } else if ("update".equals(action)) {
            // Update cart item quantity
            String productIdStr = request.getParameter("productId");
            String quantityStr = request.getParameter("quantity");
            
            if (productIdStr != null && quantityStr != null) {
                try {
                    int productId = Integer.parseInt(productIdStr);
                    int quantity = Integer.parseInt(quantityStr);
                    
                    if (quantity >= 0) {
                        // Check stock if increasing quantity
                        if (quantity > 0) {
                            Product product = productService.getProductById(productId);
                            if (product != null && !productService.isProductInStock(productId, quantity)) {
                                request.setAttribute("error", "Insufficient stock available");
                                doGet(request, response);
                                return;
                            }
                        }
                        
                        CartUtils.updateCartItem(session, productId, quantity);
                    }
                } catch (NumberFormatException e) {
                    // Invalid input
                }
            }
            
            response.sendRedirect(request.getContextPath() + "/cart");
        }
    }
}