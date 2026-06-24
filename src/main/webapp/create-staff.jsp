<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="true" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Staff | BLOOMCART POS</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css">
    <link rel="stylesheet" href="style.css">
    <style>
        /* ── STAFF PAGE SPECIFIC ─────────────────── */
        /* Avatar circle with initials */
        .staff-avatar {
            width: 38px; height: 38px; border-radius: 50%;
            background: linear-gradient(135deg, #1B4332, #2D6A4F);
            display: flex; align-items: center; justify-content: center;
            color: white; font-size: .78rem; font-weight: 800;
            flex-shrink: 0; letter-spacing: -.5px;
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
            <span class="cur">Staff</span>
        </div>

        <div class="page-header">
            <div>
                <h2 class="page-title"><i class="fa-solid fa-user-tie"></i> Staff</h2>
                <p class="page-sub">Manage staff accounts and login credentials</p>
            </div>
            <button class="btn-green" type="button" data-bs-toggle="modal" data-bs-target="#addStaffModal">
                <i class="fa-solid fa-user-plus"></i> Add Staff
            </button>
        </div>

        <div class="search-panel mb-3">
            <div class="row g-3 align-items-end">
                <div class="col-lg-9">
                    <label for="staffSearchInput" class="form-label">Search Staff</label>
                    <input type="text" class="search-box" id="staffSearchInput" placeholder="Search by username or staff name...">
                </div>
                <div class="col-lg-3">
                    <button class="btn-green w-100" type="button" id="staffSearchButton">
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
                            <th>Username</th>
                            <th>Staff Name</th>
                            <th>Role</th>
                            <th>Action</th>
                        </tr>
                    </thead>
                    <tbody id="staffTableBody">
                        <tr class="no-records-row" id="staffNoRecords">
                            <td colspan="6" class="text-center py-5 text-muted">
                                <i class="fa-solid fa-user-tie fa-2x mb-3 d-block" style="opacity:.35;"></i>
                                No staff records found.
                            </td>
                        </tr>
                    </tbody>
                </table>
            </div>

            <div class="tbl-footer">
                <span class="pag-info" id="staffPaginationInfo">Showing staff records</span>
                <nav aria-label="Staff pagination">
                    <ul class="pagination mb-0" id="staffPagination">
                        <li class="page-item disabled"><a class="page-link" href="#" aria-label="Previous">&laquo;</a></li>
                        <li class="page-item active" aria-current="page"><a class="page-link" href="#">1</a></li>
                        <li class="page-item disabled"><a class="page-link" href="#" aria-label="Next">&raquo;</a></li>
                    </ul>
                </nav>
            </div>
        </div>
    </div>
</div>

<!-- ADD STAFF MODAL -->
<div class="modal fade" id="addStaffModal" tabindex="-1" aria-labelledby="addStaffModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
            <div class="modal-header">
                <h2 class="modal-title" id="addStaffModalLabel"><i class="fa-solid fa-user-plus me-2"></i> Add Staff</h2>
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
                        <input type="text" class="form-control" id="staffName" placeholder="Enter full name" required>
                    </div>
                    <div>
                        <label for="staffPassword" class="form-label">Password</label>
                        <input type="password" class="form-control" id="staffPassword" placeholder="Enter password" required>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-outline-secondary" data-bs-dismiss="modal">Cancel</button>
                <button type="submit" class="btn-green" form="addStaffForm"><i class="fa-solid fa-floppy-disk"></i> Save Staff</button>
            </div>
        </div>
    </div>
</div>

<!-- UPDATE STAFF MODAL -->
<div class="modal fade" id="updateStaffModal" tabindex="-1" aria-labelledby="updateStaffModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
            <div class="modal-header">
                <h2 class="modal-title" id="updateStaffModalLabel"><i class="fa-solid fa-user-pen me-2"></i> Update Staff</h2>
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
                        <input type="text" class="form-control" id="updateStaffName" placeholder="Enter full name" required>
                    </div>
                    <div>
                        <label for="updateStaffPassword" class="form-label">Password</label>
                        <input type="password" class="form-control" id="updateStaffPassword" placeholder="Enter new password" required>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-outline-secondary" data-bs-dismiss="modal">Cancel</button>
                <button type="submit" class="btn-green" form="updateStaffForm"><i class="fa-solid fa-floppy-disk"></i> Update Staff</button>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
