# Payment and Order History System

## Overview
This document describes the payment processing and order history functionality implemented in the Online Grocery Store application.

## Features

### Payment System
- **Secure Payment Processing**: Handles credit card payments with validation
- **Multiple Card Types**: Supports Visa, Mastercard, American Express, and Discover
- **Form Validation**: Client-side and server-side validation for payment details
- **Transaction Tracking**: Generates unique transaction IDs for each payment
- **Error Handling**: Comprehensive error handling and user feedback

### Order History System
- **Order Tracking**: View all past orders with detailed information
- **Order Status**: Real-time order status updates (Pending, Confirmed, Processing, Shipped, Delivered, Cancelled)
- **Order Management**: Cancel orders that haven't been shipped yet
- **Order Details**: View order items, totals, shipping information, and payment details

## How to Test

### 1. Setup
1. Deploy the application to your servlet container (Tomcat, etc.)
2. Access the application at `http://localhost:8080/online-grocery-store/`
3. Register a new account or use existing test accounts:
   - Email: `john.doe@email.com`, Password: `password123`
   - Email: `jane.smith@email.com`, Password: `password456`

### 2. Test Payment Process
1. **Browse Products**: Go to `/products` and add items to your cart
2. **View Cart**: Go to `/cart` to review your items
3. **Checkout**: Click "Proceed to Checkout" to go to payment page
4. **Payment**: Use test card numbers:
   - **Visa**: `4111111111111111`
   - **Mastercard**: `5555555555554444`
   - **American Express**: `378282246310005`
   - **CVV**: Any 3-4 digits
   - **Expiry**: Any future date (MM/YY format)
5. **Complete Payment**: Submit the form to process payment
6. **Success Page**: View order confirmation and transaction details

### 3. Test Order History
1. **View Orders**: Go to `/order-history` to see all your orders
2. **Order Details**: Click on order items to see detailed information
3. **Track Orders**: Use the "Track" button to view order status
4. **Cancel Orders**: Cancel orders that are still pending or confirmed

## Test Page
Access the test page at `/test-payment` for quick reference to test card numbers and instructions.

## Technical Implementation

### PaymentServlet (`/payment`)
- **GET**: Displays payment form with cart summary
- **POST**: Processes payment and creates order
- **Validation**: Validates cart, user session, and payment details
- **Error Handling**: Comprehensive error handling with user feedback

### OrderHistoryServlet (`/order-history`)
- **GET**: Displays user's order history
- **POST**: Handles order cancellation
- **Authentication**: Requires user login
- **Data Loading**: Loads orders from in-memory storage

### PaymentService
- **Card Validation**: Luhn algorithm for card number validation
- **Payment Processing**: Simulated payment processing with 90% success rate
- **Transaction IDs**: Generates unique transaction IDs
- **Error Handling**: Returns detailed error messages

### OrderService
- **Order Creation**: Creates orders from cart items
- **Order Management**: Handles order status updates and cancellation
- **Stock Management**: Updates product stock when orders are created/cancelled
- **Data Storage**: In-memory storage with sample data

## File Structure

```
src/main/java/com/grocery/
├── servlets/
│   ├── PaymentServlet.java          # Payment processing
│   ├── OrderHistoryServlet.java     # Order history display
│   └── TestPageServlet.java         # Test page servlet
├── services/
│   ├── PaymentService.java          # Payment processing logic
│   └── OrderService.java            # Order management logic
├── models/
│   ├── Order.java                   # Order entity
│   ├── OrderItem.java               # Order item entity
│   ├── CartItem.java                # Cart item entity
│   └── User.java                    # User entity
└── utils/
    └── CartUtils.java               # Cart utility functions

src/main/webapp/
├── WEB-INF/views/
│   ├── payment.jsp                  # Payment form
│   ├── payment_success.jsp          # Payment success page
│   ├── order_history.jsp            # Order history page
│   └── error/
│       ├── 404.jsp                  # 404 error page
│       └── 500.jsp                  # 500 error page
├── test-payment.jsp                 # Test page
└── css/
    └── style.css                    # Styling for order status badges
```

## Error Handling

### Payment Errors
- Invalid card details
- Insufficient funds (simulated)
- Network errors
- Invalid cart state

### Order History Errors
- User not logged in
- Database errors
- Invalid order operations

## Security Features

### Payment Security
- Card number masking
- CVV validation
- Expiry date validation
- Luhn algorithm validation
- Secure form submission

### Order Security
- User authentication required
- Order ownership validation
- Session management
- Input validation

## Sample Data

The system includes sample orders for testing:
- **Order #1001**: Delivered order with apples and bananas
- **Order #1002**: Shipped order with carrots, spinach, and milk

## Troubleshooting

### Common Issues

1. **Payment Fails**
   - Check card number format
   - Verify CVV is 3-4 digits
   - Ensure expiry date is in MM/YY format
   - Check if cart has items

2. **Order History Empty**
   - Verify user is logged in
   - Check if user has placed orders
   - Look for error messages in console

3. **Order Cancellation Fails**
   - Orders can only be cancelled if not shipped
   - Check order status before attempting cancellation

### Debug Information
- Check server console for detailed logs
- Verify session data is maintained
- Check cart state before payment

## Future Enhancements

1. **Database Integration**: Replace in-memory storage with database
2. **Real Payment Gateway**: Integrate with actual payment processors
3. **Email Notifications**: Send order confirmations and updates
4. **Order Tracking**: Real-time shipping tracking
5. **Refund Processing**: Handle payment refunds
6. **Multiple Payment Methods**: Add PayPal, digital wallets, etc.

## Support

For issues or questions:
- Check the console logs for error messages
- Verify all required dependencies are included
- Ensure proper servlet container configuration
- Test with provided sample data first 