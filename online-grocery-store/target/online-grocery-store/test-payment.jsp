<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Payment Test - Fresh Grocery Store</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
</head>
<body class="bg-light">
    <div class="container py-5">
        <div class="row justify-content-center">
            <div class="col-lg-8">
                <div class="card shadow">
                    <div class="card-header bg-success text-white">
                        <h4 class="mb-0">
                            <i class="fas fa-credit-card me-2"></i>Payment System Test
                        </h4>
                    </div>
                    <div class="card-body">
                        <h5>Test Payment Information:</h5>
                        <ul class="list-group list-group-flush mb-4">
                            <li class="list-group-item">
                                <strong>Visa:</strong> 4111111111111111
                            </li>
                            <li class="list-group-item">
                                <strong>Mastercard:</strong> 5555555555554444
                            </li>
                            <li class="list-group-item">
                                <strong>American Express:</strong> 378282246310005
                            </li>
                            <li class="list-group-item">
                                <strong>CVV:</strong> Any 3-4 digits
                            </li>
                            <li class="list-group-item">
                                <strong>Expiry:</strong> Any future date (MM/YY)
                            </li>
                        </ul>
                        
                        <div class="alert alert-info">
                            <h6>How to test:</h6>
                            <ol>
                                <li>Add items to your cart</li>
                                <li>Go to checkout</li>
                                <li>Use the test card numbers above</li>
                                <li>Complete the payment</li>
                                <li>Check your order history</li>
                            </ol>
                        </div>
                        
                        <div class="d-flex gap-3">
                            <a href="${pageContext.request.contextPath}/products" class="btn btn-success">
                                <i class="fas fa-store me-2"></i>Browse Products
                            </a>
                            <a href="${pageContext.request.contextPath}/cart" class="btn btn-outline-success">
                                <i class="fas fa-shopping-cart me-2"></i>View Cart
                            </a>
                            <a href="${pageContext.request.contextPath}/order-history" class="btn btn-outline-info">
                                <i class="fas fa-history me-2"></i>Order History
                            </a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html> 