package com.grocery.services;

import com.grocery.models.Product;
import java.math.BigDecimal;
import java.util.*;
import java.util.concurrent.atomic.AtomicInteger;
import java.util.stream.Collectors;

/**
 * ProductService class for managing product operations
 * Uses in-memory storage for demo purposes - replace with database in production
 */
public class ProductService {
    
    // In-memory storage (replace with database in production)
    private static final Map<Integer, Product> products = new HashMap<>();
    private static final AtomicInteger productIdCounter = new AtomicInteger(1);
    
    static {
        // Initialize with dummy products for testing
        initializeDummyProducts();
    }
    
    /**
     * Initialize dummy products for testing
     */
    private static void initializeDummyProducts() {
        // Fruits & Vegetables
        addDummyProduct("Fresh Apples", "Red delicious apples - 1 lb", new BigDecimal("3.99"), 
                       "Fruits & Vegetables", 50, "https://via.placeholder.com/200x200?text=Apples");
        addDummyProduct("Bananas", "Fresh bananas - 1 bunch", new BigDecimal("2.49"), 
                       "Fruits & Vegetables", 75, "https://via.placeholder.com/200x200?text=Bananas");
        addDummyProduct("Carrots", "Fresh carrots - 2 lbs", new BigDecimal("1.99"), 
                       "Fruits & Vegetables", 30, "https://via.placeholder.com/200x200?text=Carrots");
        addDummyProduct("Spinach", "Fresh spinach leaves - 1 bunch", new BigDecimal("2.99"), 
                       "Fruits & Vegetables", 25, "https://via.placeholder.com/200x200?text=Spinach");
        
        // Dairy & Eggs
        addDummyProduct("Whole Milk", "Fresh whole milk - 1 gallon", new BigDecimal("4.49"), 
                       "Dairy & Eggs", 40, "https://via.placeholder.com/200x200?text=Milk");
        addDummyProduct("Eggs", "Farm fresh eggs - 12 count", new BigDecimal("3.99"), 
                       "Dairy & Eggs", 60, "https://via.placeholder.com/200x200?text=Eggs");
        addDummyProduct("Cheddar Cheese", "Sharp cheddar cheese - 8 oz", new BigDecimal("4.99"), 
                       "Dairy & Eggs", 35, "https://via.placeholder.com/200x200?text=Cheese");
        
        // Meat & Seafood
        addDummyProduct("Chicken Breast", "Boneless chicken breast - 1 lb", new BigDecimal("6.99"), 
                       "Meat & Seafood", 20, "https://via.placeholder.com/200x200?text=Chicken");
        addDummyProduct("Ground Beef", "85% lean ground beef - 1 lb", new BigDecimal("5.99"), 
                       "Meat & Seafood", 25, "https://via.placeholder.com/200x200?text=Beef");
        addDummyProduct("Salmon Fillet", "Fresh salmon fillet - 1 lb", new BigDecimal("12.99"), 
                       "Meat & Seafood", 15, "https://via.placeholder.com/200x200?text=Salmon");
        
        // Bakery
        addDummyProduct("Whole Wheat Bread", "Fresh whole wheat bread loaf", new BigDecimal("2.99"), 
                       "Bakery", 45, "https://via.placeholder.com/200x200?text=Bread");
        addDummyProduct("Croissants", "Butter croissants - 6 pack", new BigDecimal("4.99"), 
                       "Bakery", 20, "https://via.placeholder.com/200x200?text=Croissants");
        
        // Pantry
        addDummyProduct("Rice", "Long grain white rice - 2 lbs", new BigDecimal("3.49"), 
                       "Pantry", 80, "https://via.placeholder.com/200x200?text=Rice");
        addDummyProduct("Pasta", "Spaghetti pasta - 1 lb", new BigDecimal("1.99"), 
                       "Pantry", 100, "https://via.placeholder.com/200x200?text=Pasta");
        addDummyProduct("Olive Oil", "Extra virgin olive oil - 16.9 fl oz", new BigDecimal("7.99"), 
                       "Pantry", 30, "https://via.placeholder.com/200x200?text=Oil");
    }
    
    private static void addDummyProduct(String name, String description, BigDecimal price, 
                                      String category, int stock, String imageUrl) {
        Product product = new Product(name, description, price, category, stock, imageUrl);
        product.setProductId(productIdCounter.getAndIncrement());
        products.put(product.getProductId(), product);
    }
    
    /**
     * Add a new product
     */
    public boolean addProduct(Product product) {
        try {
            product.setProductId(productIdCounter.getAndIncrement());
            products.put(product.getProductId(), product);
            return true;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
    
    /**
     * Get all products
     */
    public List<Product> getAllProducts() {
        return products.values().stream()
                .filter(Product::isActive)
                .collect(Collectors.toList());
    }
    
    /**
     * Get all products (including inactive for admin)
     */
    public List<Product> getAllProductsForAdmin() {
        return new ArrayList<>(products.values());
    }
    
    /**
     * Get product by ID
     */
    public Product getProductById(int productId) {
        return products.get(productId);
    }
    
    /**
     * Update product
     */
    public boolean updateProduct(Product product) {
        try {
            if (products.containsKey(product.getProductId())) {
                products.put(product.getProductId(), product);
                return true;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }
    
    /**
     * Delete product (soft delete - mark as inactive)
     */
    public boolean deleteProduct(int productId) {
        try {
            Product product = products.get(productId);
            if (product != null) {
                product.setActive(false);
                return true;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }
    
    /**
     * Search products by name or description
     */
    public List<Product> searchProducts(String searchTerm) {
        if (searchTerm == null || searchTerm.trim().isEmpty()) {
            return getAllProducts();
        }
        
        String lowerSearchTerm = searchTerm.toLowerCase();
        return products.values().stream()
                .filter(Product::isActive)
                .filter(product -> 
                    product.getName().toLowerCase().contains(lowerSearchTerm) ||
                    product.getDescription().toLowerCase().contains(lowerSearchTerm))
                .collect(Collectors.toList());
    }
    
    /**
     * Get products by category
     */
    public List<Product> getProductsByCategory(String category) {
        if (category == null || category.trim().isEmpty() || "All".equalsIgnoreCase(category)) {
            return getAllProducts();
        }
        
        return products.values().stream()
                .filter(Product::isActive)
                .filter(product -> category.equalsIgnoreCase(product.getCategory()))
                .collect(Collectors.toList());
    }
    
    /**
     * Get all categories
     */
    public List<String> getAllCategories() {
        return products.values().stream()
                .filter(Product::isActive)
                .map(Product::getCategory)
                .distinct()
                .sorted()
                .collect(Collectors.toList());
    }
    
    /**
     * Filter products by search term and category
     */
    public List<Product> filterProducts(String searchTerm, String category) {
        List<Product> filteredProducts = getAllProducts();
        
        // Filter by category first
        if (category != null && !category.trim().isEmpty() && !"All".equalsIgnoreCase(category)) {
            filteredProducts = filteredProducts.stream()
                    .filter(product -> category.equalsIgnoreCase(product.getCategory()))
                    .collect(Collectors.toList());
        }
        
        // Then filter by search term
        if (searchTerm != null && !searchTerm.trim().isEmpty()) {
            String lowerSearchTerm = searchTerm.toLowerCase();
            filteredProducts = filteredProducts.stream()
                    .filter(product -> 
                        product.getName().toLowerCase().contains(lowerSearchTerm) ||
                        product.getDescription().toLowerCase().contains(lowerSearchTerm))
                    .collect(Collectors.toList());
        }
        
        return filteredProducts;
    }
    
    /**
     * Update product stock
     */
    public boolean updateProductStock(int productId, int quantity) {
        try {
            Product product = products.get(productId);
            if (product != null) {
                product.setStockQuantity(Math.max(0, product.getStockQuantity() - quantity));
                return true;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }
    
    /**
     * Check if product is in stock
     */
    public boolean isProductInStock(int productId, int requestedQuantity) {
        Product product = products.get(productId);
        return product != null && product.isActive() && product.getStockQuantity() >= requestedQuantity;
    }
    
    /**
     * Validate product input
     */
    public String validateProduct(Product product) {
        if (product.getName() == null || product.getName().trim().isEmpty()) {
            return "Product name is required";
        }
        if (product.getDescription() == null || product.getDescription().trim().isEmpty()) {
            return "Product description is required";
        }
        if (product.getPrice() == null || product.getPrice().compareTo(BigDecimal.ZERO) <= 0) {
            return "Product price must be greater than 0";
        }
        if (product.getCategory() == null || product.getCategory().trim().isEmpty()) {
            return "Product category is required";
        }
        if (product.getStockQuantity() < 0) {
            return "Stock quantity cannot be negative";
        }
        return null; // Valid
    }
}