<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Manage Orders - Admin Panel</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/css/style.css" rel="stylesheet">
</head>
<body>
    <!-- Admin Navigation -->
    <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
        <div class="container-fluid">
            <a class="navbar-brand" href="${pageContext.request.contextPath}/admin/dashboard">
                <i class="fas fa-user-shield me-2"></i>Admin Panel
            </a>
            <div class="navbar-nav ms-auto">
                <a class="nav-link" href="${pageContext.request.contextPath}/" target="_blank">
                    <i class="fas fa-external-link-alt me-1"></i>View Store
                </a>
                <a class="nav-link" href="${pageContext.request.contextPath}/logout">
                    <i class="fas fa-sign-out-alt me-1"></i>Logout
                </a>
            </div>
        </div>
    </nav>

    <div class="container-fluid">
        <div class="row">
            <!-- Sidebar -->
            <nav class="col-md-3 col-lg-2 d-md-block admin-sidebar">
                <div class="position-sticky pt-3">
                    <ul class="nav flex-column">
                        <li class="nav-item">
                            <a class="nav-link" href="${pageContext.request.contextPath}/admin/dashboard">
                                <i class="fas fa-tachometer-alt me-2"></i>Dashboard
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="${pageContext.request.contextPath}/admin/users">
                                <i class="fas fa-users me-2"></i>Users
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="${pageContext.request.contextPath}/admin/products">
                                <i class="fas fa-box me-2"></i>Products
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link active" href="${pageContext.request.contextPath}/admin/orders">
                                <i class="fas fa-shopping-cart me-2"></i>Orders
                            </a>
                        </li>
                    </ul>
                </div>
            </nav>

            <!-- Main Content -->
            <main class="col-md-9 ms-sm-auto col-lg-10 px-md-4">
                <div class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 mb-3 border-bottom">
                    <h1 class="h2"><i class="fas fa-shopping-cart me-2"></i>Manage Orders</h1>
                    <div class="btn-toolbar mb-2 mb-md-0">
                        <div class="btn-group me-2">
                            <a href="${pageContext.request.contextPath}/admin/orders" 
                               class="btn ${empty statusFilter ? 'btn-primary' : 'btn-outline-primary'}">
                                All Orders
                            </a>
                            <a href="${pageContext.request.contextPath}/admin/orders?status=PENDING" 
                               class="btn ${statusFilter == 'PENDING' ? 'btn-warning' : 'btn-outline-warning'}">
                                Pending
                            </a>
                            <a href="${pageContext.request.contextPath}/admin/orders?status=CONFIRMED" 
                               class="btn ${statusFilter == 'CONFIRMED' ? 'btn-info' : 'btn-outline-info'}">
                                Confirmed
                            </a>
                            <a href="${pageContext.request.contextPath}/admin/orders?status=SHIPPED" 
                               class="btn ${statusFilter == 'SHIPPED' ? 'btn-success' : 'btn-outline-success'}">
                                Shipped
                            </a>
                        </div>
                    </div>
                </div>

                <!-- Success/Error Messages -->
                <c:if test="${not empty success}">
                    <div class="alert alert-success alert-dismissible fade show" role="alert">
                        <i class="fas fa-check-circle me-2"></i>
                        ${success}
                        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                    </div>
                </c:if>

                <c:if test="${not empty error}">
                    <div class="alert alert-danger alert-dismissible fade show" role="alert">
                        <i class="fas fa-exclamation-circle me-2"></i>
                        ${error}
                        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                    </div>
                </c:if>

                <!-- Orders Table -->
                <div class="card admin-card">
                    <div class="card-header d-flex justify-content-between align-items-center">
                        <h5 class="mb-0">
                            ${not empty statusFilter ? statusFilter : 'All'} Orders
                        </h5>
                        <small class="text-muted">Total: ${orders.size()} orders</small>
                    </div>
                    <div class="card-body p-0">
                        <c:choose>
                            <c:when test="${not empty orders}">
                                <div class="table-responsive">
                                    <table class="table table-hover mb-0">
                                        <thead class="table-light">
                                            <tr>
                                                <th>Order ID</th>
                                                <th>Customer</th>
                                                <th>Date</th>
                                                <th>Items</th>
                                                <th>Total</th>
                                                <th>Status</th>
                                                <th>Actions</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:forEach var="order" items="${orders}">
                                                <tr>
                                                    <td class="fw-bold">#${order.orderId}</td>
                                                    <td>
                                                        <div>User ID: ${order.userId}</div>
                                                        <small class="text-muted">
                                                            Transaction: ${order.transactionId}
                                                        </small>
                                                    </td>
                                                    <td>
                                                        <fmt:formatDate value="${order.orderDate}" pattern="MMM dd, yyyy" />
                                                        <br>
                                                        <small class="text-muted">
                                                            <fmt:formatDate value="${order.orderDate}" pattern="hh:mm a" />
                                                        </small>
                                                    </td>
                                                    <td>
                                                        <span class="badge bg-light text-dark">
                                                            ${order.totalItems} items
                                                        </span>
                                                        <div class="mt-1">
                                                            <c:forEach var="item" items="${order.orderItems}" varStatus="status">
                                                                <c:if test="${status.index < 2}">
                                                                    <small class="text-muted d-block">
                                                                        ${item.productName} (${item.quantity}x)
                                                                    </small>
                                                                </c:if>
                                                            </c:forEach>
                                                            <c:if test="${order.orderItems.size() > 2}">
                                                                <small class="text-muted">
                                                                    +${order.orderItems.size() - 2} more...
                                                                </small>
                                                            </c:if>
                                                        </div>
                                                    </td>
                                                    <td>
                                                        <div class="fw-bold text-success">${order.formattedTotalAmount}</div>
                                                        <small class="text-muted">${order.paymentMethod}</small>
                                                    </td>
                                                    <td>
                                                        <span class="order-status status-${order.status.toString().toLowerCase()}">
                                                            ${order.status}
                                                        </span>
                                                    </td>
                                                    <td>
                                                        <div class="btn-group btn-group-sm">
                                                            <!-- Status Update Dropdown -->
                                                            <div class="dropdown">
                                                                <button class="btn btn-outline-primary dropdown-toggle" 
                                                                        type="button" data-bs-toggle="dropdown">
                                                                    <i class="fas fa-edit"></i>
                                                                </button>
                                                                <ul class="dropdown-menu">
                                                                    <li><h6 class="dropdown-header">Update Status</h6></li>
                                                                    <c:if test="${order.status != 'CONFIRMED'}">
                                                                        <li>
                                                                            <form method="post" action="${pageContext.request.contextPath}/admin/orders" class="d-inline">
                                                                                <input type="hidden" name="action" value="updateStatus">
                                                                                <input type="hidden" name="orderId" value="${order.orderId}">
                                                                                <input type="hidden" name="status" value="CONFIRMED">
                                                                                <button type="submit" class="dropdown-item">
                                                                                    <i class="fas fa-check text-info me-2"></i>Confirm
                                                                                </button>
                                                                            </form>
                                                                        </li>
                                                                    </c:if>
                                                                    <c:if test="${order.status != 'PROCESSING'}">
                                                                        <li>
                                                                            <form method="post" action="${pageContext.request.contextPath}/admin/orders" class="d-inline">
                                                                                <input type="hidden" name="action" value="updateStatus">
                                                                                <input type="hidden" name="orderId" value="${order.orderId}">
                                                                                <input type="hidden" name="status" value="PROCESSING">
                                                                                <button type="submit" class="dropdown-item">
                                                                                    <i class="fas fa-cog text-warning me-2"></i>Processing
                                                                                </button>
                                                                            </form>
                                                                        </li>
                                                                    </c:if>
                                                                    <c:if test="${order.status != 'SHIPPED'}">
                                                                        <li>
                                                                            <form method="post" action="${pageContext.request.contextPath}/admin/orders" class="d-inline">
                                                                                <input type="hidden" name="action" value="updateStatus">
                                                                                <input type="hidden" name="orderId" value="${order.orderId}">
                                                                                <input type="hidden" name="status" value="SHIPPED">
                                                                                <button type="submit" class="dropdown-item">
                                                                                    <i class="fas fa-shipping-fast text-primary me-2"></i>Ship
                                                                                </button>
                                                                            </form>
                                                                        </li>
                                                                    </c:if>
                                                                    <c:if test="${order.status != 'DELIVERED'}">
                                                                        <li>
                                                                            <form method="post" action="${pageContext.request.contextPath}/admin/orders" class="d-inline">
                                                                                <input type="hidden" name="action" value="updateStatus">
                                                                                <input type="hidden" name="orderId" value="${order.orderId}">
                                                                                <input type="hidden" name="status" value="DELIVERED">
                                                                                <button type="submit" class="dropdown-item">
                                                                                    <i class="fas fa-check-circle text-success me-2"></i>Deliver
                                                                                </button>
                                                                            </form>
                                                                        </li>
                                                                    </c:if>
                                                                    <c:if test="${order.status == 'PENDING' || order.status == 'CONFIRMED'}">
                                                                        <li><hr class="dropdown-divider"></li>
                                                                        <li>
                                                                            <form method="post" action="${pageContext.request.contextPath}/admin/orders" class="d-inline">
                                                                                <input type="hidden" name="action" value="updateStatus">
                                                                                <input type="hidden" name="orderId" value="${order.orderId}">
                                                                                <input type="hidden" name="status" value="CANCELLED">
                                                                                <button type="submit" class="dropdown-item text-danger"
                                                                                        onclick="return confirm('Are you sure you want to cancel this order?')">
                                                                                    <i class="fas fa-times me-2"></i>Cancel
                                                                                </button>
                                                                            </form>
                                                                        </li>
                                                                    </c:if>
                                                                </ul>
                                                            </div>
                                                            
                                                            <!-- View Details Button -->
                                                            <button class="btn btn-outline-info" 
                                                                    data-bs-toggle="modal" 
                                                                    data-bs-target="#orderModal${order.orderId}">
                                                                <i class="fas fa-eye"></i>
                                                            </button>
                                                        </div>
                                                    </td>
                                                </tr>
                                            </c:forEach>
                                        </tbody>
                                    </table>
                                </div>
                            </c:when>
                            <c:otherwise>
                                <div class="text-center py-5">
                                    <i class="fas fa-shopping-cart fa-4x text-muted mb-3"></i>
                                    <h5 class="text-muted">No Orders Found</h5>
                                    <p class="text-muted">
                                        ${not empty statusFilter ? 'No orders with ' += statusFilter += ' status.' : 'No orders have been placed yet.'}
                                    </p>
                                </div>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>

                <!-- Order Statistics -->
                <c:if test="${not empty orders}">
                    <div class="row mt-4">
                        <div class="col-md-3">
                            <div class="card bg-primary text-white">
                                <div class="card-body">
                                    <div class="d-flex justify-content-between">
                                        <div>
                                            <h6 class="card-title">Total Orders</h6>
                                            <h3>${orders.size()}</h3>
                                        </div>
                                        <div class="align-self-center">
                                            <i class="fas fa-shopping-cart fa-2x opacity-75"></i>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-3">
                            <div class="card bg-warning text-dark">
                                <div class="card-body">
                                    <div class="d-flex justify-content-between">
                                        <div>
                                            <h6 class="card-title">Pending</h6>
                                            <h3>
                                                <c:set var="pendingCount" value="0" />
                                                <c:forEach var="order" items="${orders}">
                                                    <c:if test="${order.status == 'PENDING'}">
                                                        <c:set var="pendingCount" value="${pendingCount + 1}" />
                                                    </c:if>
                                                </c:forEach>
                                                ${pendingCount}
                                            </h3>
                                        </div>
                                        <div class="align-self-center">
                                            <i class="fas fa-clock fa-2x opacity-75"></i>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-3">
                            <div class="card bg-info text-white">
                                <div class="card-body">
                                    <div class="d-flex justify-content-between">
                                        <div>
                                            <h6 class="card-title">Processing</h6>
                                            <h3>
                                                <c:set var="processingCount" value="0" />
                                                <c:forEach var="order" items="${orders}">
                                                    <c:if test="${order.status == 'PROCESSING' || order.status == 'CONFIRMED'}">
                                                        <c:set var="processingCount" value="${processingCount + 1}" />
                                                    </c:if>
                                                </c:forEach>
                                                ${processingCount}
                                            </h3>
                                        </div>
                                        <div class="align-self-center">
                                            <i class="fas fa-cog fa-2x opacity-75"></i>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-3">
                            <div class="card bg-success text-white">
                                <div class="card-body">
                                    <div class="d-flex justify-content-between">
                                        <div>
                                            <h6 class="card-title">Completed</h6>
                                            <h3>
                                                <c:set var="completedCount" value="0" />
                                                <c:forEach var="order" items="${orders}">
                                                    <c:if test="${order.status == 'DELIVERED'}">
                                                        <c:set var="completedCount" value="${completedCount + 1}" />
                                                    </c:if>
                                                </c:forEach>
                                                ${completedCount}
                                            </h3>
                                        </div>
                                        <div class="align-self-center">
                                            <i class="fas fa-check-circle fa-2x opacity-75"></i>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </c:if>
            </main>
        </div>
    </div>

    <!-- Order Detail Modals -->
    <c:forEach var="order" items="${orders}">
        <div class="modal fade" id="orderModal${order.orderId}" tabindex="-1">
            <div class="modal-dialog modal-lg">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title">Order #${order.orderId} Details</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                    </div>
                    <div class="modal-body">
                        <div class="row">
                            <div class="col-md-6">
                                <h6>Order Information</h6>
                                <p><strong>Date:</strong> <fmt:formatDate value="${order.orderDate}" pattern="MMM dd, yyyy 'at' hh:mm a" /></p>
                                <p><strong>Status:</strong> <span class="order-status status-${order.status.toString().toLowerCase()}">${order.status}</span></p>
                                <p><strong>Total:</strong> ${order.formattedTotalAmount}</p>
                                <p><strong>Payment Method:</strong> ${order.paymentMethod}</p>
                                <p><strong>Transaction ID:</strong> ${order.transactionId}</p>
                            </div>
                            <div class="col-md-6">
                                <h6>Shipping Address</h6>
                                <address>${order.shippingAddress}</address>
                            </div>
                        </div>
                        <hr>
                        <h6>Order Items</h6>
                        <div class="table-responsive">
                            <table class="table table-sm">
                                <thead>
                                    <tr>
                                        <th>Product</th>
                                        <th>Price</th>
                                        <th>Quantity</th>
                                        <th>Total</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="item" items="${order.orderItems}">
                                        <tr>
                                            <td>${item.productName}</td>
                                            <td>${item.formattedUnitPrice}</td>
                                            <td>${item.quantity}</td>
                                            <td>${item.formattedTotalPrice}</td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                    </div>
                </div>
            </div>
        </div>
    </c:forEach>

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