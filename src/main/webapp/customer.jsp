<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="true" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Customer | BLOOMCART POS</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css">
    <link rel="stylesheet" href="style.css">
    <style>
        /* ── CUSTOMER PAGE SPECIFIC ──────────────── */
        /* Circular avatar shown in table */
        .cust-avatar {
            width: 38px; height: 38px; border-radius: 50%;
            background: linear-gradient(135deg, #2D6A4F, #52B788);
            display: flex; align-items: center; justify-content: center;
            color: white; font-size: .9rem; font-weight: 700; flex-shrink: 0;
        }
    </style>
</head>
<body>

<jsp:include page="navbar.jsp" />

<div class="container-fluid main-wrap">
    <div class="page-section">
        <div class="breadcrumb-row">
            <i class="fa-solid fa-house" style="font-size:.7rem;"></i>
            <span>/</span>
            <span class="cur">Customer</span>
        </div>

        <div class="page-header">
            <div>
                <h2 class="page-title"><i class="fa-solid fa-users"></i> Customer</h2>
                <p class="page-sub">Manage customer records and contact information</p>
            </div>
            <button class="btn-green" type="button" data-bs-toggle="modal" data-bs-target="#addCustomerModal">
                <i class="fa-solid fa-user-plus"></i> Add Customer
            </button>
        </div>

        <div class="search-panel mb-3">
            <div class="row g-3 align-items-end">
                <div class="col-lg-9">
                    <label for="customerSearchInput" class="form-label">Search Customer</label>
                    <input type="text" class="search-box" id="customerSearchInput" placeholder="Search by customer phone or name...">
                </div>
                <div class="col-lg-3">
                    <button class="btn-green w-100" type="button" id="customerSearchButton">
                        <i class="fa-solid fa-magnifying-glass"></i> Search
                    </button>
                </div>
            </div>
        </div>

        <div class="card content-card">
            <div class="table-responsive">
                <table class="table table-hover align-middle">
                    <thead>
                        <tr>
                            <th style="width:46px;"></th>
                            <th>No.</th>
                            <th>Customer Name</th>
                            <th>Customer Phone</th>
                            <th>Action</th>
                        </tr>
                    </thead>
                    <tbody id="customerTableBody">
                        <tr id="customerNoRecords">
                            <td colspan="5" class="text-center py-5 text-muted">
                                <i class="fa-solid fa-users fa-2x mb-3 d-block" style="opacity:.35;"></i>
                                No customer records found.
                            </td>
                        </tr>
                    </tbody>
                </table>
            </div>

            <div class="tbl-footer">
                <span class="pag-info" id="customerPaginationInfo">Showing customer records</span>
                <nav aria-label="Customer pagination">
                    <ul class="pagination mb-0" id="customerPagination">
                        <li class="page-item disabled"><a class="page-link" href="#" aria-label="Previous">&laquo;</a></li>
                        <li class="page-item active" aria-current="page"><a class="page-link" href="#">1</a></li>
                        <li class="page-item"><a class="page-link" href="#">2</a></li>
                        <li class="page-item"><a class="page-link" href="#" aria-label="Next">&raquo;</a></li>
                    </ul>
                </nav>
            </div>
        </div>
    </div>
</div>

<!-- ADD CUSTOMER MODAL -->
<div class="modal fade" id="addCustomerModal" tabindex="-1" aria-labelledby="addCustomerModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
            <div class="modal-header">
                <h2 class="modal-title" id="addCustomerModalLabel"><i class="fa-solid fa-user-plus me-2"></i> Add Customer</h2>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <form id="addCustomerForm">
                    <div class="mb-3">
                        <label for="addCustomerName" class="form-label">Customer Name</label>
                        <input type="text" class="form-control" id="addCustomerName" placeholder="Enter customer name">
                    </div>
                    <div>
                        <label for="addCustomerPhone" class="form-label">Customer Phone</label>
                        <input type="text" class="form-control" id="addCustomerPhone" placeholder="e.g. 0123456789">
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-outline-secondary" data-bs-dismiss="modal">Cancel</button>
                <button type="submit" class="btn-green" form="addCustomerForm"><i class="fa-solid fa-floppy-disk"></i> Save Customer</button>
            </div>
        </div>
    </div>
</div>

<!-- UPDATE CUSTOMER MODAL -->
<div class="modal fade" id="updateCustomerModal" tabindex="-1" aria-labelledby="updateCustomerModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
            <div class="modal-header">
                <h2 class="modal-title" id="updateCustomerModalLabel"><i class="fa-solid fa-pen-to-square me-2"></i> Update Customer</h2>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <form id="updateCustomerForm" action="#" method="post">
                    <div class="mb-3">
                        <label for="updateCustomerPhone" class="form-label">Customer Phone</label>
                        <input type="text" class="form-control" id="updateCustomerPhone" value="">
                    </div>
                    <div>
                        <label for="updateCustomerName" class="form-label">Customer Name</label>
                        <input type="text" class="form-control" id="updateCustomerName" value="">
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-outline-secondary" data-bs-dismiss="modal">Cancel</button>
                <button type="submit" class="btn-green" form="updateCustomerForm"><i class="fa-solid fa-floppy-disk"></i> Save Changes</button>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
