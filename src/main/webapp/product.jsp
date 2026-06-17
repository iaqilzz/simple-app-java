<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Product | BLOOMCART POS SYSTEM</title>

    
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css">

    <style>
        body {
            background-color: #f4f8f2;
            font-family: Arial, sans-serif;
        }

        .navbar {
            background: linear-gradient(to right, #2e7d32, #4caf50);
        }

        .main-container {
            margin-top: 20px;
        }

        .page-section,
        .content-card,
        .search-panel {
            background-color: white;
            border-radius: 15px;
            padding: 20px;
            box-shadow: 0 4px 10px rgba(0,0,0,0.1);
            border: none;
        }

        .page-title {
            color: #2e7d32;
            font-weight: bold;
        }

        .page-subtitle {
            color: #555;
        }

        .search-box {
            border-radius: 30px;
            padding: 10px 20px;
            border: 2px solid #4caf50;
        }

        .btn-green {
            background-color: #2e7d32;
            color: white;
            border: none;
            border-radius: 8px;
        }

        .btn-green:hover {
            background-color: #1b5e20;
            color: white;
        }

        .btn-update {
            background-color: #8d6e63;
            border: none;
            color: white;
            border-radius: 8px;
        }

        .btn-update:hover {
            background-color: #6d4c41;
            color: white;
        }

        .btn-delete {
            background-color: #bc4749;
            border: none;
            color: white;
            border-radius: 8px;
        }

        .btn-delete:hover {
            background-color: #9f3335;
            color: white;
        }

        .table {
            margin-bottom: 0;
        }

        .table thead th {
            background-color: #e8f5e9;
            color: #2e7d32;
            white-space: nowrap;
        }

        .table tbody tr:hover {
            background-color: #f9fff7;
        }

        .table td,
        .table th {
            vertical-align: middle;
        }

        .extra-details {
            min-width: 250px;
        }

        .badge-plant {
            background-color: #6d4c41;
            color: white;
        }

        .badge-tool {
            background-color: #8d6e63;
            color: white;
        }

        .table-footer {
            background-color: #f1f8e9;
            border-top: 1px solid #ddd;
            border-radius: 0 0 15px 15px;
        }

        .pagination .page-link {
            color: #2e7d32;
        }

        .pagination .page-item.active .page-link {
            background-color: #2e7d32;
            border-color: #2e7d32;
            color: white;
        }

        .modal-content {
            border: none;
            border-radius: 15px;
            overflow: hidden;
        }

        .modal-header {
            background: linear-gradient(to right, #2e7d32, #4caf50);
            color: white;
        }

        .modal-header .btn-close {
            filter: invert(1);
        }

        .form-label,
        .section-label {
            font-weight: bold;
            color: #2e7d32;
        }

        .section-label {
            border-bottom: 1px solid #ddd;
            padding-bottom: 6px;
        }

        .form-control,
        .form-select {
            border-radius: 8px;
        }

        .no-records-row td {
            color: #555;
        }
    </style>
</head>
<body>

    
    <nav class="navbar navbar-expand-lg navbar-dark shadow">
        <div class="container-fluid">
            <span class="navbar-brand fw-bold">
                <i class="fa-solid fa-leaf"></i>
                BLOOMCART POS SYSTEM
            </span>

            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                <span class="navbar-toggler-icon"></span>
            </button>

            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav ms-auto">
                    <li class="nav-item"><a class="nav-link" href="product.jsp">Product</a></li>
                    <li class="nav-item"><a class="nav-link" href="sale.jsp">Sale</a></li>
                    <li class="nav-item"><a class="nav-link" href="customer.jsp">Customer</a></li>
                    <li class="nav-item"><a class="nav-link" href="create-staff.jsp">Staff</a></li>
                    <li class="nav-item"><a class="nav-link" href="report.jsp">Report</a></li>
                    <li class="nav-item"><a class="nav-link text-warning" href="index.jsp">Logout</a></li>
                </ul>
            </div>
        </div>
    </nav>

    <div class="container-fluid main-container px-3 px-lg-4">
        
        <% 
            String status = request.getParameter("status");
            String message = request.getParameter("message");
            if ("success".equals(status)) {
        %>
            <div class="alert alert-success alert-dismissible fade show" role="alert">
                <i class="fa-solid fa-circle-check"></i> <strong>Success!</strong> Product added successfully.
                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
            </div>
        <%  } else if ("error".equals(status)) { %>
            <div class="alert alert-danger alert-dismissible fade show" role="alert">
                <i class="fa-solid fa-triangle-exclamation"></i> <strong>Error!</strong> <%= message != null ? message : "Failed to add product." %>
                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
            </div>
        <%  } %>

        <div class="page-section">
            <div class="d-flex flex-column flex-lg-row align-items-lg-center justify-content-between gap-3 mb-4">
                <div>
                    <h2 class="page-title mb-2">
                        <i class="fa-solid fa-seedling"></i>
                        Product
                    </h2>
                    <p class="page-subtitle mb-0">Manage product records based on category and product type</p>
                </div>

                <button class="btn btn-green" type="button" data-bs-toggle="modal" data-bs-target="#addProductModal">
                    <i class="fa-solid fa-plus"></i>
                    Add Product
                </button>
            </div>

            <div class="search-panel mb-4">
                <div class="row g-3 align-items-end">
                    <div class="col-lg-9">
                        <label for="productSearchInput" class="form-label">Search Product</label>
                        <input type="text" class="form-control search-box" id="productSearchInput" placeholder="Search by product ID, name, category, price, or details">
                    </div>
                    <div class="col-lg-3">
                        <button class="btn btn-green w-100" type="button" id="productSearchButton">
                            <i class="fa-solid fa-magnifying-glass"></i>
                            Search
                        </button>
                    </div>
                </div>
            </div>

            <div class="card content-card p-0">
                <div class="table-responsive">
                    <table class="table table-hover align-middle">
                        <thead>
                            <tr>
                                <th>No.</th>
                                <th>Product ID</th>
                                <th>Product Name</th>
                                <th>Category</th>
                                <th>Price</th>
                                <th>Extra Details</th>
                                <th>Action</th>
                            </tr>
                        </thead>
                        <tbody id="productTableBody">
                            <tr id="productNoRecords">
                                <td colspan="7" class="text-center py-5 text-muted">
                                    <i class="fa-solid fa-seedling fa-2x mb-2 d-block"></i>
                                    No product records found.
                                </td>
                            </tr>
                        </tbody>
                    </table>
                </div>

                <div class="table-footer d-flex flex-column flex-md-row align-items-center justify-content-between gap-3 p-3">
                    <span class="small text-muted" id="productPaginationInfo">Showing product records</span>
                    <nav aria-label="Product table pagination">
                        <ul class="pagination mb-0" id="productPagination">
                            <li class="page-item disabled">
                                <a class="page-link" href="#" aria-label="Previous page">&laquo;</a>
                            </li>
                            <li class="page-item active" aria-current="page">
                                <a class="page-link" href="#">1</a>
                            </li>
                            <li class="page-item">
                                <a class="page-link" href="#">2</a>
                            </li>
                            <li class="page-item">
                                <a class="page-link" href="#" aria-label="Next page">&raquo;</a>
                            </li>
                        </ul>
                    </nav>
                </div>
            </div>
        </div>
    </div>

    
    <div class="modal fade" id="addProductModal" tabindex="-1" aria-labelledby="addProductModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-lg modal-dialog-centered modal-dialog-scrollable">
            <div class="modal-content">
                <div class="modal-header">
                    <h2 class="modal-title fs-5" id="addProductModalLabel">
                        <i class="fa-solid fa-plus"></i>
                        Add Product
                    </h2>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>

                <div class="modal-body">
                    <form id="addProductForm" action="AddProductServlet" method="post">
                        <div class="row g-3">
                            <div class="col-md-12">
                                <label for="addProductName" class="form-label">Product Name</label>
                                <input type="text" class="form-control" id="addProductName" name="productName" placeholder="Enter product name" required>
                            </div>
                            <div class="col-md-4">
                                <label for="addProductPrice" class="form-label">Price</label>
                                <input type="number" step="0.01" class="form-control" id="addProductPrice" name="productPrice" placeholder="RM 0.00" required>
                            </div>
                            <div class="col-md-4">
                                <label for="addProductCategory" class="form-label">Category Name</label>
                                <input type="text" class="form-control" id="addProductCategory" name="productCategory" placeholder="e.g. Indoor Plant" required>
                            </div>
                            <div class="col-md-4">
                                <label for="addProductType" class="form-label">Product Type</label>
                                <select class="form-select" id="addProductType" name="productType" onchange="toggleProductType()" required>
                                    <option value="" selected disabled>Select product type</option>
                                    <option value="Plant">Plant</option>
                                    <option value="Tool">Tool</option>
                                </select>
                            </div>
                        </div>

                        <div class="mt-4" id="plantSection" style="display: none;">
                            <div class="section-label mb-3">Plant Details</div>
                            <div class="row g-3">
                                <div class="col-md-6">
                                    <label for="addScientificName" class="form-label">Scientific Name</label>
                                    <input type="text" class="form-control" id="addScientificName" name="scientificName" placeholder="Enter scientific name">
                                </div>
                                <div class="col-md-6">
                                    <label for="addSunlightReq" class="form-label">Sunlight Requirement (1-10)</label>
                                    <input type="number" class="form-control" id="addSunlightReq" name="sunlightReq" min="1" max="10" placeholder="Enter scale from 1 to 10">
                                </div>
                            </div>
                        </div>

                        <div class="mt-4" id="toolSection" style="display: none;">
                            <div class="section-label mb-3">Tool Details</div>
                            <div class="row g-3">
                                <div class="col-md-6">
                                    <label for="addMaterial" class="form-label">Material</label>
                                    <input type="text" class="form-control" id="addMaterial" name="material" placeholder="Enter material">
                                </div>
                                <div class="col-md-6">
                                    <label for="addWeight" class="form-label">Weight (kg)</label>
                                    <input type="number" step="0.01" class="form-control" id="addWeight" name="weight" placeholder="Enter weight in kg">
                                </div>
                            </div>
                        </div>
                    </form>
                </div>

                <div class="modal-footer">
                    <button type="button" class="btn btn-outline-secondary" data-bs-dismiss="modal">Cancel</button>
                    <button type="submit" class="btn btn-green" form="addProductForm">Save Product</button>
                </div>
            </div>
        </div>
    </div>

    
    <div class="modal fade" id="updateProductModal" tabindex="-1" aria-labelledby="updateProductModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-lg modal-dialog-centered modal-dialog-scrollable">
            <div class="modal-content">
                <div class="modal-header">
                    <h2 class="modal-title fs-5" id="updateProductModalLabel">
                        <i class="fa-solid fa-pen-to-square"></i>
                        Update Product
                    </h2>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>

                <div class="modal-body">
                    <form id="updateProductForm" action="#" method="post">
                        <div class="row g-3">
                            <div class="col-md-6">
                                <label for="updateProductId" class="form-label">Product ID</label>
                                <input type="text" class="form-control" id="updateProductId" value="">
                            </div>
                            <div class="col-md-6">
                                <label for="updateProductName" class="form-label">Product Name</label>
                                <input type="text" class="form-control" id="updateProductName" value="">
                            </div>
                            <div class="col-md-6">
                                <label for="updateProductPrice" class="form-label">Price</label>
                                <input type="text" class="form-control" id="updateProductPrice" value="">
                            </div>
                            <div class="col-md-6">
                                <label for="updateProductCategory" class="form-label">Category</label>
                                <select class="form-select" id="updateProductCategory">
                                    <option value="C001">C001 - Plant</option>
                                    <option value="C002">C002 - Tool</option>
                                </select>
                            </div>
                            <div class="col-md-6">
                                <label for="updateProductType" class="form-label">Product Type</label>
                                <select class="form-select" id="updateProductType">
                                    <option value="Plant">Plant</option>
                                    <option value="Tool">Tool</option>
                                </select>
                            </div>
                        </div>

                        <div class="mt-4">
                            <div class="section-label mb-3">Plant Details</div>
                            <div class="row g-3">
                                <div class="col-md-6">
                                    <label for="updateScientificName" class="form-label">Scientific Name</label>
                                    <input type="text" class="form-control" id="updateScientificName" value="">
                                </div>
                                <div class="col-md-6">
                                    <label for="updateSunlightReq" class="form-label">Sunlight Requirement</label>
                                    <input type="number" class="form-control" id="updateSunlightReq" min="1" max="10" value="" placeholder="Enter scale from 1 to 10">
                                </div>
                            </div>
                        </div>

                        <div class="mt-4">
                            <div class="section-label mb-3">Tool Details</div>
                            <div class="row g-3">
                                <div class="col-md-6">
                                    <label for="updateMaterial" class="form-label">Material</label>
                                    <input type="text" class="form-control" id="updateMaterial" value="">
                                </div>
                                <div class="col-md-6">
                                    <label for="updateWeight" class="form-label">Weight</label>
                                    <input type="text" class="form-control" id="updateWeight" value="">
                                </div>
                            </div>
                        </div>
                    </form>
                </div>

                <div class="modal-footer">
                    <button type="button" class="btn btn-outline-secondary" data-bs-dismiss="modal">Cancel</button>
                    <button type="submit" class="btn btn-green" form="updateProductForm">Save Product</button>
                </div>
            </div>
        </div>
    </div>

    
    <div class="modal fade" id="deleteProductModal" tabindex="-1" aria-labelledby="deleteProductModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content">
                <div class="modal-header">
                    <h2 class="modal-title fs-5" id="deleteProductModalLabel">
                        <i class="fa-solid fa-trash"></i>
                        Delete Product
                    </h2>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>

                <form id="deleteProductForm" action="#" method="post">
                    <div class="modal-body">
                        <input type="hidden" name="prodID" value="">
                        <p class="mb-0">Are you sure you want to delete this product?</p>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-outline-secondary" data-bs-dismiss="modal">Cancel</button>
                        <button type="submit" class="btn btn-delete">Delete</button>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

    <script>
        function toggleProductType() {
            const type = document.getElementById('addProductType').value;
            const plantSection = document.getElementById('plantSection');
            const toolSection = document.getElementById('toolSection');
            
            // Toggle visibility
            if (type === 'Plant') {
                plantSection.style.display = 'block';
                toolSection.style.display = 'none';
                
                // Set required fields dynamically
                document.getElementById('addScientificName').required = true;
                document.getElementById('addMaterial').required = false;
                document.getElementById('addWeight').required = false;
            } else if (type === 'Tool') {
                plantSection.style.display = 'none';
                toolSection.style.display = 'block';
                
                document.getElementById('addScientificName').required = false;
                document.getElementById('addMaterial').required = true;
                document.getElementById('addWeight').required = true;
            } else {
                plantSection.style.display = 'none';
                toolSection.style.display = 'none';
            }
        }
    </script>
</body>
</html>