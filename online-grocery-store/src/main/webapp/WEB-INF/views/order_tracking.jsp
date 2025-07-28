<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Track Order - Fresh Grocery Store</title>
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
            
            <div class="navbar-nav ms-auto">
                <a class="nav-link" href="${pageContext.request.contextPath}/">Home</a>
                <a class="nav-link" href="${pageContext.request.contextPath}/order-history">Order History</a>
                <a class="nav-link" href="${pageContext.request.contextPath}/logout">Logout</a>
            </div>
        </div>
    </nav>

    <div class="container py-4">
        <div class="row mb-4">
            <div class="col-12">
                <h1 class="display-5 fw-bold text-success mb-2">
                    <i class="fas fa-search me-2"></i>Track Your Order
                </h1>
                <p class="text-muted">Enter your order ID to track its current status</p>
            </div>
        </div>

        <!-- Search Form -->
        <div class="row mb-4">
            <div class="col-md-6">
                <div class="card shadow-sm">
                    <div class="card-body">
                        <form method="post" action="${pageContext.request.contextPath}/track-order">
                            <div class="input-group">
                                <span class="input-group-text">
                                    <i class="fas fa-hashtag"></i>
                                </span>
                                <input type="text" class="form-control" name="orderId" 
                                       placeholder="Enter Order ID (e.g., 1001)" 
                                       value="${orderId}" required>
                                <button type="submit" class="btn btn-success">
                                    <i class="fas fa-search me-1"></i>Track Order
                                </button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>

        <!-- Error Message -->
        <c:if test="${not empty error}">
            <div class="alert alert-danger">
                <i class="fas fa-exclamation-circle me-2"></i>${error}
            </div>
        </c:if>

        <!-- Tracking Information -->
        <c:if test="${not empty trackingInfo}">
            <c:set var="order" value="${trackingInfo.order}" />
            <c:set var="trackingSteps" value="${trackingInfo.trackingSteps}" />
            
            <!-- Order Summary -->
            <div class="card shadow-sm mb-4">
                <div class="card-header bg-success text-white">
                    <h5 class="mb-0">Order #${order.orderId}</h5>
                </div>
                <div class="card-body">
                    <div class="row">
                        <div class="col-md-3">
                            <strong>Order Date:</strong><br>
                            <fmt:formatDate value="${order.orderDate}" pattern="MMM dd, yyyy" />
                        </div>
                        <div class="col-md-3">
                            <strong>Status:</strong><br>
                            <span class="order-status status-${order.status.toString().toLowerCase()}">${order.status}</span>
                        </div>
                        <div class="col-md-3">
                            <strong>Total Amount:</strong><br>
                            <span class="fw-bold text-success">${order.formattedTotalAmount}</span>
                        </div>
                        <div class="col-md-3">
                            <strong>Items:</strong><br>
                            ${order.totalItems} items
                        </div>
                    </div>
                </div>
            </div>

            <!-- Tracking Timeline -->
            <div class="card shadow-sm">
                <div class="card-header bg-light">
                    <h5 class="mb-0">
                        <i class="fas fa-route me-2"></i>Order Timeline
                    </h5>
                </div>
                <div class="card-body">
                    <div class="tracking-timeline">
                        <c:forEach var="step" items="${trackingSteps}">
                            <div class="tracking-step ${step.completed ? 'completed' : ''}">
                                <div class="d-flex justify-content-between align-items-start">
                                    <div>
                                        <h6 class="fw-bold mb-1">${step.title}</h6>
                                        <p class="text-muted mb-0">${step.description}</p>
                                    </div>
                                    <div class="text-end">
                                        <c:if test="${step.completed}">
                                            <small class="text-success">
                                                <fmt:formatDate value="${step.date}" pattern="MMM dd, hh:mm a" />
                                            </small>
                                        </c:if>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                </div>
            </div>

            <!-- Estimated Delivery -->
            <div class="card mt-4 bg-light">
                <div class="card-body text-center">
                    <h6 class="fw-bold mb-2">
                        <i class="fas fa-truck me-2"></i>Estimated Delivery
                    </h6>
                    <p class="mb-0">
                        <fmt:formatDate value="${trackingInfo.estimatedDelivery}" pattern="EEEE, MMM dd, yyyy" />
                    </p>
                </div>
            </div>
        </c:if>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>