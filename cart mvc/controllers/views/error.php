<!DOCTYPE html>
<html lang="en" dir="ltr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Error</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.rtl.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/remixicon@3.4.0/fonts/remixicon.css" rel="stylesheet">
    <link rel="stylesheet" href="css/styles.css"> <link rel="stylesheet" href="css/responsive.css">
</head>
<body>

    <!-- Navbar (Same as other pages) -->
    <nav class="navbar navbar-expand-md navbar-light bg-light">
        <!-- ... navbar content ... -->
    </nav>

    <div class="container py-5">
        <div class="row justify-content-center">
            <div class="col-md-8">
                <div class="card border-danger">
                    <div class="card-header bg-danger text-white">
                        <h3 class="m-0">Error</h3>
                    </div>
                    <div class="card-body">
                        <div class="alert alert-danger">
                            <?php echo htmlspecialchars($_SESSION['error_message'] ?? 'An unexpected error occurred.'); ?>
                        </div>
                        <div class="text-center mt-4">
                            <a href="index.php?page=products" class="btn btn-primary">Return to Products</a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Footer (Same as other pages) -->
    <footer class="footer py-5">
        <!-- ... footer content ... -->
    </footer>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script src="js/scripts.js"></script>
</body>
</html>