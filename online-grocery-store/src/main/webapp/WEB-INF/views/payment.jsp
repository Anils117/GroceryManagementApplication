<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Payment - Fresh Grocery Store</title>
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
                <a class="nav-link" href="${pageContext.request.contextPath}/cart">
                    <i class="fas fa-arrow-left me-1"></i>Back to Cart
                </a>
            </div>
        </div>
    </nav>

    <div class="container py-4">
        <!-- Page Header -->
        <div class="row mb-4">
            <div class="col-12">
                <h1 class="display-5 fw-bold text-success mb-2">
                    <i class="fas fa-credit-card me-2"></i>Secure Checkout
                </h1>
                <nav aria-label="breadcrumb">
                    <ol class="breadcrumb">
                        <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/">Home</a></li>
                        <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/cart">Cart</a></li>
                        <li class="breadcrumb-item active">Payment</li>
                    </ol>
                </nav>
            </div>
        </div>

        <!-- Error/Success Messages -->
        <c:if test="${not empty error}">
            <div class="alert alert-danger alert-dismissible fade show" role="alert">
                <i class="fas fa-exclamation-circle me-2"></i>
                ${error}
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            </div>
        </c:if>

        <div class="row">
            <!-- Payment Form -->
            <div class="col-lg-8">
                <div class="card payment-form shadow-sm">
                    <div class="card-header bg-success text-white">
                        <h5 class="mb-0">
                            <i class="fas fa-lock me-2"></i>Payment Information
                        </h5>
                    </div>
                    <div class="card-body p-4">
                        <form method="post" action="${pageContext.request.contextPath}/payment" id="paymentForm">
                            <!-- Shipping Address -->
                            <div class="mb-4">
                                <h6 class="fw-bold mb-3">
                                    <i class="fas fa-truck me-2"></i>Shipping Address
                                </h6>
                                <div class="form-floating">
                                    <textarea class="form-control" id="shippingAddress" name="shippingAddress" 
                                              style="height: 100px" placeholder="Enter shipping address">${shippingAddress != null ? shippingAddress : sessionScope.user.address}</textarea>
                                    <label for="shippingAddress">Shipping Address</label>
                                </div>
                            </div>

                            <hr>

                            <!-- Payment Details -->
                            <div class="mb-4">
                                <h6 class="fw-bold mb-3">
                                    <i class="fas fa-credit-card me-2"></i>Payment Details
                                </h6>
                                
                                <div class="row">
                                    <div class="col-md-8 mb-3">
                                        <div class="form-floating">
                                            <input type="text" class="form-control" id="cardNumber" name="cardNumber" 
                                                   placeholder="Card Number" required maxlength="19"
                                                   pattern="[0-9\s]{13,19}" autocomplete="cc-number">
                                            <label for="cardNumber">Card Number</label>
                                        </div>
                                        <div class="mt-2">
                                            <small class="text-muted">
                                                <i class="fab fa-cc-visa me-1"></i>
                                                <i class="fab fa-cc-mastercard me-1"></i>
                                                <i class="fab fa-cc-amex me-1"></i>
                                                <i class="fab fa-cc-discover me-1"></i>
                                                We accept all major credit cards
                                            </small>
                                        </div>
                                    </div>
                                    <div class="col-md-4 mb-3">
                                        <div class="form-floating">
                                            <input type="text" class="form-control" id="cvv" name="cvv" 
                                                   placeholder="CVV" required maxlength="4" 
                                                   pattern="[0-9]{3,4}" autocomplete="cc-csc">
                                            <label for="cvv">CVV</label>
                                        </div>
                                    </div>
                                </div>

                                <div class="row">
                                    <div class="col-md-6 mb-3">
                                        <div class="form-floating">
                                            <input type="text" class="form-control" id="expiryDate" name="expiryDate" 
                                                   placeholder="MM/YY" required pattern="(0[1-9]|1[0-2])\/\d{2}" 
                                                   maxlength="5" autocomplete="cc-exp">
                                            <label for="expiryDate">Expiry Date (MM/YY)</label>
                                        </div>
                                    </div>
                                    <div class="col-md-6 mb-3">
                                        <div class="form-floating">
                                            <input type="text" class="form-control" id="cardHolderName" name="cardHolderName" 
                                                   placeholder="Cardholder Name" required value="${cardHolderName != null ? cardHolderName : sessionScope.user.fullName}"
                                                   autocomplete="cc-name">
                                            <label for="cardHolderName">Cardholder Name</label>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <!-- Demo Card Info -->
                            <div class="alert alert-info">
                                <h6 class="alert-heading">
                                    <i class="fas fa-info-circle me-2"></i>Demo Payment Information
                                </h6>
                                <p class="mb-2"><strong>Use these test card numbers:</strong></p>
                                <ul class="mb-0">
                                    <li><strong>Visa:</strong> 4111111111111111</li>
                                    <li><strong>Mastercard:</strong> 5555555555554444</li>
                                    <li><strong>American Express:</strong> 378282246310005</li>
                                    <li><strong>CVV:</strong> Any 3-4 digits | <strong>Expiry:</strong> Any future date</li>
                                </ul>
                            </div>

                            <div class="d-grid">
                                <button type="submit" class="btn btn-success btn-lg" id="submitPayment">
                                    <i class="fas fa-lock me-2"></i>
                                    <span id="buttonText">Complete Payment - ${formattedCartTotal}</span>
                                    <span id="loadingText" class="d-none">
                                        <span class="loading me-2"></span>Processing...
                                    </span>
                                </button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>

            <!-- Order Summary -->
            <div class="col-lg-4">
                <div class="card payment-summary shadow-sm">
                    <div class="card-header bg-light">
                        <h5 class="mb-0">
                            <i class="fas fa-receipt me-2"></i>Order Summary
                        </h5>
                    </div>
                    <div class="card-body">
                        <c:forEach var="item" items="${cartItems}">
                            <div class="d-flex justify-content-between align-items-center mb-2">
                                <div class="flex-grow-1">
                                    <div class="fw-bold">${item.product.name}</div>
                                    <small class="text-muted">Qty: ${item.quantity} × ${item.product.formattedPrice}</small>
                                </div>
                                <div class="fw-bold">${item.formattedTotalPrice}</div>
                            </div>
                        </c:forEach>
                        
                        <hr>
                        
                        <div class="d-flex justify-content-between mb-2">
                            <span>Subtotal:</span>
                            <span>${formattedCartTotal}</span>
                        </div>
                        <div class="d-flex justify-content-between mb-2">
                            <span>Shipping:</span>
                            <span class="text-success">FREE</span>
                        </div>
                        <div class="d-flex justify-content-between mb-2">
                            <span>Tax:</span>
                            <span>$0.00</span>
                        </div>
                        
                        <hr>
                        
                        <div class="d-flex justify-content-between mb-3">
                            <strong>Total:</strong>
                            <strong class="text-success fs-5">${formattedCartTotal}</strong>
                        </div>

                        <!-- Security Features -->
                        <div class="bg-light p-3 rounded">
                            <div class="d-flex align-items-center mb-2">
                                <i class="fas fa-shield-alt text-success me-2"></i>
                                <small class="fw-bold">256-bit SSL Encryption</small>
                            </div>
                            <div class="d-flex align-items-center mb-2">
                                <i class="fas fa-lock text-success me-2"></i>
                                <small class="fw-bold">Secure Payment Processing</small>
                            </div>
                            <div class="d-flex align-items-center">
                                <i class="fas fa-user-shield text-success me-2"></i>
                                <small class="fw-bold">Privacy Protected</small>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        // Card number formatting
        document.getElementById('cardNumber').addEventListener('input', function(e) {
            let value = e.target.value.replace(/\s+/g, '').replace(/[^0-9]/gi, '');
            let formattedValue = value.match(/.{1,4}/g)?.join(' ') || value;
            if (formattedValue !== e.target.value) {
                e.target.value = formattedValue;
            }
        });

        // Expiry date formatting
        document.getElementById('expiryDate').addEventListener('input', function(e) {
            let value = e.target.value.replace(/\D/g, '');
            if (value.length >= 2) {
                value = value.substring(0, 2) + '/' + value.substring(2, 4);
            }
            e.target.value = value;
        });

        // CVV validation
        document.getElementById('cvv').addEventListener('input', function(e) {
            e.target.value = e.target.value.replace(/[^0-9]/g, '');
        });

        // Form submission with loading state
        document.getElementById('paymentForm').addEventListener('submit', function(e) {
            const submitButton = document.getElementById('submitPayment');
            const buttonText = document.getElementById('buttonText');
            const loadingText = document.getElementById('loadingText');
            
            submitButton.disabled = true;
            buttonText.classList.add('d-none');
            loadingText.classList.remove('d-none');
        });

        // Auto-dismiss alerts after 5 seconds
        setTimeout(function() {
            const alerts = document.querySelectorAll('.alert');
            alerts.forEach(function(alert) {
                const bsAlert = new bootstrap.Alert(alert);
                bsAlert.close();
            });
        }, 5000);
    </script>
</body>
</html>