<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Checkout - Fresh Grocery Store</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/css/style.css" rel="stylesheet">
</head>
<body>
    <!-- Navigation -->
    <nav class="navbar navbar-expand-lg navbar-dark bg-success">
        <div class="container">
            <a class="navbar-brand" href="${pageContext.request.contextPath}/">
                <i class="fas fa-shopping-basket me-2"></i>Fresh Grocery
            </a>
        </div>
    </nav>

    <div class="container py-4">
        <h1 class="display-5 fw-bold text-success mb-4">
            <i class="fas fa-clipboard-check me-2"></i>Review Your Order
        </h1>

        <div class="row">
            <div class="col-lg-8">
                <!-- Order Items -->
                <div class="card shadow-sm mb-4">
                    <div class="card-header bg-success text-white">
                        <h5 class="mb-0">Order Items</h5>
                    </div>
                    <div class="card-body">
                        <c:forEach var="item" items="${cartItems}">
                            <div class="d-flex justify-content-between align-items-center py-2 border-bottom">
                                <div>
                                    <h6 class="mb-1">${item.product.name}</h6>
                                    <small class="text-muted">Qty: ${item.quantity} × ${item.product.formattedPrice}</small>
                                </div>
                                <div class="fw-bold">${item.formattedTotalPrice}</div>
                            </div>
                        </c:forEach>
                        <div class="d-flex justify-content-between align-items-center pt-3 mt-3">
                            <strong>Total:</strong>
                            <strong class="text-success fs-5">${cartTotal}</strong>
                        </div>
                    </div>
                </div>

                <!-- Shipping Address -->
                <div class="card shadow-sm">
                    <div class="card-header bg-light">
                        <h5 class="mb-0">Shipping Address</h5>
                    </div>
                    <div class="card-body">
                        <address>${user.address}</address>
                    </div>
                </div>
            </div>

            <div class="col-lg-4">
                <div class="card shadow-sm">
                    <div class="card-body text-center">
                        <h5 class="mb-3">Ready to Place Order?</h5>
                        <form method="post" action="${pageContext.request.contextPath}/order">
                            <input type="hidden" name="action" value="place">
                            <button type="submit" class="btn btn-success btn-lg w-100">
                                <i class="fas fa-credit-card me-2"></i>Proceed to Payment
                            </button>
                        </form>
                        <a href="${pageContext.request.contextPath}/cart" class="btn btn-outline-secondary mt-2 w-100">
                            <i class="fas fa-arrow-left me-2"></i>Back to Cart
                        </a>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>