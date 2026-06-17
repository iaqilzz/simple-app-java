<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Staff | BLOOMCART POS SYSTEM</title>

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

        .form-label {
            font-weight: bold;
            color: #2e7d32;
        }

        .form-control {
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
        <div class="page-section">
            <div class="d-flex flex-column flex-lg-row align-items-lg-center justify-content-between gap-3 mb-4">
                <div>
                    <h2 class="page-title mb-2">
                        <i class="fa-solid fa-user-tie"></i>
                        Staff
                    </h2>
                    <p class="page-subtitle mb-0">Manage staff login records</p>
                </div>

                <button class="btn btn-green" type="button" data-bs-toggle="modal" data-bs-target="#addStaffModal">
                    <i class="fa-solid fa-user-plus"></i>
                    Add Staff
                </button>
            </div>

            <div class="search-panel mb-4">
                <div class="row g-3 align-items-end">
                    <div class="col-lg-9">
                        <label for="staffSearchInput" class="form-label">Search Staff</label>
                        <input type="text" class="form-control search-box" id="staffSearchInput" placeholder="Search by username or staff name">
                    </div>
                    <div class="col-lg-3">
                        <button class="btn btn-green w-100" type="button" id="staffSearchButton">
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
                                <th>Username</th>
                                <th>Staff Name</th>
                                <th>Action</th>
                            </tr>
                        </thead>
                        <tbody id="staffTableBody">
                            <tr class="no-records-row" id="staffNoRecords">
                                <td colspan="4" class="text-center py-5 text-muted">
                                    <i class="fa-solid fa-user-tie fa-2x mb-2 d-block"></i>
                                    No staff records found.
                                </td>
                            </tr>
                        </tbody>
                    </table>
                </div>

                <div class="table-footer d-flex flex-column flex-md-row align-items-center justify-content-between gap-3 p-3">
                    <span class="small text-muted" id="staffPaginationInfo">Showing staff records</span>
                    <nav aria-label="Staff table pagination">
                        <ul class="pagination mb-0" id="staffPagination">
                            <li class="page-item disabled">
                                <a class="page-link" href="#" aria-label="Previous page">&laquo;</a>
                            </li>
                            <li class="page-item active" aria-current="page">
                                <a class="page-link" href="#">1</a>
                            </li>
                            <li class="page-item disabled">
                                <a class="page-link" href="#" aria-label="Next page">&raquo;</a>
                            </li>
                        </ul>
                    </nav>
                </div>
            </div>
        </div>
    </div>

    <!-- Add Staff Modal -->
    <div class="modal fade" id="addStaffModal" tabindex="-1" aria-labelledby="addStaffModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content">
                <div class="modal-header">
                    <h2 class="modal-title fs-5" id="addStaffModalLabel">
                        <i class="fa-solid fa-user-plus"></i>
                        Add Staff
                    </h2>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>

                <div class="modal-body">
                    <form id="addStaffForm" action="#" method="post">
                        <div class="mb-3">
                            <label for="staffUsername" class="form-label">Username</label>
                            <input type="text" class="form-control" id="staffUsername" placeholder="Enter username" required>
                        </div>

                        <div class="mb-3">
                            <label for="staffName" class="form-label">Staff Name</label>
                            <input type="text" class="form-control" id="staffName" placeholder="Enter staff name" required>
                        </div>

                        <div>
                            <label for="staffPassword" class="form-label">Password</label>
                            <input type="password" class="form-control" id="staffPassword" placeholder="Enter password" required>
                        </div>
                    </form>
                </div>

                <div class="modal-footer">
                    <button type="button" class="btn btn-outline-secondary" data-bs-dismiss="modal">Cancel</button>
                    <button type="submit" class="btn btn-green" form="addStaffForm">
                        Save Staff
                    </button>
                </div>
            </div>
        </div>
    </div>

    <!-- Update Staff Modal -->
    <div class="modal fade" id="updateStaffModal" tabindex="-1" aria-labelledby="updateStaffModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content">
                <div class="modal-header">
                    <h2 class="modal-title fs-5" id="updateStaffModalLabel">
                        <i class="fa-solid fa-user-pen"></i>
                        Update Staff
                    </h2>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>

                <div class="modal-body">
                    <form id="updateStaffForm" action="#" method="post">
                        <input type="hidden" id="updateStaffIndex">

                        <div class="mb-3">
                            <label for="updateStaffUsername" class="form-label">Username</label>
                            <input type="text" class="form-control" id="updateStaffUsername" placeholder="Enter username" required>
                        </div>

                        <div class="mb-3">
                            <label for="updateStaffName" class="form-label">Staff Name</label>
                            <input type="text" class="form-control" id="updateStaffName" placeholder="Enter staff name" required>
                        </div>

                        <div>
                            <label for="updateStaffPassword" class="form-label">Password</label>
                            <input type="password" class="form-control" id="updateStaffPassword" placeholder="Enter password" required>
                        </div>
                    </form>
                </div>

                <div class="modal-footer">
                    <button type="button" class="btn btn-outline-secondary" data-bs-dismiss="modal">Cancel</button>
                    <button type="submit" class="btn btn-green" form="updateStaffForm">
                        Update Staff
                    </button>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>