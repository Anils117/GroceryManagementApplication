package com.grocery.services;

import com.grocery.models.User;
import java.util.*;
import java.util.concurrent.atomic.AtomicInteger;

/**
 * UserService class for managing user operations
 * Uses in-memory storage for demo purposes - replace with database in production
 */
public class UserService {
    
    // In-memory storage (replace with database in production)
    private static final Map<Integer, User> users = new HashMap<>();
    private static final Map<String, User> usersByEmail = new HashMap<>();
    private static final AtomicInteger userIdCounter = new AtomicInteger(1);
    
    // Hardcoded admin credentials
    private static final String ADMIN_EMAIL = "admin@grocery.com";
    private static final String ADMIN_PASSWORD = "admin123";
    
    static {
        // Initialize with some dummy users for testing
        initializeDummyUsers();
    }
    
    /**
     * Initialize dummy users for testing
     */
    private static void initializeDummyUsers() {
        User user1 = new User("John", "Doe", "john.doe@email.com", "password123", 
                             "555-0101", "123 Main St, City, State 12345");
        user1.setUserId(userIdCounter.getAndIncrement());
        users.put(user1.getUserId(), user1);
        usersByEmail.put(user1.getEmail(), user1);
        
        User user2 = new User("Jane", "Smith", "jane.smith@email.com", "password456", 
                             "555-0102", "456 Oak Ave, City, State 12345");
        user2.setUserId(userIdCounter.getAndIncrement());
        users.put(user2.getUserId(), user2);
        usersByEmail.put(user2.getEmail(), user2);
    }
    
    /**
     * Register a new user
     */
    public boolean registerUser(User user) {
        try {
            // Check if email already exists
            if (usersByEmail.containsKey(user.getEmail())) {
                return false; // Email already exists
            }
            
            // Assign new user ID
            user.setUserId(userIdCounter.getAndIncrement());
            
            // Store user
            users.put(user.getUserId(), user);
            usersByEmail.put(user.getEmail(), user);
            
            return true;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
    
    /**
     * Authenticate user login
     */
    public User loginUser(String email, String password) {
        try {
            User user = usersByEmail.get(email);
            if (user != null && user.getPassword().equals(password) && user.isActive()) {
                return user;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }
    
    /**
     * Authenticate admin login
     */
    public boolean loginAdmin(String email, String password) {
        return ADMIN_EMAIL.equals(email) && ADMIN_PASSWORD.equals(password);
    }
    
    /**
     * Get user by ID
     */
    public User getUserById(int userId) {
        return users.get(userId);
    }
    
    /**
     * Get user by email
     */
    public User getUserByEmail(String email) {
        return usersByEmail.get(email);
    }
    
    /**
     * Get all users (for admin)
     */
    public List<User> getAllUsers() {
        return new ArrayList<>(users.values());
    }
    
    /**
     * Update user information
     */
    public boolean updateUser(User user) {
        try {
            if (users.containsKey(user.getUserId())) {
                // Remove old email mapping if email changed
                User existingUser = users.get(user.getUserId());
                if (!existingUser.getEmail().equals(user.getEmail())) {
                    usersByEmail.remove(existingUser.getEmail());
                    
                    // Check if new email already exists
                    if (usersByEmail.containsKey(user.getEmail())) {
                        // Restore old email mapping
                        usersByEmail.put(existingUser.getEmail(), existingUser);
                        return false;
                    }
                }
                
                // Update user
                users.put(user.getUserId(), user);
                usersByEmail.put(user.getEmail(), user);
                return true;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }
    
    /**
     * Activate/Deactivate user (for admin)
     */
    public boolean toggleUserStatus(int userId) {
        try {
            User user = users.get(userId);
            if (user != null) {
                user.setActive(!user.isActive());
                return true;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }
    
    /**
     * Delete user (for admin)
     */
    public boolean deleteUser(int userId) {
        try {
            User user = users.get(userId);
            if (user != null) {
                users.remove(userId);
                usersByEmail.remove(user.getEmail());
                return true;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }
    
    /**
     * Check if email exists
     */
    public boolean emailExists(String email) {
        return usersByEmail.containsKey(email);
    }
    
    /**
     * Validate user input
     */
    public String validateUserRegistration(User user) {
        if (user.getFirstName() == null || user.getFirstName().trim().isEmpty()) {
            return "First name is required";
        }
        if (user.getLastName() == null || user.getLastName().trim().isEmpty()) {
            return "Last name is required";
        }
        if (user.getEmail() == null || user.getEmail().trim().isEmpty()) {
            return "Email is required";
        }
        if (!isValidEmail(user.getEmail())) {
            return "Invalid email format";
        }
        if (emailExists(user.getEmail())) {
            return "Email already exists";
        }
        if (user.getPassword() == null || user.getPassword().length() < 6) {
            return "Password must be at least 6 characters";
        }
        if (user.getPhone() == null || user.getPhone().trim().isEmpty()) {
            return "Phone number is required";
        }
        if (user.getAddress() == null || user.getAddress().trim().isEmpty()) {
            return "Address is required";
        }
        return null; // Valid
    }
    
    /**
     * Simple email validation
     */
    private boolean isValidEmail(String email) {
        return email.contains("@") && email.contains(".");
    }
}