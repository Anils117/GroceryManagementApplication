<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Shopping Cart - Fresh Grocery Store</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/css/style.css" rel="stylesheet">
</head>
<body>
    <!-- Navigation -->
    <nav class="navbar navbar-expand-lg navbar-dark bg-success">
        <div class="container">
            <a class="navbar-brand" href="${pageContext.request.contextPath}/">
                <i class="fas fa-shopping-basket me-2"></i>
                Fresh Grocery
            </a>
            
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                <span class="navbar-toggler-icon"></span>
            </button>
            
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav ms-auto">
                    <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/">
                            <i class="fas fa-home me-1"></i>Home
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/products">
                            <i class="fas fa-store me-1"></i>Shop
                        </a>
                    </li>
                    <c:choose>
                        <c:when test="${sessionScope.user != null}">
                            <li class="nav-item">
                                <a class="nav-link active" href="${pageContext.request.contextPath}/cart">
                                    <i class="fas fa-shopping-cart me-1"></i>Cart
                                </a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" href="${pageContext.request.contextPath}/order-history">
                                    <i class="fas fa-history me-1"></i>Orders
                                </a>
                            </li>
                            <li class="nav-item dropdown">
                                <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-bs-toggle="dropdown">
                                    <i class="fas fa-user me-1"></i>${sessionScope.userName}
                                </a>
                                <ul class="dropdown-menu">
                                    <li><a class="dropdown-item" href="${pageContext.request.contextPath}/logout">
                                        <i class="fas fa-sign-out-alt me-1"></i>Logout</a></li>
                                </ul>
                            </li>
                        </c:when>
                        <c:otherwise>
                            <li class="nav-item">
                                <a class="nav-link" href="${pageContext.request.contextPath}/login">
                                    <i class="fas fa-sign-in-alt me-1"></i>Login
                                </a>
                            </li>
                        </c:otherwise>
                    </c:choose>
                </ul>
            </div>
        </div>
    </nav>

    <div class="container py-4">
        <!-- Page Header -->
        <div class="row mb-4">
            <div class="col-12">
                <h1 class="display-5 fw-bold text-success mb-2">
                    <i class="fas fa-shopping-cart me-2"></i>Shopping Cart
                </h1>
                <nav aria-label="breadcrumb">
                    <ol class="breadcrumb">
                        <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/">Home</a></li>
                        <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/products">Products</a></li>
                        <li class="breadcrumb-item active">Cart</li>
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

        <c:if test="${not empty success}">
            <div class="alert alert-success alert-dismissible fade show" role="alert">
                <i class="fas fa-check-circle me-2"></i>
                ${success}
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            </div>
        </c:if>

        <div class="row">
            <c:choose>
                <c:when test="${not empty cartItems}">
                    <!-- Cart Items -->
                    <div class="col-lg-8">
                        <div class="card shadow-sm">
                            <div class="card-header bg-success text-white">
                                <h5 class="mb-0">
                                    <i class="fas fa-list me-2"></i>Cart Items (${cartItemCount} items)
                                </h5>
                            </div>
                            <div class="card-body p-0">
                                <c:forEach var="item" items="${cartItems}" varStatus="status">
                                    <div class="cart-item p-4 ${!status.last ? 'border-bottom' : ''}">
                                        <div class="row align-items-center">
                                            <div class="col-md-2">
                                                <img src="${item.product.imageUrl}" alt="${item.product.name}" 
                                                     class="img-fluid rounded" style="max-height: 80px;">
                                            </div>
                                            <div class="col-md-4">
                                                <h6 class="mb-1">${item.product.name}</h6>
                                                <p class="text-muted small mb-1">${item.product.description}</p>
                                                <span class="badge bg-light text-dark">${item.product.category}</span>
                                            </div>
                                            <div class="col-md-2">
                                                <div class="fw-bold text-success">${item.product.formattedPrice}</div>
                                                <small class="text-muted">per unit</small>
                                            </div>
                                            <div class="col-md-2">
                                                <form method="post" action="${pageContext.request.contextPath}/cart" class="d-inline">
                                                    <input type="hidden" name="action" value="update">
                                                    <input type="hidden" name="productId" value="${item.product.productId}">
                                                    <div class="quantity-controls">
                                                        <input type="number" name="quantity" value="${item.quantity}" 
                                                               min="1" max="${item.product.stockQuantity}" 
                                                               class="quantity-input" onchange="this.form.submit()">
                                                    </div>
                                                </form>
                                            </div>
                                            <div class="col-md-1">
                                                <div class="fw-bold">${item.formattedTotalPrice}</div>
                                            </div>
                                            <div class="col-md-1">
                                                <a href="${pageContext.request.contextPath}/cart?action=remove&productId=${item.product.productId}" 
                                                   class="btn btn-outline-danger btn-sm" 
                                                   onclick="return confirm('Remove this item from cart?')">
                                                    <i class="fas fa-trash"></i>
                                                </a>
                                            </div>
                                        </div>
                                    </div>
                                </c:forEach>
                            </div>
                        </div>

                        <!-- Cart Actions -->
                        <div class="mt-3 d-flex gap-2">
                            <a href="${pageContext.request.contextPath}/products" class="btn btn-outline-success">
                                <i class="fas fa-arrow-left me-2"></i>Continue Shopping
                            </a>
                            <a href="${pageContext.request.contextPath}/cart?action=clear" 
                               class="btn btn-outline-danger"
                               onclick="return confirm('Clear entire cart?')">
                                <i class="fas fa-trash me-2"></i>Clear Cart
                            </a>
                        </div>
                    </div>

                    <!-- Cart Summary -->
                    <div class="col-lg-4">
                        <div class="card cart-summary shadow-sm">
                            <div class="card-header bg-light">
                                <h5 class="mb-0">
                                    <i class="fas fa-calculator me-2"></i>Order Summary
                                </h5>
                            </div>
                            <div class="card-body">
                                <div class="d-flex justify-content-between mb-2">
                                    <span>Subtotal:</span>
                                    <span>${cartTotal}</span>
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
                                    <strong class="cart-total">${cartTotal}</strong>
                                </div>

                                <c:choose>
                                    <c:when test="${sessionScope.user != null}">
                                        <div class="d-grid gap-2">
                                            <a href="${pageContext.request.contextPath}/payment" 
                                               class="btn btn-success btn-lg">
                                                <i class="fas fa-credit-card me-2"></i>Proceed to Checkout
                                            </a>
                                            <a href="${pageContext.request.contextPath}/order?action=checkout" 
                                               class="btn btn-outline-success">
                                                <i class="fas fa-eye me-2"></i>Review Order
                                            </a>
                                        </div>
                                    </c:when>
                                    <c:otherwise>
                                        <div class="d-grid">
                                            <a href="${pageContext.request.contextPath}/login?redirect=${pageContext.request.contextPath}/cart" 
                                               class="btn btn-success btn-lg">
                                                <i class="fas fa-sign-in-alt me-2"></i>Login to Checkout
                                            </a>
                                        </div>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                        </div>

                        <!-- Security Badge -->
                        <div class="card mt-3 border-0 bg-light">
                            <div class="card-body text-center py-3">
                                <i class="fas fa-shield-alt text-success fa-2x mb-2"></i>
                                <p class="small mb-0 text-muted">
                                    <strong>Secure Checkout</strong><br>
                                    Your information is protected with SSL encryption
                                </p>
                            </div>
                        </div>
                    </div>
                </c:when>
                <c:otherwise>
                    <!-- Empty Cart -->
                    <div class="col-12">
                        <div class="text-center py-5">
                            <i class="fas fa-shopping-cart fa-4x text-muted mb-4"></i>
                            <h3 class="text-muted mb-3">Your cart is empty</h3>
                            <p class="text-muted mb-4">
                                Looks like you haven't added any items to your cart yet.<br>
                                Start shopping to fill it up!
                            </p>
                            <a href="${pageContext.request.contextPath}/products" class="btn btn-success btn-lg">
                                <i class="fas fa-shopping-basket me-2"></i>Start Shopping
                            </a>
                        </div>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
    </div>

    <!-- Footer -->
    <footer class="bg-dark text-light py-4 mt-5">
        <div class="container">
            <div class="row">
                <div class="col-md-6">
                    <h5><i class="fas fa-shopping-basket me-2"></i>Fresh Grocery</h5>
                    <p class="text-muted">Your trusted partner for fresh, quality groceries.</p>
                </div>
                <div class="col-md-6 text-md-end">
                    <p class="text-muted mb-0">&copy; 2024 Fresh Grocery. All rights reserved.</p>
                </div>
            </div>
        </div>
    </footer>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
    <script>
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