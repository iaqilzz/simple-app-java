<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>BlOOMCART POS SYSTEM</title>

    
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

        .brand-title {
            font-weight: bold;
            color: white;
            font-size: 1.6rem;
        }

        .main-container {
            margin-top: 20px;
        }

        .cart-section {
        background-color: white;
        border-radius: 15px;
        padding: 20px;
        box-shadow: 0 4px 10px rgba(0,0,0,0.1);

        height: 88vh;
        overflow-y: auto;

        position: sticky;
        top: 20px;
        }

        .product-section {
            background-color: white;
            border-radius: 15px;
            padding: 20px;
            box-shadow: 0 4px 10px rgba(0,0,0,0.1);
        }

        .product-card {
            border: none;
            border-radius: 15px;
            overflow: hidden;
            transition: 0.3s;
            background-color: #f9fff7;
        }

        .product-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 8px 15px rgba(0,0,0,0.15);
        }

        .product-card img {
            height: 180px;
            object-fit: cover;
        }

        .btn-green {
            background-color: #2e7d32;
            color: white;
        }

        .btn-green:hover {
            background-color: #1b5e20;
            color: white;
        }

        .soil-bg {
            background-color: #8d6e63;
            color: white;
        }

        .cart-item {
            border-bottom: 1px solid #ddd;
            padding-bottom: 10px;
            margin-bottom: 10px;
        }

        .total-box {
            background-color: #e8f5e9;
            border-radius: 10px;
            padding: 15px;
            margin-top: 20px;
        }

        .payment-box {
            background-color: #f1f8e9;
            border-radius: 10px;
            padding: 15px;
            margin-top: 15px;
        }

        .receipt-box {
            background-color: #ffffff;
            border: 2px dashed #4caf50;
            border-radius: 10px;
            padding: 20px;
            margin-top: 20px;
            display: none;
        }

        .badge-stock {
            background-color: #6d4c41;
        }

        .qr-img {
            width: 180px;
            display: block;
            margin: auto;
        }

        .search-box {
            border-radius: 30px;
            padding: 10px 20px;
            border: 2px solid #4caf50;
        }
        
@media print {
    
    body * {
        visibility: hidden;
    }

    
    #receiptBox, #receiptBox * {
        visibility: visible;
    }

    
    #receiptBox {
        position: absolute;
        left: 0;
        top: 0;
        width: 100%;
        border: none; 
        box-shadow: none;
    }

    
    #receiptBox button, .fa-print, .fa-arrow-left {
        display: none !important;
    }
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

    
    <div class="container-fluid main-container">
        <div class="row g-4">

            
            <div class="col-lg-4 order-lg-2">
                <div class="cart-section" id="cartSection">

                    <h3 class="mb-3 text-success text-center">
                        <i class="fa-solid fa-cart-shopping"></i>
                        Shopping Cart
                    </h3>

                    <div id="cartItems" class="text-center">
                        <p class="text-muted">No items added.</p>
                    </div>

                    <div class="total-box">
                        <div class="mb-3">
                            <label class="form-label fw-bold text-success">
                                Customer Phone Number
                            </label>

                            <div class="d-flex gap-2">
                                <input type="text" id="customerPhone" class="form-control" placeholder="Enter customer phone">

                                <button class="btn btn-success" onclick="validateCustomer()">
                                    Validate
                                </button>
                            </div>

                            <small id="phoneStatus" class="text-danger"></small>
                        </div>

                        <h4>Total Amount</h4>
                        <h2 class="text-success">RM <span id="totalAmount">0.00</span></h2>
                    </div>

                    
                    <div class="payment-box">
                        <h5 class="mb-3">Payment Method</h5>

                        <div class="d-grid gap-2">
                            <button class="btn btn-green" onclick="showCashPayment()">
                                Cash
                            </button>

                            <button class="btn soil-bg" onclick="showQRPayment()">
                                E-Wallet QR
                            </button>
                        </div>

                        <div id="cashSection" class="mt-3" style="display:none;">
                            <input type="number" id="cashInput" class="form-control" placeholder="Enter payment amount">
                            <button class="btn btn-success mt-3 w-100" onclick="processCashPayment()">
                                Create Payment
                            </button>
                        </div>

                        <div id="qrSection" class="mt-3 text-center" style="display:none;">
                            <img src="https://api.qrserver.com/v1/create-qr-code/?size=200x200&data=BloomCartPayment" class="qr-img">
                            <button class="btn btn-success w-100" onclick="processQRPayment()">
                                Payment Received
                            </button>
                        </div>
                    </div>

                    
                   

                </div>
                 <div class="receipt-box" id="receiptBox">
                        <h4 class="text-center text-success">RECEIPT</h4>
                        <hr>

                        <p><strong>Date:</strong> <span id="receiptDate"></span></p>
                        <p><strong>Sale ID:</strong> <span id="receiptSaleId"></span></p>
                        <p><strong>Staff ID:</strong> <span id="receiptStaffId"></span></p>

                        <div id="receiptItems"></div>

                        <hr>
                        <h5>Total: RM <span id="receiptTotal"></span></h5>

                        <p><strong>Payment Method:</strong> <span id="receiptMethod"></span></p>
                        <p><strong>Customer Paid:</strong> RM <span id="receiptPaid"></span></p>
                        <p><strong>Balance:</strong> RM <span id="receiptBalance"></span></p>

                        <button class="btn btn-outline-success w-100" onclick="window.print()">Print</button>
                        <button class="btn btn-secondary w-100" onclick="backToCart()">Back</button>
                    </div>
            </div>

            
            <div class="col-lg-8 order-lg-1">
                <div class="product-section">

                    <div class="d-flex gap-2 mb-3">
                    <input type="text" id="searchInput" class="form-control"
                    placeholder="Search product..." onkeyup="filterAndSearch()">

                    <select class="form-select" id="categoryFilter"
                    onchange="filterAndSearch()">
                    <option value="all">All</option>
                    <option value="plant">Plant</option>
                    <option value="tool">Tool</option>
                </select>
            </div>

                    <div class="table-responsive">
                        <table class="table table-bordered text-center">
                            <thead class="table-success">
                                <tr>
                                    <th>No</th>
                                    <th>Product ID</th>
                                    <th>Product Name</th>
                                    <th>Category</th>
                                    <th>Price</th>
                                    <th>Action</th>
                                </tr>
                            </thead>

                            <tbody id="productTable">
                                <tr id="noProductMsg">
                                    <td colspan="6" class="text-center py-5 text-muted">
                                        <i class="fa-solid fa-box-open fa-2x mb-2 d-block"></i>
                                        No products available.
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                        </div>
                    </div>
                </div>
            </div>

        </div>

<script>

/* ============================================================
   CART MANAGEMENT
   ============================================================ */

let cart = [];
let total = 0;

function addToCart(productName, price) {
    let existingItem = cart.find(item => item.name === productName);

    if (existingItem) {
        existingItem.quantity++;
    } else {
        cart.push({
            name: productName,
            price: price,
            quantity: 1
        });
    }

    updateCart();
}

function updateCart() {
    const cartItems = document.getElementById('cartItems');
    const totalAmount = document.getElementById('totalAmount');

    cartItems.innerHTML = '';

    if (cart.length === 0) {
        cartItems.innerHTML = `<p class="text-muted">No items added.</p>`;
    }

    let newTotal = 0;

    cart.forEach((item, index) => {
        newTotal += item.price * item.quantity;

        cartItems.innerHTML += `
        <div class="cart-item">
            <div class="d-flex justify-content-between">
                <div>
                    <h6 class="mb-1">\${item.name}</h6>
                    <small class="text-success">RM \${item.price.toFixed(2)}</small>
                </div>
                <div class="d-flex align-items-center gap-2">
                    <button class="btn btn-sm btn-outline-danger" onclick="decreaseQty(\${index})">-</button>
                    <span>\${item.quantity}</span>
                    <button class="btn btn-sm btn-outline-success" onclick="increaseQty(\${index})">+</button>
                    <button class="btn btn-sm btn-danger" onclick="removeItem(\${index})">x</button>
                </div>
            </div>
        </div>
        `;
    });

    total = newTotal;
    totalAmount.innerText = total.toFixed(2);
}

function removeItem(index) {
    cart.splice(index, 1);
    updateCart();
}

function increaseQty(index) {
    cart[index].quantity++;
    updateCart();
}

function decreaseQty(index) {
    cart[index].quantity--;
    if (cart[index].quantity <= 0) {
        cart.splice(index, 1);
    }
    updateCart();
}

/* ============================================================
   SEARCH & FILTER
   ============================================================ */

function filterAndSearch() {
    let search = document.getElementById('searchInput').value.toLowerCase();
    let selected = document.getElementById('categoryFilter').value;
    let rows = document.querySelectorAll('#productTable tr');

    rows.forEach(row => {
        let text = row.innerText.toLowerCase();
        let category = row.getAttribute('data-category');

        let matchSearch = text.includes(search);
        let matchCategory = (selected === 'all' || category === selected);

        row.style.display = (matchSearch && matchCategory) ? '' : 'none';
    });
}

/* ============================================================
   PAYMENT - SHOW/HIDE SECTIONS
   ============================================================ */

function showCashPayment() {
    document.getElementById('cashSection').style.display = 'block';
    document.getElementById('qrSection').style.display = 'none';
}

function showQRPayment() {
    document.getElementById('cashSection').style.display = 'none';
    document.getElementById('qrSection').style.display = 'block';
}

/* ============================================================
   CUSTOMER VALIDATION
   TODO: Replace with AJAX call to CustomerServlet to check DB
   ============================================================ */

function validateCustomer() {
    let phone = document.getElementById('customerPhone').value.trim();
    const phoneStatus = document.getElementById('phoneStatus');

    if (phone === '') {
        phoneStatus.innerText = 'Enter phone number';
        phoneStatus.className = 'text-danger';
        return false;
    }

    // TODO: Validate against database via servlet/AJAX
    phoneStatus.innerText = 'Customer validated';
    phoneStatus.className = 'text-success';
    return true;
}

/* ============================================================
   PROCESS PAYMENT
   ============================================================ */

function processCashPayment() {
    let valid = validateCustomer();
    if (!valid) return;

    let cash = parseFloat(document.getElementById('cashInput').value);

    if (cart.length === 0) return alert("Cart is empty!");
    if (!cash || cash < total) return alert("Insufficient cash amount!");

    generateReceipt("Cash", cash, cash - total);
}

function processQRPayment() {
    let valid = validateCustomer();
    if (!valid) return;

    if (cart.length === 0) return alert("Cart is empty!");

    generateReceipt("E-Wallet QR", total, 0);
}

/* ============================================================
   RECEIPT GENERATION
   ============================================================ */

function generateReceipt(method, paid, balance) {
    let receiptItems = document.getElementById('receiptItems');
    receiptItems.innerHTML = '';

    cart.forEach(item => {
        receiptItems.innerHTML += `
        <div class="d-flex justify-content-between">
            <span>\${item.name} x\${item.quantity}</span>
            <span>RM \${(item.price * item.quantity).toFixed(2)}</span>
        </div>`;
    });

    // TODO: Get Sale ID from server (servlet response)
    document.getElementById('receiptSaleId').innerText = "—";

    // TODO: Get Staff ID from session (server-side)
    document.getElementById('receiptStaffId').innerText = "—";

    document.getElementById('receiptTotal').innerText = total.toFixed(2);
    document.getElementById('receiptMethod').innerText = method;
    document.getElementById('receiptPaid').innerText = paid.toFixed(2);
    document.getElementById('receiptBalance').innerText = balance.toFixed(2);
    document.getElementById('receiptDate').innerText = new Date().toLocaleString();

    // Switch UI: hide cart, show receipt
    document.getElementById('cartSection').style.display = 'none';
    document.getElementById('receiptBox').style.display = 'block';
}

/* ============================================================
   BACK TO CART (after receipt)
   ============================================================ */

function backToCart() {
    document.getElementById('receiptBox').style.display = 'none';
    document.getElementById('cartSection').style.display = 'block';

    cart = [];
    updateCart();
}

</script>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>
