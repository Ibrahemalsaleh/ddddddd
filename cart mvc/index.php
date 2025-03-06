<?php
session_start();

require_once 'config.php'; // Include database connection configuration
require_once 'controllers/products_controller.php';
require_once 'controllers/cart_controller.php';

// Handle session initialization
if (!isset($_SESSION['initialized'])) {
    // Set session timeout (30 minutes)
    ini_set('session.gc_maxlifetime', 1800);
    session_regenerate_id(true); // Regenerate session ID to prevent session fixation
    $_SESSION['initialized'] = true;
}

// Handle page routing
$page = $_GET['page'] ?? 'products';

// Check for flash messages
$errorMessage = $_SESSION['error_message'] ?? null;
$successMessage = $_SESSION['success_message'] ?? null;

// Clear flash messages after reading them
unset($_SESSION['error_message']);
unset($_SESSION['success_message']);

try {
    switch ($page) {
        case 'products':
            listProducts($pdo); 
            break;
        case 'add_to_cart':
            if (!isset($_GET['product_id']) || !isset($_GET['quantity'])) {
                $_SESSION['error_message'] = "Missing product information.";
                header('Location: index.php?page=products');
                exit();
            }
            addToCart($pdo, $_GET['product_id'], $_GET['quantity'], session_id()); 
            break;
        case 'cart':
            viewCart($pdo, session_id()); 
            break;
        case 'update_cart_quantity':
            if (!isset($_POST['quantities']) || !is_array($_POST['quantities'])) {
                $_SESSION['error_message'] = "Invalid request.";
                header('Location: index.php?page=cart');
                exit();
            }
            updateCartQuantity($pdo, $_POST['quantities'], session_id()); 
            break;
        case 'remove_cart_item':
            if (!isset($_GET['product_id'])) {
                $_SESSION['error_message'] = "Invalid product.";
                header('Location: index.php?page=cart');
                exit();
            }
            removeCartItem($pdo, $_GET['product_id'], session_id()); 
            break;
        case 'clear_cart':
            clearCart($pdo, session_id()); 
            break;
        case 'checkout':
            viewCheckout($pdo, session_id()); 
            break;
        case 'process_checkout':
            processCheckout($pdo, $_POST, session_id()); 
            break;
        case 'order_confirmation':
            viewOrderConfirmation($pdo); // Pass PDO object to access order data
            break;
        default:
            listProducts($pdo);
            break;
    }
} catch (Exception $e) {
    // Global error handler
    $_SESSION['error_message'] = "An error occurred: " . $e->getMessage();
    header('Location: index.php?page=products');
    exit();
}