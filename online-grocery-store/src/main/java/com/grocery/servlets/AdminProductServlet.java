package com.grocery.servlets;

import com.grocery.models.Product;
import com.grocery.services.ProductService;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.math.BigDecimal;
import java.util.List;

/**
 * AdminProductServlet handles product management for admin
 */
public class AdminProductServlet extends HttpServlet {
    
    private ProductService productService;
    
    @Override
    public void init() throws ServletException {
        productService = new ProductService();
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
        
        String action = request.getParameter("action");
        
        if ("edit".equals(action)) {
            // Edit product form
            String productIdStr = request.getParameter("id");
            if (productIdStr != null) {
                try {
                    int productId = Integer.parseInt(productIdStr);
                    Product product = productService.getProductById(productId);
                    if (product != null) {
                        request.setAttribute("product", product);
                        request.setAttribute("categories", productService.getAllCategories());
                        request.getRequestDispatcher("/WEB-INF/views/admin/product_form.jsp").forward(request, response);
                        return;
                    }
                } catch (NumberFormatException e) {
                    // Invalid product ID
                }
            }
            response.sendRedirect(request.getContextPath() + "/admin/products");
            
        } else if ("add".equals(action)) {
            // Add product form
            request.setAttribute("categories", productService.getAllCategories());
            request.getRequestDispatcher("/WEB-INF/views/admin/product_form.jsp").forward(request, response);
            
        } else {
            // List all products
            List<Product> products = productService.getAllProductsForAdmin();
            request.setAttribute("products", products);
            request.getRequestDispatcher("/WEB-INF/views/admin/products.jsp").forward(request, response);
        }
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // Check if admin is logged in
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("admin") == null) {
            response.sendRedirect(request.getContextPath() + "/admin/login");
            return;
        }
        
        String action = request.getParameter("action");
        
        if ("save".equals(action)) {
            // Save or update product
            String productIdStr = request.getParameter("productId");
            String name = request.getParameter("name");
            String description = request.getParameter("description");
            String priceStr = request.getParameter("price");
            String category = request.getParameter("category");
            String stockStr = request.getParameter("stock");
            String imageUrl = request.getParameter("imageUrl");
            
            try {
                // Create product object
                Product product = new Product();
                product.setName(name);
                product.setDescription(description);
                product.setPrice(new BigDecimal(priceStr));
                product.setCategory(category);
                product.setStockQuantity(Integer.parseInt(stockStr));
                product.setImageUrl(imageUrl);
                
                // Validate product
                String validationError = productService.validateProduct(product);
                if (validationError != null) {
                    request.setAttribute("error", validationError);
                    request.setAttribute("product", product);
                    request.setAttribute("categories", productService.getAllCategories());
                    request.getRequestDispatcher("/WEB-INF/views/admin/product_form.jsp").forward(request, response);
                    return;
                }
                
                boolean success;
                if (productIdStr != null && !productIdStr.trim().isEmpty()) {
                    // Update existing product
                    product.setProductId(Integer.parseInt(productIdStr));
                    success = productService.updateProduct(product);
                } else {
                    // Add new product
                    success = productService.addProduct(product);
                }
                
                if (success) {
                    request.setAttribute("success", "Product saved successfully!");
                } else {
                    request.setAttribute("error", "Failed to save product");
                }
                
            } catch (NumberFormatException e) {
                request.setAttribute("error", "Invalid price or stock quantity");
            } catch (Exception e) {
                request.setAttribute("error", "Error saving product: " + e.getMessage());
            }
            
        } else if ("delete".equals(action)) {
            // Delete product
            String productIdStr = request.getParameter("productId");
            if (productIdStr != null) {
                try {
                    int productId = Integer.parseInt(productIdStr);
                    boolean success = productService.deleteProduct(productId);
                    if (success) {
                        request.setAttribute("success", "Product deleted successfully!");
                    } else {
                        request.setAttribute("error", "Failed to delete product");
                    }
                } catch (NumberFormatException e) {
                    request.setAttribute("error", "Invalid product ID");
                }
            }
        }
        
        // Redirect to product list
        response.sendRedirect(request.getContextPath() + "/admin/products");
    }
}