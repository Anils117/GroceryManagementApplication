package com.grocery.servlets;

import com.grocery.models.User;
import com.grocery.services.UserService;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

/**
 * RegisterServlet handles user registration
 */
public class RegisterServlet extends HttpServlet {
    
    private UserService userService;
    
    @Override
    public void init() throws ServletException {
        userService = new UserService();
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // Check if user is already logged in
        HttpSession session = request.getSession(false);
        if (session != null && session.getAttribute("user") != null) {
            response.sendRedirect(request.getContextPath() + "/products");
            return;
        }
        
        // Forward to registration page
        request.getRequestDispatcher("/WEB-INF/views/register.jsp").forward(request, response);
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // Get form parameters
        String firstName = request.getParameter("firstName");
        String lastName = request.getParameter("lastName");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirmPassword");
        String phone = request.getParameter("phone");
        String address = request.getParameter("address");
        
        // Create user object
        User user = new User();
        user.setFirstName(firstName != null ? firstName.trim() : "");
        user.setLastName(lastName != null ? lastName.trim() : "");
        user.setEmail(email != null ? email.trim() : "");
        user.setPassword(password != null ? password : "");
        user.setPhone(phone != null ? phone.trim() : "");
        user.setAddress(address != null ? address.trim() : "");
        
        // Validate passwords match
        if (!password.equals(confirmPassword)) {
            request.setAttribute("error", "Passwords do not match");
            preserveFormData(request, user);
            request.getRequestDispatcher("/WEB-INF/views/register.jsp").forward(request, response);
            return;
        }
        
        // Validate user input
        String validationError = userService.validateUserRegistration(user);
        if (validationError != null) {
            request.setAttribute("error", validationError);
            preserveFormData(request, user);
            request.getRequestDispatcher("/WEB-INF/views/register.jsp").forward(request, response);
            return;
        }
        
        // Register user
        boolean registrationSuccess = userService.registerUser(user);
        
        if (registrationSuccess) {
            // Registration successful
            request.setAttribute("success", "Registration successful! Please login with your credentials.");
            request.getRequestDispatcher("/WEB-INF/views/login.jsp").forward(request, response);
            
        } else {
            // Registration failed
            request.setAttribute("error", "Registration failed. Please try again.");
            preserveFormData(request, user);
            request.getRequestDispatcher("/WEB-INF/views/register.jsp").forward(request, response);
        }
    }
    
    /**
     * Preserve form data for user convenience in case of errors
     */
    private void preserveFormData(HttpServletRequest request, User user) {
        request.setAttribute("firstName", user.getFirstName());
        request.setAttribute("lastName", user.getLastName());
        request.setAttribute("email", user.getEmail());
        request.setAttribute("phone", user.getPhone());
        request.setAttribute("address", user.getAddress());
    }
}