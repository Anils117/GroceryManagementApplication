# Online Grocery Store - Full Stack Web Application

A complete full-stack grocery store web application built with **Java Servlets**, **JSP**, **Bootstrap**, and following the **MVC architectural pattern**.

## 🚀 Features

### 👨‍💻 User Module
- **User Registration & Login** - Secure user authentication
- **Product Browsing** - View products with search and category filtering
- **Shopping Cart** - Add/remove items, update quantities (session-based)
- **Order Management** - Place orders and view order history
- **Order Tracking** - Track order status with dummy tracking system
- **Payment Processing** - Dummy payment gateway with card validation

### 🔐 Admin Module
- **Admin Authentication** - Hardcoded admin login (admin@grocery.com / admin123)
- **User Management** - View and activate/deactivate users
- **Product Management** - Add, edit, delete, and manage products
- **Order Management** - View and update order statuses
- **Dashboard** - Overview of system statistics

### 💳 Payment System
- **Dummy Payment Gateway** - Simulated payment processing
- **Card Validation** - Luhn algorithm validation
- **Payment Confirmation** - Success/failure handling
- **Transaction Management** - Generate dummy transaction IDs

## 🛠️ Technical Stack

- **Backend**: Java 11, Servlets, JSP
- **Frontend**: HTML5, CSS3, Bootstrap 5, JavaScript
- **Architecture**: MVC Pattern
- **Session Management**: HTTP Sessions for cart and user state
- **Data Storage**: In-memory storage (HashMap) with dummy data
- **Build Tool**: Maven
- **Server**: Apache Tomcat (embedded via Maven plugin)

## 📁 Project Structure

```
online-grocery-store/
├── src/main/java/com/grocery/
│   ├── models/          # POJOs (User, Product, Order, CartItem, OrderItem)
│   ├── services/        # Business logic (UserService, ProductService, OrderService, PaymentService)
│   ├── servlets/        # Controllers (LoginServlet, ProductListServlet, CartServlet, etc.)
│   └── utils/           # Utility classes (CartUtils)
├── src/main/webapp/
│   ├── WEB-INF/
│   │   ├── views/       # JSP files
│   │   └── web.xml      # Deployment descriptor
│   ├── css/             # Custom stylesheets
│   ├── js/              # JavaScript files
│   └── index.jsp        # Home page
├── pom.xml              # Maven configuration
└── README.md            # This file
```

## 🚀 Quick Start

### Prerequisites
- **Java 11** or higher
- **Maven 3.6** or higher
- **Web browser** (Chrome, Firefox, Safari, Edge)

### Installation & Setup

1. **Clone the repository**
   ```bash
   git clone <repository-url>
   cd online-grocery-store
   ```

2. **Build the project**
   ```bash
   mvn clean compile
   ```

3. **Run the application**
   ```bash
   mvn tomcat7:run
   ```

4. **Access the application**
   - Open your browser and navigate to: `http://localhost:8080/grocery`
   - The application will be running on port 8080

### Alternative: Deploy to External Tomcat

1. **Build WAR file**
   ```bash
   mvn clean package
   ```

2. **Deploy**
   - Copy `target/online-grocery-store.war` to your Tomcat's `webapps` directory
   - Start Tomcat server
   - Access via `http://localhost:8080/online-grocery-store`

## 👥 Demo Accounts

### User Accounts
- **Email**: john.doe@email.com | **Password**: password123
- **Email**: jane.smith@email.com | **Password**: password456

### Admin Account
- **Email**: admin@grocery.com | **Password**: admin123

## 🎯 Application Flow

### User Journey
1. **Home Page** → Browse featured products and categories
2. **Registration/Login** → Create account or sign in
3. **Product Listing** → Search and filter products by category
4. **Shopping Cart** → Add products, update quantities
5. **Checkout** → Review cart and proceed to payment
6. **Payment** → Enter card details (use dummy data)
7. **Order Confirmation** → View order details and tracking
8. **Order History** → View past orders and track status

### Admin Journey
1. **Admin Login** → Access admin dashboard
2. **Dashboard** → View system statistics and metrics
3. **User Management** → View users, activate/deactivate accounts
4. **Product Management** → Add/edit/delete products
5. **Order Management** → View orders and update statuses

## 🛒 Product Categories

The application includes dummy data for the following categories:
- **Fruits & Vegetables** - Fresh produce
- **Dairy & Eggs** - Milk, cheese, eggs
- **Meat & Seafood** - Fresh meats and fish
- **Bakery** - Bread, pastries
- **Pantry** - Rice, pasta, oils

## 💳 Payment Testing

Use these dummy card numbers for testing:
- **Visa**: 4111111111111111
- **Mastercard**: 5555555555554444
- **American Express**: 378282246310005
- **CVV**: Any 3-4 digits
- **Expiry**: Any future date (MM/YY format)
- **Name**: Any name

## 🔧 Configuration

### Database Setup (Optional)
The application currently uses in-memory storage. To integrate with a database:

1. **Add database dependency** to `pom.xml`
2. **Create database schema** using provided SQL scripts
3. **Update service classes** to use JDBC/JPA instead of in-memory maps
4. **Configure database connection** in `web.xml` or properties file

### Customization
- **Modify product data** in `ProductService.initializeDummyProducts()`
- **Update admin credentials** in `UserService` class
- **Change styling** in `src/main/webapp/css/style.css`
- **Add new features** by creating new servlets and JSP pages

## 📱 Responsive Design

The application is fully responsive and works on:
- **Desktop** browsers (Chrome, Firefox, Safari, Edge)
- **Tablet** devices (iPad, Android tablets)
- **Mobile** devices (iPhone, Android phones)

## 🔒 Security Features

- **Input validation** on both client and server side
- **Session management** for user authentication
- **XSS prevention** using JSTL and proper escaping
- **SQL injection prevention** (when using database)
- **Password security** (in production, use hashing)

## 🐛 Troubleshooting

### Common Issues

1. **Port 8080 already in use**
   ```bash
   mvn tomcat7:run -Dmaven.tomcat.port=8081
   ```

2. **Maven build fails**
   - Ensure Java 11+ is installed and JAVA_HOME is set
   - Clear Maven cache: `mvn clean`

3. **JSP pages not loading**
   - Check that all JSP files are in `src/main/webapp/WEB-INF/views/`
   - Verify servlet mappings in `web.xml`

4. **CSS/JS not loading**
   - Ensure static files are in `src/main/webapp/css/` and `src/main/webapp/js/`
   - Check browser console for 404 errors

## 🚀 Future Enhancements

- **Database Integration** - MySQL/PostgreSQL support
- **Email Notifications** - Order confirmations and updates
- **Image Upload** - Product image management
- **Advanced Search** - Full-text search with filters
- **User Reviews** - Product rating and review system
- **Inventory Management** - Real-time stock tracking
- **Reports** - Sales and analytics dashboard
- **API Integration** - REST API for mobile apps

## 📄 License

This project is developed for educational purposes. Feel free to use and modify as needed.

## 👨‍💻 Developer

Built with ❤️ using Java Servlets, JSP, and Bootstrap

---

**Happy Shopping! 🛒**