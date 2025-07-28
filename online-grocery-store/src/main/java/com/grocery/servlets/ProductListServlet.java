package com.grocery.servlets;

import com.grocery.models.Product;
import com.grocery.services.ProductService;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

/**
 * ProductListServlet handles product listing and filtering
 */
public class ProductListServlet extends HttpServlet {
    
    private ProductService productService;
    
    @Override
    public void init() throws ServletException {
        productService = new ProductService();
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String searchTerm = request.getParameter("search");
        String category = request.getParameter("category");
        
        // Get filtered products
        List<Product> products;
        if ((searchTerm != null && !searchTerm.trim().isEmpty()) || 
            (category != null && !category.trim().isEmpty() && !"All".equalsIgnoreCase(category))) {
            products = productService.filterProducts(searchTerm, category);
        } else {
            products = productService.getAllProducts();
        }
        
        // Get all categories for filter dropdown
        List<String> categories = productService.getAllCategories();
        
        // Set attributes for JSP
        request.setAttribute("products", products);
        request.setAttribute("categories", categories);
        request.setAttribute("selectedCategory", category);
        request.setAttribute("searchTerm", searchTerm);
        
        // Forward to product list page
        request.getRequestDispatcher("/WEB-INF/views/product_list.jsp").forward(request, response);
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        doGet(request, response);
    }
}