<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Payment Successful - Fresh Grocery Store</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/css/style.css" rel="stylesheet">
</head>
<body class="bg-light">
    <!-- Navigation -->
    <nav class="navbar navbar-expand-lg navbar-dark bg-success">
        <div class="container">
            <a class="navbar-brand" href="${pageContext.request.contextPath}/">
                <i class="fas fa-shopping-basket me-2"></i>
                Fresh Grocery
            </a>
            
            <div class="navbar-nav ms-auto">
                <a class="nav-link" href="${pageContext.request.contextPath}/">
                    <i class="fas fa-home me-1"></i>Home
                </a>
                <a class="nav-link" href="${pageContext.request.contextPath}/products">
                    <i class="fas fa-store me-1"></i>Continue Shopping
                </a>
            </div>
        </div>
    </nav>

    <div class="container py-5">
        <div class="row justify-content-center">
            <div class="col-lg-8">
                <!-- Success Message -->
                <div class="text-center mb-5">
                    <div class="bg-success text-white rounded-circle d-inline-flex align-items-center justify-content-center mb-4" 
                         style="width: 100px; height: 100px;">
                        <i class="fas fa-check fa-3x"></i>
                    </div>
                    <h1 class="display-4 fw-bold text-success mb-3">Payment Successful!</h1>
                    <p class="lead text-muted">
                        Thank you for your order. Your payment has been processed successfully.
                    </p>
                </div>

                <!-- Order Details -->
                <div class="card shadow-sm mb-4">
                    <div class="card-header bg-success text-white">
                        <h5 class="mb-0">
                            <i class="fas fa-receipt me-2"></i>Order Confirmation
                        </h5>
                    </div>
                    <div class="card-body">
                        <div class="row">
                            <div class="col-md-6">
                                <h6 class="fw-bold mb-3">Order Information</h6>
                                <p><strong>Order ID:</strong> #${order.orderId}</p>
                                <p><strong>Order Date:</strong> 
                                    <fmt:formatDate value="${order.orderDate}" pattern="MMM dd, yyyy 'at' hh:mm a" />
                                </p>
                                <p><strong>Status:</strong> 
                                    <span class="badge bg-success">${order.status}</span>
                                </p>
                                <p><strong>Total Amount:</strong> 
                                    <span class="fw-bold text-success">${order.formattedTotalAmount}</span>
                                </p>
                            </div>
                            <div class="col-md-6">
                                <h6 class="fw-bold mb-3">Payment Information</h6>
                                <p><strong>Transaction ID:</strong> ${paymentResult.transactionId}</p>
                                <p><strong>Payment Method:</strong> ${paymentResult.paymentMethod}</p>
                                <p><strong>Card Number:</strong> ${paymentResult.maskedCardNumber}</p>
                                <p><strong>Payment Status:</strong> 
                                    <span class="badge bg-success">Completed</span>
                                </p>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Shipping Information -->
                <div class="card shadow-sm mb-4">
                    <div class="card-header bg-light">
                        <h5 class="mb-0">
                            <i class="fas fa-truck me-2"></i>Shipping Information
                        </h5>
                    </div>
                    <div class="card-body">
                        <p><strong>Shipping Address:</strong></p>
                        <address class="text-muted">
                            ${order.shippingAddress}
                        </address>
                        <p><strong>Estimated Delivery:</strong> 
                            <span class="text-success">3-5 business days</span>
                        </p>
                        <p class="text-muted mb-0">
                            <i class="fas fa-info-circle me-1"></i>
                            You will receive a tracking number via email once your order is shipped.
                        </p>
                    </div>
                </div>

                <!-- Order Items -->
                <div class="card shadow-sm mb-4">
                    <div class="card-header bg-light">
                        <h5 class="mb-0">
                            <i class="fas fa-list me-2"></i>Order Items
                        </h5>
                    </div>
                    <div class="card-body">
                        <c:forEach var="item" items="${order.orderItems}" varStatus="status">
                            <div class="d-flex justify-content-between align-items-center py-2 ${!status.last ? 'border-bottom' : ''}">
                                <div>
                                    <h6 class="mb-1">${item.productName}</h6>
                                    <small class="text-muted">Quantity: ${item.quantity} × ${item.formattedUnitPrice}</small>
                                </div>
                                <div class="fw-bold">${item.formattedTotalPrice}</div>
                            </div>
                        </c:forEach>
                        
                        <div class="d-flex justify-content-between align-items-center pt-3 mt-3 border-top">
                            <strong>Total:</strong>
                            <strong class="text-success fs-5">${order.formattedTotalAmount}</strong>
                        </div>
                    </div>
                </div>

                <!-- Next Steps -->
                <div class="card shadow-sm mb-4">
                    <div class="card-header bg-info text-white">
                        <h5 class="mb-0">
                            <i class="fas fa-clipboard-list me-2"></i>What's Next?
                        </h5>
                    </div>
                    <div class="card-body">
                        <div class="row">
                            <div class="col-md-4 text-center mb-3">
                                <i class="fas fa-envelope fa-2x text-info mb-2"></i>
                                <h6>Email Confirmation</h6>
                                <p class="small text-muted">Order confirmation sent to your email</p>
                            </div>
                            <div class="col-md-4 text-center mb-3">
                                <i class="fas fa-box fa-2x text-info mb-2"></i>
                                <h6>Order Processing</h6>
                                <p class="small text-muted">We'll prepare your items for shipping</p>
                            </div>
                            <div class="col-md-4 text-center mb-3">
                                <i class="fas fa-shipping-fast fa-2x text-info mb-2"></i>
                                <h6>Fast Delivery</h6>
                                <p class="small text-muted">Your order will arrive in 3-5 days</p>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Action Buttons -->
                <div class="text-center">
                    <div class="d-flex gap-3 justify-content-center flex-wrap">
                        <a href="${pageContext.request.contextPath}/track-order?orderId=${order.orderId}" 
                           class="btn btn-success btn-lg">
                            <i class="fas fa-search me-2"></i>Track Your Order
                        </a>
                        <a href="${pageContext.request.contextPath}/order-history" 
                           class="btn btn-outline-success btn-lg">
                            <i class="fas fa-history me-2"></i>View Order History
                        </a>
                        <a href="${pageContext.request.contextPath}/products" 
                           class="btn btn-outline-secondary btn-lg">
                            <i class="fas fa-shopping-basket me-2"></i>Continue Shopping
                        </a>
                    </div>
                </div>

                <!-- Support Information -->
                <div class="text-center mt-5 p-4 bg-light rounded">
                    <h6 class="fw-bold mb-2">Need Help?</h6>
                    <p class="text-muted mb-0">
                        If you have any questions about your order, please contact our customer support team.
                        <br>
                        <i class="fas fa-phone me-1"></i> 1-800-GROCERY (1-800-476-2379) | 
                        <i class="fas fa-envelope me-1"></i> support@freshgrocery.com
                    </p>
                </div>
            </div>
        </div>
    </div>

    <!-- Footer -->
    <footer class="bg-dark text-light py-4 mt-5">
        <div class="container">
            <div class="row">
                <div class="col-md-6">
                    <h5><i class="fas fa-shopping-basket me-2"></i>Fresh Grocery</h5>
                    <p class="text-muted">Thank you for choosing Fresh Grocery for your shopping needs!</p>
                </div>
                <div class="col-md-6 text-md-end">
                    <p class="text-muted mb-0">&copy; 2024 Fresh Grocery. All rights reserved.</p>
                </div>
            </div>
        </div>
    </footer>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>