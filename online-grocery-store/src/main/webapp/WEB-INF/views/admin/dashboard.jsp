<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard - Fresh Grocery Store</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/css/style.css" rel="stylesheet">
</head>
<body>
    <!-- Admin Navigation -->
    <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
        <div class="container-fluid">
            <a class="navbar-brand" href="${pageContext.request.contextPath}/admin/dashboard">
                <i class="fas fa-user-shield me-2"></i>
                Admin Panel
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
            <nav class="col-md-3 col-lg-2 d-md-block admin-sidebar collapse">
                <div class="position-sticky pt-3">
                    <ul class="nav flex-column">
                        <li class="nav-item">
                            <a class="nav-link active" href="${pageContext.request.contextPath}/admin/dashboard">
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
                            <a class="nav-link" href="${pageContext.request.contextPath}/admin/orders">
                                <i class="fas fa-shopping-cart me-2"></i>Orders
                            </a>
                        </li>
                    </ul>
                </div>
            </nav>

            <!-- Main Content -->
            <main class="col-md-9 ms-sm-auto col-lg-10 px-md-4">
                <div class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 mb-3 border-bottom">
                    <h1 class="h2">
                        <i class="fas fa-tachometer-alt me-2"></i>Dashboard
                    </h1>
                    <div class="btn-toolbar mb-2 mb-md-0">
                        <div class="btn-group me-2">
                            <button type="button" class="btn btn-sm btn-outline-secondary">
                                <i class="fas fa-download me-1"></i>Export
                            </button>
                        </div>
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

                <!-- Statistics Cards -->
                <div class="row mb-4">
                    <div class="col-xl-3 col-md-6 mb-4">
                        <div class="card admin-card stat-card h-100">
                            <div class="card-body">
                                <div class="row no-gutters align-items-center">
                                    <div class="col mr-2">
                                        <div class="text-xs font-weight-bold text-uppercase mb-1">Total Users</div>
                                        <div class="h5 mb-0 font-weight-bold">${totalUsers}</div>
                                        <small class="text-light">Active: ${activeUsers}</small>
                                    </div>
                                    <div class="col-auto">
                                        <i class="fas fa-users fa-2x"></i>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="col-xl-3 col-md-6 mb-4">
                        <div class="card admin-card stat-card h-100">
                            <div class="card-body">
                                <div class="row no-gutters align-items-center">
                                    <div class="col mr-2">
                                        <div class="text-xs font-weight-bold text-uppercase mb-1">Total Products</div>
                                        <div class="h5 mb-0 font-weight-bold">${totalProducts}</div>
                                        <small class="text-light">Active: ${activeProducts}</small>
                                    </div>
                                    <div class="col-auto">
                                        <i class="fas fa-box fa-2x"></i>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="col-xl-3 col-md-6 mb-4">
                        <div class="card admin-card stat-card h-100">
                            <div class="card-body">
                                <div class="row no-gutters align-items-center">
                                    <div class="col mr-2">
                                        <div class="text-xs font-weight-bold text-uppercase mb-1">Total Orders</div>
                                        <div class="h5 mb-0 font-weight-bold">${orderStats.totalOrders}</div>
                                        <small class="text-light">Delivered: ${orderStats.deliveredOrders}</small>
                                    </div>
                                    <div class="col-auto">
                                        <i class="fas fa-shopping-cart fa-2x"></i>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="col-xl-3 col-md-6 mb-4">
                        <div class="card admin-card stat-card h-100">
                            <div class="card-body">
                                <div class="row no-gutters align-items-center">
                                    <div class="col mr-2">
                                        <div class="text-xs font-weight-bold text-uppercase mb-1">Total Revenue</div>
                                        <div class="h5 mb-0 font-weight-bold">$${orderStats.totalRevenue}</div>
                                        <small class="text-light">This month</small>
                                    </div>
                                    <div class="col-auto">
                                        <i class="fas fa-dollar-sign fa-2x"></i>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Order Status Overview -->
                <div class="row mb-4">
                    <div class="col-lg-6">
                        <div class="card admin-card">
                            <div class="card-header">
                                <h5 class="mb-0">
                                    <i class="fas fa-chart-pie me-2"></i>Order Status Overview
                                </h5>
                            </div>
                            <div class="card-body">
                                <div class="row">
                                    <div class="col-6 mb-3">
                                        <div class="d-flex align-items-center">
                                            <div class="bg-warning rounded-circle me-2" style="width: 12px; height: 12px;"></div>
                                            <span class="small">Pending: ${orderStats.pendingOrders}</span>
                                        </div>
                                    </div>
                                    <div class="col-6 mb-3">
                                        <div class="d-flex align-items-center">
                                            <div class="bg-info rounded-circle me-2" style="width: 12px; height: 12px;"></div>
                                            <span class="small">Confirmed: ${orderStats.confirmedOrders}</span>
                                        </div>
                                    </div>
                                    <div class="col-6 mb-3">
                                        <div class="d-flex align-items-center">
                                            <div class="bg-primary rounded-circle me-2" style="width: 12px; height: 12px;"></div>
                                            <span class="small">Shipped: ${orderStats.shippedOrders}</span>
                                        </div>
                                    </div>
                                    <div class="col-6 mb-3">
                                        <div class="d-flex align-items-center">
                                            <div class="bg-success rounded-circle me-2" style="width: 12px; height: 12px;"></div>
                                            <span class="small">Delivered: ${orderStats.deliveredOrders}</span>
                                        </div>
                                    </div>
                                    <div class="col-6">
                                        <div class="d-flex align-items-center">
                                            <div class="bg-danger rounded-circle me-2" style="width: 12px; height: 12px;"></div>
                                            <span class="small">Cancelled: ${orderStats.cancelledOrders}</span>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="col-lg-6">
                        <div class="card admin-card">
                            <div class="card-header">
                                <h5 class="mb-0">
                                    <i class="fas fa-exclamation-triangle me-2"></i>Inventory Alerts
                                </h5>
                            </div>
                            <div class="card-body">
                                <div class="mb-3">
                                    <div class="d-flex justify-content-between align-items-center">
                                        <span class="text-warning">
                                            <i class="fas fa-exclamation-circle me-1"></i>Low Stock Products
                                        </span>
                                        <span class="badge bg-warning text-dark">${lowStockProducts}</span>
                                    </div>
                                </div>
                                <div class="mb-3">
                                    <div class="d-flex justify-content-between align-items-center">
                                        <span class="text-danger">
                                            <i class="fas fa-times-circle me-1"></i>Out of Stock Products
                                        </span>
                                        <span class="badge bg-danger">${outOfStockProducts}</span>
                                    </div>
                                </div>
                                <div class="text-center mt-3">
                                    <a href="${pageContext.request.contextPath}/admin/products" class="btn btn-outline-primary btn-sm">
                                        <i class="fas fa-eye me-1"></i>View Products
                                    </a>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Quick Actions -->
                <div class="row">
                    <div class="col-12">
                        <div class="card admin-card">
                            <div class="card-header">
                                <h5 class="mb-0">
                                    <i class="fas fa-bolt me-2"></i>Quick Actions
                                </h5>
                            </div>
                            <div class="card-body">
                                <div class="row">
                                    <div class="col-md-3 mb-3">
                                        <a href="${pageContext.request.contextPath}/admin/products?action=add" 
                                           class="btn btn-success w-100">
                                            <i class="fas fa-plus me-2"></i>Add Product
                                        </a>
                                    </div>
                                    <div class="col-md-3 mb-3">
                                        <a href="${pageContext.request.contextPath}/admin/users" 
                                           class="btn btn-info w-100">
                                            <i class="fas fa-users me-2"></i>Manage Users
                                        </a>
                                    </div>
                                    <div class="col-md-3 mb-3">
                                        <a href="${pageContext.request.contextPath}/admin/orders" 
                                           class="btn btn-warning w-100">
                                            <i class="fas fa-shopping-cart me-2"></i>View Orders
                                        </a>
                                    </div>
                                    <div class="col-md-3 mb-3">
                                        <a href="${pageContext.request.contextPath}/" target="_blank"
                                           class="btn btn-outline-secondary w-100">
                                            <i class="fas fa-external-link-alt me-2"></i>View Store
                                        </a>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </main>
        </div>
    </div>

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