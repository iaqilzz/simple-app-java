<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="true" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Product | BLOOMCART POS</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css">
    <link rel="stylesheet" href="style.css">
    <style>
        /* ── PRODUCT PAGE SPECIFIC ───────────────── */
        /* product thumbnail (in table) */
        .prod-thumb {
            width: 42px; height: 42px; border-radius: 10px;
            display: flex; align-items: center; justify-content: center;
            font-size: 1.1rem; color: white; flex-shrink: 0;
        }
        /* delete modal header override */
        #deleteProductModal .modal-header { background: linear-gradient(135deg,#991B1B,#DC2626); }
    </style>
</head>
<body>

<jsp:include page="navbar.jsp" />

<div class="container-fluid main-wrap">

    <!-- Status Alerts -->
    <%
        String status = request.getParameter("status");
        String message = request.getParameter("message");
        if ("success".equals(status)) {
    %>
        <div class="alert alert-success alert-dismissible fade show mb-3" role="alert" style="border-radius:12px; font-family:'Inter',sans-serif; font-size:.875rem;">
            <i class="fa-solid fa-circle-check me-2"></i><strong>Success!</strong> Product added successfully.
            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
        </div>
    <% } else if ("error".equals(status)) { %>
        <div class="alert alert-danger alert-dismissible fade show mb-3" role="alert" style="border-radius:12px; font-family:'Inter',sans-serif; font-size:.875rem;">
            <i class="fa-solid fa-triangle-exclamation me-2"></i><strong>Error!</strong> <%= message != null ? message : "Failed to add product." %>
            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
        </div>
    <% } %>

    <div class="page-section">
        <div class="breadcrumb-row">
            <i class="fa-solid fa-house" style="font-size:.7rem;"></i>
            <span>/</span>
            <span class="cur">Product</span>
        </div>

        <div class="page-header">
            <div>
                <h2 class="page-title"><i class="fa-solid fa-seedling"></i> Product</h2>
                <p class="page-sub">Manage product records based on category and product type</p>
            </div>
            <button class="btn-green" type="button" data-bs-toggle="modal" data-bs-target="#addProductModal">
                <i class="fa-solid fa-plus"></i> Add Product
            </button>
        </div>

        <!-- Search Panel -->
        <div class="search-panel mb-3">
            <div class="row g-3 align-items-end">
                <div class="col-lg-9">
                    <label for="productSearchInput" class="form-label">Search Product</label>
                    <input type="text" class="search-box" id="productSearchInput"
                           placeholder="Search by ID, name, category, price or details...">
                </div>
                <div class="col-lg-3">
                    <button class="btn-green w-100" type="button" id="productSearchButton">
                        <i class="fa-solid fa-magnifying-glass"></i> Search
                    </button>
                </div>
            </div>
        </div>

        <!-- Table Card -->
        <div class="card content-card">
            <div class="table-responsive">
                <table class="table table-hover align-middle">
                    <thead>
                        <tr>
                            <th style="width:46px;"></th>
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
                            <td colspan="8" class="text-center py-5 text-muted">
                                <i class="fa-solid fa-seedling fa-2x mb-3 d-block" style="opacity:.35;"></i>
                                No product records found.
                            </td>
                        </tr>
                    </tbody>
                </table>
            </div>

            <div class="tbl-footer">
                <span class="pag-info" id="productPaginationInfo">Showing product records</span>
                <nav aria-label="Product pagination">
                    <ul class="pagination mb-0" id="productPagination">
                        <li class="page-item disabled">
                            <a class="page-link" href="#" aria-label="Previous">&laquo;</a>
                        </li>
                        <li class="page-item active" aria-current="page">
                            <a class="page-link" href="#">1</a>
                        </li>
                        <li class="page-item">
                            <a class="page-link" href="#">2</a>
                        </li>
                        <li class="page-item">
                            <a class="page-link" href="#" aria-label="Next">&raquo;</a>
                        </li>
                    </ul>
                </nav>
            </div>
        </div>
    </div>
</div>

<!-- ADD PRODUCT MODAL -->
<div class="modal fade" id="addProductModal" tabindex="-1" aria-labelledby="addProductModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-lg modal-dialog-centered modal-dialog-scrollable">
        <div class="modal-content">
            <div class="modal-header">
                <h2 class="modal-title" id="addProductModalLabel">
                    <i class="fa-solid fa-plus me-2"></i> Add Product
                </h2>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <form id="addProductForm" action="AddProductServlet" method="POST" enctype="multipart/form-data">
                    <input type="hidden" name="prodID" id="prodID" value="">
                    <div class="row g-3">
                        <div class="col-md-12">
                            <label for="addProductName" class="form-label">Product Name</label>
                            <input type="text" class="form-control" id="addProductName" name="productName" placeholder="Enter product name" required>
                        </div>
                        <div class="col-md-4">
                            <label for="addProductPrice" class="form-label">Price (RM)</label>
                            <input type="number" step="0.01" class="form-control" id="addProductPrice" name="productPrice" placeholder="0.00" required>
                        </div>
                        <div class="col-md-4">
                            <label for="addProductCategory" class="form-label">Category Name</label>
                            <input type="text" class="form-control" id="addProductCategory" name="productCategory" placeholder="e.g. Indoor Plant" required>
                        </div>
                        <div class="col-md-4">
                            <label for="addProductType" class="form-label">Product Type</label>
                            <select class="form-select" id="addProductType" name="productType" onchange="toggleProductType()" required>
                                <option value="" selected disabled>Select type</option>
                                <option value="Plant">Plant</option>
                                <option value="Tool">Tool</option>
                            </select>
                        </div>
                    </div>
                    
                    <div class="row g-3 mt-1">
                        <div class="col-12">
                            <label for="productImage" class="form-label">Product Image</label>
                            <input type="file" class="form-control" id="productImage" name="productImage" accept="image/*" required>
                            <div class="form-text" style="font-size: 0.75rem; color: var(--text-muted);">
                                Supported formats: JPG, PNG. You can upload or snap a photo.
                            </div>
                        </div>
                    </div>

                    <div class="mt-4" id="plantSection" style="display:none;">
                        <div class="section-label mb-3"><i class="fa-solid fa-seedling me-2" style="color:#52B788;"></i>Plant Details</div>
                        <div class="row g-3">
                            <div class="col-md-6">
                                <label for="addScientificName" class="form-label">Scientific Name</label>
                                <input type="text" class="form-control" id="addScientificName" name="scientificName" placeholder="Enter scientific name">
                            </div>
                            <div class="col-md-6">
                                <label for="addSunlightReq" class="form-label">Sunlight Requirement (1–10)</label>
                                <input type="number" class="form-control" id="addSunlightReq" name="sunlightReq" min="1" max="10" placeholder="1–10 scale">
                            </div>
                        </div>
                    </div>

                    <div class="mt-4" id="toolSection" style="display:none;">
                        <div class="section-label mb-3"><i class="fa-solid fa-screwdriver-wrench me-2" style="color:#B45309;"></i>Tool Details</div>
                        <div class="row g-3">
                            <div class="col-md-6">
                                <label for="addMaterial" class="form-label">Material</label>
                                <input type="text" class="form-control" id="addMaterial" name="material" placeholder="Enter material">
                            </div>
                            <div class="col-md-6">
                                <label for="addWeight" class="form-label">Weight (kg)</label>
                                <input type="number" step="0.01" class="form-control" id="addWeight" name="weight" placeholder="e.g. 0.50">
                            </div>
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-outline-secondary" data-bs-dismiss="modal">Cancel</button>
                <button type="submit" class="btn-green" form="addProductForm">
                    <i class="fa-solid fa-floppy-disk"></i> Save Product
                </button>
            </div>
        </div>
    </div>
</div>

<!-- UPDATE PRODUCT MODAL -->
<div class="modal fade" id="updateProductModal" tabindex="-1" aria-labelledby="updateProductModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-lg modal-dialog-centered modal-dialog-scrollable">
        <div class="modal-content">
            <div class="modal-header">
                <h2 class="modal-title" id="updateProductModalLabel">
                    <i class="fa-solid fa-pen-to-square me-2"></i> Update Product
                </h2>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <form id="updateProductForm" action="#" method="post">
                    <div class="row g-3">
                        <div class="col-md-6">
                            <label for="updateProductId" class="form-label">Product ID</label>
                            <input type="text" class="form-control" id="updateProductId" readonly style="background:#F8F8F8;">
                        </div>
                        <div class="col-md-6">
                            <label for="updateProductName" class="form-label">Product Name</label>
                            <input type="text" class="form-control" id="updateProductName">
                        </div>
                        <div class="col-md-6">
                            <label for="updateProductPrice" class="form-label">Price (RM)</label>
                            <input type="text" class="form-control" id="updateProductPrice">
                        </div>
                        <div class="col-md-6">
                            <label for="updateProductCategory" class="form-label">Category</label>
                            <select class="form-select" id="updateProductCategory">
                                <option value="C001">C001 &mdash; Plant</option>
                                <option value="C002">C002 &mdash; Tool</option>
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
                        <div class="section-label mb-3"><i class="fa-solid fa-seedling me-2" style="color:#52B788;"></i>Plant Details</div>
                        <div class="row g-3">
                            <div class="col-md-6">
                                <label for="updateScientificName" class="form-label">Scientific Name</label>
                                <input type="text" class="form-control" id="updateScientificName">
                            </div>
                            <div class="col-md-6">
                                <label for="updateSunlightReq" class="form-label">Sunlight Requirement</label>
                                <input type="number" class="form-control" id="updateSunlightReq" min="1" max="10" placeholder="1–10">
                            </div>
                        </div>
                    </div>
                    <div class="mt-4">
                        <div class="section-label mb-3"><i class="fa-solid fa-screwdriver-wrench me-2" style="color:#B45309;"></i>Tool Details</div>
                        <div class="row g-3">
                            <div class="col-md-6">
                                <label for="updateMaterial" class="form-label">Material</label>
                                <input type="text" class="form-control" id="updateMaterial">
                            </div>
                            <div class="col-md-6">
                                <label for="updateWeight" class="form-label">Weight (kg)</label>
                                <input type="text" class="form-control" id="updateWeight">
                            </div>
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-outline-secondary" data-bs-dismiss="modal">Cancel</button>
                <button type="submit" class="btn-green" form="updateProductForm">
                    <i class="fa-solid fa-floppy-disk"></i> Save Changes
                </button>
            </div>
        </div>
    </div>
</div>

<!-- DELETE PRODUCT MODAL -->
<div class="modal fade" id="deleteProductModal" tabindex="-1" aria-labelledby="deleteProductModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
            <div class="modal-header" style="background: linear-gradient(135deg,#991B1B,#DC2626);">
                <h2 class="modal-title" id="deleteProductModalLabel">
                    <i class="fa-solid fa-trash me-2"></i> Delete Product
                </h2>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <form id="deleteProductForm" action="#" method="post">
                <div class="modal-body">
                    <input type="hidden" name="prodID" value="">
                    <p class="mb-0" style="font-size:.9rem;">Are you sure you want to delete this product? This action cannot be undone.</p>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-outline-secondary" data-bs-dismiss="modal">Cancel</button>
                    <button type="submit" class="btn-delete"><i class="fa-solid fa-trash"></i> Delete</button>
                </div>
            </form>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script>
    let products = [];
    let filtered = [];
    const ITEMS_PER_PAGE = 5;
    let currentPage = 1;

    // Load products on start
    document.addEventListener('DOMContentLoaded', () => {
        fetchProducts();
    });

    function fetchProducts() {
        fetch('GetProductsServlet')
            .then(res => res.json())
            .then(data => {
                products = data;
                filtered = [...products];
                renderTable();
            })
            .catch(err => console.error("Error fetching products:", err));
    }

    function renderTable() {
        const tbody = document.getElementById('productTableBody');
        const total = filtered.length;
        const totalPages = Math.max(1, Math.ceil(total / ITEMS_PER_PAGE));
        
        if (currentPage > totalPages) currentPage = totalPages;
        
        const start = (currentPage - 1) * ITEMS_PER_PAGE;
        const end = Math.min(start + ITEMS_PER_PAGE, total);
        const pageItems = filtered.slice(start, end);

        if (pageItems.length === 0) {
            tbody.innerHTML = `
                <tr id="productNoRecords">
                    <td colspan="8" class="text-center py-5 text-muted">
                        <i class="fa-solid fa-seedling fa-2x mb-3 d-block" style="opacity:.35;"></i>
                        No product records found.
                    </td>
                </tr>`;
            document.getElementById('productPagination').style.display = 'none';
            document.getElementById('productPaginationInfo').textContent = 'Showing 0 records';
            return;
        }

        document.getElementById('productPagination').style.display = 'flex';
        document.getElementById('productPaginationInfo').textContent = `Showing ${start+1}-${end} of ${total} records`;

        tbody.innerHTML = pageItems.map((p, index) => {
            const isPlant = p.type === 'plant';
            const imgHtml = p.imagePath ? 
                `<img src="${p.imagePath}" class="prod-thumb" style="object-fit:cover;">` : 
                `<div class="prod-thumb" style="background:${isPlant ? '#52B788' : '#D97706'};">
                    <i class="fa-solid ${isPlant ? 'fa-seedling' : 'fa-screwdriver-wrench'}"></i>
                 </div>`;
                 
            const detailsHtml = isPlant ? 
                `<small class="d-block"><span class="text-muted">Sci:</span> ${p.scientificName || '-'}</small>
                 <small class="d-block"><span class="text-muted">Sun:</span> ${p.sunlightReq}/10</small>` :
                `<small class="d-block"><span class="text-muted">Mat:</span> ${p.material || '-'}</small>
                 <small class="d-block"><span class="text-muted">Wt:</span> ${p.weight} kg</small>`;

            return `
            <tr>
                <td>${imgHtml}</td>
                <td class="text-muted">${start + index + 1}.</td>
                <td class="fw-bold text-dark">PID-${p.id}</td>
                <td>
                    <div class="fw-bold">${p.name}</div>
                    <div style="font-size:0.75rem; color:var(--text-muted);">${p.categoryName}</div>
                </td>
                <td>
                    <span class="badge ${isPlant ? 'bg-success bg-opacity-10 text-success' : 'bg-warning bg-opacity-10 text-warning'} border-0" style="padding:6px 10px;">
                        <i class="fa-solid ${isPlant ? 'fa-leaf' : 'fa-wrench'} me-1"></i> ${isPlant ? 'Plant' : 'Tool'}
                    </span>
                </td>
                <td class="fw-bold text-dark">RM ${p.price.toFixed(2)}</td>
                <td>${detailsHtml}</td>
                <td>
                    <button class="btn btn-sm btn-light text-primary me-1" onclick="editProduct('${p.id}')" title="Edit">
                        <i class="fa-solid fa-pen"></i>
                    </button>
                    <button class="btn btn-sm btn-light text-danger" onclick="deleteProduct('${p.id}')" title="Delete">
                        <i class="fa-solid fa-trash"></i>
                    </button>
                </td>
            </tr>`;
        }).join('');

        renderPagination(totalPages);
    }

    function renderPagination(totalPages) {
        const ul = document.getElementById('productPagination');
        let html = `<li class="page-item ${currentPage === 1 ? 'disabled' : ''}">
                        <a class="page-link" href="#" onclick="goPage(${currentPage - 1}); return false;">&laquo;</a>
                    </li>`;
        
        for (let i = 1; i <= totalPages; i++) {
            html += `<li class="page-item ${currentPage === i ? 'active' : ''}">
                        <a class="page-link" href="#" onclick="goPage(${i}); return false;">${i}</a>
                     </li>`;
        }
        
        html += `<li class="page-item ${currentPage === totalPages ? 'disabled' : ''}">
                    <a class="page-link" href="#" onclick="goPage(${currentPage + 1}); return false;">&raquo;</a>
                 </li>`;
        ul.innerHTML = html;
    }

    function goPage(p) {
        const totalPages = Math.ceil(filtered.length / ITEMS_PER_PAGE);
        if (p < 1 || p > totalPages) return;
        currentPage = p;
        renderTable();
    }

    // Search functionality
    document.getElementById('productSearchInput').addEventListener('input', function(e) {
        const q = e.target.value.toLowerCase();
        filtered = products.filter(p => 
            p.name.toLowerCase().includes(q) || 
            p.id.toLowerCase().includes(q) ||
            p.categoryName.toLowerCase().includes(q)
        );
        currentPage = 1;
        renderTable();
    });

    function deleteProduct(id) {
        const form = document.getElementById('deleteProductForm');
        form.action = 'DeleteProductServlet';
        form.querySelector('input[name="prodID"]').value = id;
        new bootstrap.Modal(document.getElementById('deleteProductModal')).show();
    }

    function editProduct(id) {
        const p = products.find(x => x.id === id);
        if (!p) return;

        // Populate form
        document.getElementById('prodID').value = p.id;
        document.getElementById('addProductName').value = p.name;
        document.getElementById('addProductPrice').value = p.price;
        document.getElementById('addProductCategory').value = p.categoryName;
        
        // Select type and toggle section
        const typeSelect = document.getElementById('addProductType');
        if (p.type === 'plant') {
            typeSelect.value = 'Plant';
            document.getElementById('addScientificName').value = p.scientificName;
            document.getElementById('addSunlightReq').value = p.sunlightReq;
        } else if (p.type === 'tool') {
            typeSelect.value = 'Tool';
            document.getElementById('addMaterial').value = p.material;
            document.getElementById('addWeight').value = p.weight;
        }
        
        toggleProductType(); // show correct section
        
        // Image isn't required when updating
        document.getElementById('productImage').removeAttribute('required');
        
        // Update Modal Title
        document.getElementById('addProductModalLabel').innerHTML = '<i class="fa-solid fa-pen me-2"></i> Update Product';

        // Show modal
        new bootstrap.Modal(document.getElementById('addProductModal')).show();
    }

    function toggleProductType() {
        const type = document.getElementById('addProductType').value;
        const ps = document.getElementById('plantSection');
        const ts = document.getElementById('toolSection');
        if(type === 'Plant') {
            ps.style.display = 'block'; ts.style.display = 'none';
        } else if(type === 'Tool') {
            ps.style.display = 'none'; ts.style.display = 'block';
        } else {
            plantSection.style.display = 'none'; toolSection.style.display = 'none';
        }
    }
</script>
</body>
</html>
