package com.grocery.services;

import java.math.BigDecimal;
import java.util.HashMap;
import java.util.Map;
import java.util.Random;
import java.util.UUID;

/**
 * PaymentService class for handling dummy payment processing
 * This is a mock service for demonstration purposes
 */
public class PaymentService {
    
    private static final Random random = new Random();
    
    /**
     * Process payment (dummy implementation)
     */
    public Map<String, Object> processPayment(String cardNumber, String expiryDate, 
                                            String cvv, String cardHolderName, 
                                            BigDecimal amount) {
        Map<String, Object> result = new HashMap<>();
        
        try {
            // Validate card details
            String validationError = validateCardDetails(cardNumber, expiryDate, cvv, cardHolderName);
            if (validationError != null) {
                result.put("success", false);
                result.put("error", validationError);
                return result;
            }
            
            // Simulate payment processing delay
            Thread.sleep(1000 + random.nextInt(2000)); // 1-3 seconds
            
            // Simulate payment success/failure (90% success rate)
            boolean paymentSuccess = random.nextDouble() < 0.9;
            
            if (paymentSuccess) {
                String transactionId = generateTransactionId();
                result.put("success", true);
                result.put("transactionId", transactionId);
                result.put("amount", amount);
                result.put("message", "Payment processed successfully");
                result.put("paymentMethod", getCardType(cardNumber));
                result.put("maskedCardNumber", maskCardNumber(cardNumber));
            } else {
                result.put("success", false);
                result.put("error", "Payment declined. Please try again or use a different card.");
            }
            
        } catch (Exception e) {
            result.put("success", false);
            result.put("error", "Payment processing failed. Please try again.");
            e.printStackTrace();
        }
        
        return result;
    }
    
    /**
     * Validate card details
     */
    public String validateCardDetails(String cardNumber, String expiryDate, 
                                    String cvv, String cardHolderName) {
        
        // Validate card number
        if (cardNumber == null || cardNumber.trim().isEmpty()) {
            return "Card number is required";
        }
        cardNumber = cardNumber.replaceAll("\\s+", ""); // Remove spaces
        if (!cardNumber.matches("\\d{13,19}")) {
            return "Invalid card number format";
        }
        if (!isValidLuhn(cardNumber)) {
            return "Invalid card number";
        }
        
        // Validate expiry date
        if (expiryDate == null || expiryDate.trim().isEmpty()) {
            return "Expiry date is required";
        }
        if (!expiryDate.matches("(0[1-9]|1[0-2])/\\d{2}")) {
            return "Invalid expiry date format (MM/YY)";
        }
        
        // Validate CVV
        if (cvv == null || cvv.trim().isEmpty()) {
            return "CVV is required";
        }
        if (!cvv.matches("\\d{3,4}")) {
            return "Invalid CVV format";
        }
        
        // Validate card holder name
        if (cardHolderName == null || cardHolderName.trim().isEmpty()) {
            return "Card holder name is required";
        }
        if (cardHolderName.trim().length() < 2) {
            return "Card holder name must be at least 2 characters";
        }
        
        return null; // Valid
    }
    
    /**
     * Simple Luhn algorithm validation for card numbers
     */
    private boolean isValidLuhn(String cardNumber) {
        int sum = 0;
        boolean alternate = false;
        
        for (int i = cardNumber.length() - 1; i >= 0; i--) {
            int digit = Character.getNumericValue(cardNumber.charAt(i));
            
            if (alternate) {
                digit *= 2;
                if (digit > 9) {
                    digit = (digit % 10) + 1;
                }
            }
            
            sum += digit;
            alternate = !alternate;
        }
        
        return (sum % 10) == 0;
    }
    
    /**
     * Get card type based on card number
     */
    private String getCardType(String cardNumber) {
        cardNumber = cardNumber.replaceAll("\\s+", "");
        
        if (cardNumber.startsWith("4")) {
            return "Visa";
        } else if (cardNumber.startsWith("5") || cardNumber.startsWith("2")) {
            return "Mastercard";
        } else if (cardNumber.startsWith("3")) {
            return "American Express";
        } else if (cardNumber.startsWith("6")) {
            return "Discover";
        } else {
            return "Unknown";
        }
    }
    
    /**
     * Mask card number for display
     */
    private String maskCardNumber(String cardNumber) {
        cardNumber = cardNumber.replaceAll("\\s+", "");
        if (cardNumber.length() < 4) {
            return "****";
        }
        
        String lastFour = cardNumber.substring(cardNumber.length() - 4);
        String masked = "**** **** **** " + lastFour;
        
        return masked;
    }
    
    /**
     * Generate a dummy transaction ID
     */
    private String generateTransactionId() {
        return "TXN" + UUID.randomUUID().toString().substring(0, 8).toUpperCase();
    }
    
    /**
     * Refund payment (dummy implementation)
     */
    public Map<String, Object> refundPayment(String transactionId, BigDecimal amount) {
        Map<String, Object> result = new HashMap<>();
        
        try {
            // Simulate refund processing
            Thread.sleep(500 + random.nextInt(1000)); // 0.5-1.5 seconds
            
            // Simulate refund success (95% success rate)
            boolean refundSuccess = random.nextDouble() < 0.95;
            
            if (refundSuccess) {
                String refundId = "REF" + UUID.randomUUID().toString().substring(0, 8).toUpperCase();
                result.put("success", true);
                result.put("refundId", refundId);
                result.put("originalTransactionId", transactionId);
                result.put("amount", amount);
                result.put("message", "Refund processed successfully");
            } else {
                result.put("success", false);
                result.put("error", "Refund processing failed. Please contact support.");
            }
            
        } catch (Exception e) {
            result.put("success", false);
            result.put("error", "Refund processing failed. Please try again.");
            e.printStackTrace();
        }
        
        return result;
    }
    
    /**
     * Get payment methods supported
     */
    public String[] getSupportedPaymentMethods() {
        return new String[]{"Visa", "Mastercard", "American Express", "Discover"};
    }
    
    /**
     * Check if payment method is supported
     */
    public boolean isPaymentMethodSupported(String cardNumber) {
        String cardType = getCardType(cardNumber);
        for (String supportedType : getSupportedPaymentMethods()) {
            if (supportedType.equals(cardType)) {
                return true;
            }
        }
        return false;
    }
}