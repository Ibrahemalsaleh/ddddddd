<?php

function addToCart(PDO $pdo, $productId, $quantity, $sessionId) {
    try {
        // Validate inputs
        $productId = filter_var($productId, FILTER_VALIDATE_INT);
        $quantity = filter_var($quantity, FILTER_VALIDATE_INT);
        
        if (!$productId || $quantity <= 0) {
            $_SESSION['error_message'] = "Invalid product or quantity.";
            header('Location: index.php?page=products');
            exit();
        }
        
        // Check if product exists
        $productStmt = $pdo->prepare("SELECT id FROM products WHERE id = ?");
        $productStmt->execute([$productId]);
        if (!$productStmt->fetch()) {
            $_SESSION['error_message'] = "Product not found.";
            header('Location: index.php?page=products');
            exit();
        }
        
        // Check if product already exists in cart for this session
        $stmt = $pdo->prepare("SELECT * FROM cart_items WHERE session_id = ? AND product_id = ?");
        $stmt->execute([$sessionId, $productId]);
        $existingCartItem = $stmt->fetch(PDO::FETCH_ASSOC);

        if ($existingCartItem) {
            // If product exists, update the quantity
            $newQuantity = $existingCartItem['quantity'] + $quantity;
            $updateStmt = $pdo->prepare("UPDATE cart_items SET quantity = ? WHERE id = ?");
            $updateStmt->execute([$newQuantity, $existingCartItem['id']]);
        } else {
            // If product does not exist, add it to cart
            $insertStmt = $pdo->prepare("INSERT INTO cart_items (session_id, product_id, quantity) VALUES (?, ?, ?)");
            $insertStmt->execute([$sessionId, $productId, $quantity]);
        }
        
        $_SESSION['success_message'] = "Item added to cart successfully.";
        header('Location: index.php?page=cart'); // Redirect to cart page
        exit();
    } catch (PDOException $e) {
        $_SESSION['error_message'] = "Database error: " . $e->getMessage();
        header('Location: index.php?page=products');
        exit();
    }
}

function viewCart(PDO $pdo, $sessionId) {
    try {
        $stmt = $pdo->prepare("
            SELECT cart_items.id as cart_item_id, cart_items.product_id, cart_items.quantity, products.*
            FROM cart_items
            INNER JOIN products ON cart_items.product_id = products.id
            WHERE cart_items.session_id = ?
        ");
        $stmt->execute([$sessionId]);
        $cartItems = $stmt->fetchAll(PDO::FETCH_ASSOC);

        $cartSubtotal = 0;
        foreach ($cartItems as $item) {
            $cartSubtotal += $item['price'] * $item['quantity'];
        }

        include 'views/cart.php';
    } catch (PDOException $e) {
        $_SESSION['error_message'] = "Database error: " . $e->getMessage();
        include 'views/error.php';
    }
}

function updateCartQuantity(PDO $pdo, $quantities, $sessionId) {
    try {
        foreach ($quantities as $productId => $quantity) {
            $productId = filter_var($productId, FILTER_VALIDATE_INT);
            $quantity = filter_var($quantity, FILTER_VALIDATE_INT);
            
            if (!$productId) {
                continue; // Skip invalid product IDs
            }
            
            if ($quantity > 0) {
                $updateStmt = $pdo->prepare("UPDATE cart_items SET quantity = ? WHERE session_id = ? AND product_id = ?");
                $updateStmt->execute([$quantity, $sessionId, $productId]);
            } else {
                // If quantity is zero or less, remove item from cart
                removeCartItem($pdo, $productId, $sessionId, false);
            }
        }
        $_SESSION['success_message'] = "Cart updated successfully.";
        header('Location: index.php?page=cart');
        exit();
    } catch (PDOException $e) {
        $_SESSION['error_message'] = "Database error: " . $e->getMessage();
        header('Location: index.php?page=cart');
        exit();
    }
}

function removeCartItem(PDO $pdo, $productId, $sessionId, $redirect = true) {
    try {
        $productId = filter_var($productId, FILTER_VALIDATE_INT);
        if (!$productId) {
            if ($redirect) {
                $_SESSION['error_message'] = "Invalid product ID.";
                header('Location: index.php?page=cart');
                exit();
            }
            return;
        }
        
        $stmt = $pdo->prepare("DELETE FROM cart_items WHERE session_id = ? AND product_id = ?");
        $stmt->execute([$sessionId, $productId]);
        
        if ($redirect) {
            $_SESSION['success_message'] = "Item removed from cart.";
            header('Location: index.php?page=cart');
            exit();
        }
    } catch (PDOException $e) {
        if ($redirect) {
            $_SESSION['error_message'] = "Database error: " . $e->getMessage();
            header('Location: index.php?page=cart');
            exit();
        }
    }
}

function clearCart(PDO $pdo, $sessionId) {
    try {
        $stmt = $pdo->prepare("DELETE FROM cart_items WHERE session_id = ?");
        $stmt->execute([$sessionId]);
        
        $_SESSION['success_message'] = "Cart cleared successfully.";
        header('Location: index.php?page=cart');
        exit();
    } catch (PDOException $e) {
        $_SESSION['error_message'] = "Database error: " . $e->getMessage();
        header('Location: index.php?page=cart');
        exit();
    }
}

function viewCheckout(PDO $pdo, $sessionId) {
    try {
        $stmt = $pdo->prepare("
            SELECT cart_items.quantity, products.*
            FROM cart_items
            INNER JOIN products ON cart_items.product_id = products.id
            WHERE cart_items.session_id = ?
        ");
        $stmt->execute([$sessionId]);
        $cartItems = $stmt->fetchAll(PDO::FETCH_ASSOC);

        if (empty($cartItems)) {
            $_SESSION['error_message'] = "Your cart is empty. Please add items before checkout.";
            header('Location: index.php?page=products');
            exit();
        }

        $cartSubtotal = 0;
        foreach ($cartItems as $item) {
            $cartSubtotal += $item['price'] * $item['quantity'];
        }

        include 'views/checkout.php';
    } catch (PDOException $e) {
        $_SESSION['error_message'] = "Database error: " . $e->getMessage();
        header('Location: index.php?page=cart');
        exit();
    }
}

function processCheckout(PDO $pdo, $customerData, $sessionId) {
    try {
        // Validate required inputs
        if (empty($customerData['customer_name']) || empty($customerData['customer_address'])) {
            $_SESSION['error_message'] = "Please fill in all required fields.";
            header('Location: index.php?page=checkout');
            exit();
        }
        
        // Validate email if provided
        if (!empty($customerData['customer_email']) && !filter_var($customerData['customer_email'], FILTER_VALIDATE_EMAIL)) {
            $_SESSION['error_message'] = "Please enter a valid email address.";
            header('Location: index.php?page=checkout');
            exit();
        }

        // Get cart items for this session
        $stmt = $pdo->prepare("
            SELECT cart_items.quantity, products.*
            FROM cart_items
            INNER JOIN products ON cart_items.product_id = products.id
            WHERE cart_items.session_id = ?
        ");
        $stmt->execute([$sessionId]);
        $cartItems = $stmt->fetchAll(PDO::FETCH_ASSOC);
        
        if (empty($cartItems)) {
            $_SESSION['error_message'] = "Your cart is empty. Please add items before checkout.";
            header('Location: index.php?page=products');
            exit();
        }
        
        // Calculate total amount
        $totalAmount = 0;
        foreach ($cartItems as $item) {
            $totalAmount += $item['price'] * $item['quantity'];
        }
        
        // Begin transaction
        $pdo->beginTransaction();
        
        // Insert order into orders table
        $orderStmt = $pdo->prepare("
            INSERT INTO orders (
                session_id, 
                customer_name, 
                customer_email, 
                customer_address, 
                payment_method, 
                total_amount, 
                order_date
            ) VALUES (?, ?, ?, ?, ?, ?, NOW())
        ");
        
        $orderStmt->execute([
            $sessionId,
            $customerData['customer_name'],
            $customerData['customer_email'] ?? '',
            $customerData['customer_address'],
            $customerData['paymentMethod'] ?? 'credit_card',
            $totalAmount
        ]);
        
        $orderId = $pdo->lastInsertId();
        
        // Insert order items
        $orderItemStmt = $pdo->prepare("
            INSERT INTO order_items (
                order_id,
                product_id,
                quantity,
                price
            ) VALUES (?, ?, ?, ?)
        ");
        
        foreach ($cartItems as $item) {
            $orderItemStmt->execute([
                $orderId,
                $item['id'],
                $item['quantity'],
                $item['price']
            ]);
        }
        
        // Commit transaction
        $pdo->commit();
        
        // Store order ID in session for confirmation page
        $_SESSION['last_order_id'] = $orderId;
        
        // Clear the cart after successful checkout
        $clearStmt = $pdo->prepare("DELETE FROM cart_items WHERE session_id = ?");
        $clearStmt->execute([$sessionId]);
        
        header('Location: index.php?page=order_confirmation'); 
        exit();
    } catch (PDOException $e) {
        // Roll back transaction on error
        if ($pdo->inTransaction()) {
            $pdo->rollBack();
        }
        
        $_SESSION['error_message'] = "Database error: " . $e->getMessage();
        header('Location: index.php?page=checkout');
        exit();
    }
}

function viewOrderConfirmation(PDO $pdo) {
    try {
        $orderId = $_SESSION['last_order_id'] ?? null;
        
        if (!$orderId) {
            header('Location: index.php?page=products');
            exit();
        }
        
        // Get order details
        $orderStmt = $pdo->prepare("
            SELECT * FROM orders WHERE id = ?
        ");
        $orderStmt->execute([$orderId]);
        $order = $orderStmt->fetch(PDO::FETCH_ASSOC);
        
        if (!$order) {
            $_SESSION['error_message'] = "Order not found.";
            header('Location: index.php?page=products');
            exit();
        }
        
        // Get order items
        $itemsStmt = $pdo->prepare("
            SELECT oi.*, p.name
            FROM order_items oi
            JOIN products p ON oi.product_id = p.id
            WHERE oi.order_id = ?
        ");
        $itemsStmt->execute([$orderId]);
        $orderItems = $itemsStmt->fetchAll(PDO::FETCH_ASSOC);
        
        include 'views/order_confirmation.php';
        
        // Clear the order ID from session after showing confirmation
        unset($_SESSION['last_order_id']);
    } catch (PDOException $e) {
        $_SESSION['error_message'] = "Database error: " . $e->getMessage();
        header('Location: index.php?page=products');
        exit();
    }
}