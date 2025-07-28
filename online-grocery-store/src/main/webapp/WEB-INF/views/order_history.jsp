<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Order History - Fresh Grocery Store</title>
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
            
            <div class="collapse navbar-collapse">
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
                    <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/cart">
                            <i class="fas fa-shopping-cart me-1"></i>Cart
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link active" href="${pageContext.request.contextPath}/order-history">
                            <i class="fas fa-history me-1"></i>Orders
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/logout">
                            <i class="fas fa-sign-out-alt me-1"></i>Logout
                        </a>
                    </li>
                </ul>
            </div>
        </div>
    </nav>

    <div class="container py-4">
        <div class="row mb-4">
            <div class="col-12">
                <h1 class="display-5 fw-bold text-success mb-2">
                    <i class="fas fa-history me-2"></i>Order History
                </h1>
                <p class="text-muted">Track your past orders and their current status</p>
            </div>
        </div>

        <c:choose>
            <c:when test="${not empty orders}">
                <c:forEach var="order" items="${orders}">
                    <div class="card shadow-sm mb-4">
                        <div class="card-header d-flex justify-content-between align-items-center">
                            <div>
                                <h5 class="mb-0">Order #${order.orderId}</h5>
                                <small class="text-muted">
                                    <fmt:formatDate value="${order.orderDate}" pattern="MMM dd, yyyy 'at' hh:mm a" />
                                </small>
                            </div>
                            <div class="text-end">
                                <span class="order-status status-${order.status.toString().toLowerCase()}">${order.status}</span>
                                <div class="fw-bold text-success">${order.formattedTotalAmount}</div>
                            </div>
                        </div>
                        <div class="card-body">
                            <div class="row">
                                <div class="col-md-8">
                                    <h6 class="fw-bold mb-2">Items (${order.totalItems})</h6>
                                    <div class="row">
                                        <c:forEach var="item" items="${order.orderItems}" varStatus="status">
                                            <c:if test="${status.index < 3}">
                                                <div class="col-md-4 mb-2">
                                                    <small class="text-muted">
                                                        ${item.productName} (${item.quantity}x)
                                                    </small>
                                                </div>
                                            </c:if>
                                        </c:forEach>
                                        <c:if test="${order.orderItems.size() > 3}">
                                            <div class="col-md-4">
                                                <small class="text-muted">
                                                    +${order.orderItems.size() - 3} more items
                                                </small>
                                            </div>
                                        </c:if>
                                    </div>
                                </div>
                                <div class="col-md-4 text-md-end">
                                    <div class="d-flex gap-2 flex-wrap justify-content-md-end">
                                        <a href="${pageContext.request.contextPath}/track-order?orderId=${order.orderId}" 
                                           class="btn btn-outline-success btn-sm">
                                            <i class="fas fa-search me-1"></i>Track
                                        </a>
                                        <c:if test="${order.status == 'PENDING' || order.status == 'CONFIRMED'}">
                                            <form method="post" action="${pageContext.request.contextPath}/order-history" class="d-inline">
                                                <input type="hidden" name="action" value="cancel">
                                                <input type="hidden" name="orderId" value="${order.orderId}">
                                                <button type="submit" class="btn btn-outline-danger btn-sm"
                                                        onclick="return confirm('Are you sure you want to cancel this order?')">
                                                    <i class="fas fa-times me-1"></i>Cancel
                                                </button>
                                            </form>
                                        </c:if>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </c:when>
            <c:otherwise>
                <div class="text-center py-5">
                    <i class="fas fa-shopping-bag fa-4x text-muted mb-4"></i>
                    <h3 class="text-muted mb-3">No Orders Yet</h3>
                    <p class="text-muted mb-4">
                        You haven't placed any orders yet. Start shopping to see your order history here.
                    </p>
                    <a href="${pageContext.request.contextPath}/products" class="btn btn-success btn-lg">
                        <i class="fas fa-shopping-basket me-2"></i>Start Shopping
                    </a>
                </div>
            </c:otherwise>
        </c:choose>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>