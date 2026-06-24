<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="true" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Sale | BLOOMCART POS</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css">
    <link rel="stylesheet" href="style.css">
    <style>
        /* ── PRODUCT PANEL ───────────────────────── */
        .product-panel {
            background: var(--surface);
            border-radius: var(--radius);
            padding: 22px;
            box-shadow: var(--shadow);
            border: 1px solid var(--border);
        }
        .panel-header {
            display: flex; align-items: center;
            justify-content: space-between;
            margin-bottom: 16px;
        }
        .panel-title {
            font-size: 1.05rem; font-weight: 700; color: var(--primary);
            display: flex; align-items: center; gap: 8px;
        }
        .page-chip {
            background: #E8F5E9; color: var(--primary);
            font-size: .74rem; font-weight: 700;
            padding: 4px 11px; border-radius: 20px;
            border: 1px solid #C8E6C9;
        }
        .search-row { display: flex; gap: 10px; margin-bottom: 18px; }
        .search-input {
            flex: 1; border: 2px solid var(--border);
            border-radius: var(--radius-sm);
            padding: 9px 16px;
            font-family: 'Inter', sans-serif; font-size: .875rem;
            outline: none; transition: border-color .2s, box-shadow .2s;
            color: var(--text);
        }
        .search-input:focus {
            border-color: var(--accent);
            box-shadow: 0 0 0 3px rgba(82,183,136,.15);
        }
        .cat-select {
            border: 2px solid var(--border); border-radius: var(--radius-sm);
            padding: 9px 14px;
            font-family: 'Inter', sans-serif; font-size: .875rem;
            outline: none; background: white; cursor: pointer;
            transition: border-color .2s; color: var(--text);
        }
        .cat-select:focus { border-color: var(--accent); }

        /* ── PRODUCT GRID ────────────────────────── */
        .product-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(160px, 1fr));
            gap: 14px;
            min-height: 380px;
        }
        .product-card {
            background: var(--surface);
            border: 1.5px solid var(--border);
            border-radius: var(--radius-sm);
            overflow: hidden;
            transition: transform .25s ease, box-shadow .25s ease, border-color .25s ease;
            display: flex; flex-direction: column;
            cursor: pointer;
        }
        .product-card:hover {
            transform: translateY(-5px);
            box-shadow: var(--shadow-hover);
            border-color: var(--accent);
        }
        .card-img-wrap {
            height: 108px;
            display: flex; align-items: center; justify-content: center;
            position: relative; overflow: hidden;
        }
        .card-img-wrap.plant-bg { background: linear-gradient(135deg, #1B4332 0%, #2D6A4F 50%, #52B788 100%); }
        .card-img-wrap.tool-bg  { background: linear-gradient(135deg, #78350F 0%, #92400E 50%, #B45309 100%); }
        .card-img-wrap i { font-size: 2.1rem; color: rgba(255,255,255,.85); }
        .card-img-wrap i.shimmer { animation: shimmer 2.5s ease-in-out infinite; }
        @keyframes shimmer {
            0%,100% { opacity:.85; transform:scale(1); }
            50%      { opacity:1;   transform:scale(1.06); }
        }
        .stock-pill {
            position: absolute; top: 8px; right: 8px;
            background: rgba(255,255,255,.22);
            backdrop-filter: blur(4px);
            color: white; font-size: .66rem; font-weight: 600;
            padding: 2px 7px; border-radius: 10px;
            border: 1px solid rgba(255,255,255,.3);
        }
        .card-body-inner {
            padding: 12px; flex: 1;
            display: flex; flex-direction: column;
        }
        .card-prod-name {
            font-size: .84rem; font-weight: 600;
            color: var(--text); margin-bottom: 5px; line-height: 1.3;
            display: -webkit-box;
            -webkit-line-clamp: 2;
            -webkit-box-orient: vertical;
            overflow: hidden;
        }
        .cat-chip {
            display: inline-flex; align-items: center; gap: 3px;
            font-size: .66rem; font-weight: 600;
            padding: 2px 8px; border-radius: 6px; margin-bottom: 8px;
        }
        .chip-plant { background: #D1FAE5; color: #065F46; }
        .chip-tool  { background: #FEF3C7; color: #92400E; }
        .card-price {
            font-size: 1rem; font-weight: 800;
            color: var(--primary); margin-top: auto; margin-bottom: 10px;
        }
        .btn-add {
            width: 100%;
            background: linear-gradient(135deg, var(--primary-mid), var(--accent));
            color: white; border: none; border-radius: 8px;
            padding: 8px; font-size: .79rem; font-weight: 600;
            cursor: pointer; font-family: 'Inter', sans-serif;
            display: flex; align-items: center; justify-content: center; gap: 6px;
            transition: opacity .2s, transform .15s;
        }
        .btn-add:hover  { opacity: .9; }
        .btn-add:active { transform: scale(.95); }
        .empty-grid {
            grid-column: 1 / -1;
            text-align: center; padding: 60px 20px;
            color: var(--text-muted);
        }
        .empty-grid i { font-size: 3rem; margin-bottom: 12px; display: block; opacity: .45; }

        /* ── GRID PAGINATION ─────────────────────── */
        .pagination-row {
            display: flex; align-items: center;
            justify-content: space-between;
            margin-top: 18px; flex-wrap: wrap; gap: 10px;
        }
        .pag-info { font-size: .79rem; color: var(--text-muted); font-weight: 500; }
        .pag-controls { display: flex; align-items: center; gap: 4px; }
        .pag-btn {
            width: 34px; height: 34px;
            border: 1.5px solid var(--border); background: white;
            border-radius: 8px; font-size: .79rem; font-weight: 600;
            cursor: pointer; display: flex; align-items: center; justify-content: center;
            transition: all .2s; color: var(--text); font-family: 'Inter', sans-serif;
        }
        .pag-btn:hover:not(:disabled) { border-color: var(--accent); color: var(--primary); background: #F0FFF4; }
        .pag-btn.active { background: var(--primary); color: white; border-color: var(--primary); }
        .pag-btn:disabled { opacity: .38; cursor: not-allowed; }

        /* ── CART PANEL ──────────────────────────── */
        .cart-panel {
            background: var(--surface);
            border-radius: var(--radius);
            padding: 20px;
            box-shadow: var(--shadow);
            border: 1px solid var(--border);
            height: 88vh; overflow-y: auto;
            position: sticky; top: 16px;
            display: flex; flex-direction: column;
            scrollbar-width: thin; scrollbar-color: var(--border) transparent;
        }
        .cart-panel::-webkit-scrollbar { width: 4px; }
        .cart-panel::-webkit-scrollbar-thumb { background: var(--border); border-radius: 4px; }
        .cart-top {
            display: flex; align-items: center; justify-content: space-between;
            padding-bottom: 14px; border-bottom: 2px solid var(--bg);
            margin-bottom: 14px;
        }
        .cart-title {
            font-size: .98rem; font-weight: 700; color: var(--primary);
            display: flex; align-items: center; gap: 8px;
        }
        .cart-count-badge {
            background: var(--primary); color: white;
            border-radius: 50%; width: 22px; height: 22px;
            font-size: .7rem; font-weight: 700;
            display: flex; align-items: center; justify-content: center;
        }
        .cart-body { flex: 1; }
        .cart-empty-msg {
            text-align: center; color: var(--text-muted);
            padding: 30px 10px; font-size: .84rem;
        }
        .cart-empty-msg i { font-size: 2.4rem; display: block; margin-bottom: 8px; opacity: .38; }
        .cart-item-row {
            display: flex; align-items: center; gap: 10px;
            padding: 10px 0; border-bottom: 1px solid var(--bg);
        }
        .item-icon {
            width: 38px; height: 38px; border-radius: 9px;
            display: flex; align-items: center; justify-content: center;
            font-size: .95rem; color: white; flex-shrink: 0;
        }
        .item-icon.plant { background: linear-gradient(135deg, #2D6A4F, #52B788); }
        .item-icon.tool  { background: linear-gradient(135deg, #78350F, #B45309); }
        .item-info { flex: 1; min-width: 0; }
        .item-name  { font-size: .81rem; font-weight: 600; white-space: nowrap; overflow: hidden; text-overflow: ellipsis; }
        .item-unit  { font-size: .73rem; color: var(--primary); font-weight: 500; }
        .item-controls { display: flex; align-items: center; gap: 4px; }
        .qty-btn {
            width: 26px; height: 26px;
            border: 1.5px solid var(--border); background: white;
            border-radius: 6px; font-size: .82rem; font-weight: 700;
            cursor: pointer; display: flex; align-items: center; justify-content: center;
            transition: all .15s; color: var(--text);
        }
        .qty-btn:hover { border-color: var(--accent); background: #F0FFF4; }
        .qty-btn.rmv:hover { border-color: #EF4444; background: #FEF2F2; color: #EF4444; }
        .qty-val { font-size: .82rem; font-weight: 700; min-width: 20px; text-align: center; }

        /* total */
        .total-box {
            background: linear-gradient(135deg, #F0FFF4, #E8F5E9);
            border-radius: var(--radius-sm); padding: 14px;
            margin-top: 12px; border: 1px solid #C8E6C9;
        }
        .total-lbl { font-size: .75rem; color: var(--text-muted); font-weight: 500; margin-bottom: 2px; }
        .total-amt { font-size: 1.7rem; font-weight: 800; color: var(--primary); line-height: 1.1; }
        .total-cur { font-size: .95rem; font-weight: 600; color: var(--primary-mid); }

        /* phone */
        .phone-wrap { margin-top: 12px; }
        .phone-wrap label { font-size: .76rem; font-weight: 600; color: var(--primary); display: block; margin-bottom: 6px; }
        .phone-row { display: flex; gap: 8px; }
        .phone-inp {
            flex: 1; border: 2px solid var(--border); border-radius: 8px;
            padding: 8px 12px; font-family: 'Inter', sans-serif;
            font-size: .84rem; outline: none; transition: border-color .2s;
        }
        .phone-inp:focus { border-color: var(--accent); }
        .btn-check {
            background: var(--primary); color: white; border: none;
            border-radius: 8px; padding: 8px 13px;
            font-family: 'Inter', sans-serif; font-size: .8rem; font-weight: 600;
            cursor: pointer; transition: background .2s; white-space: nowrap;
        }
        .btn-check:hover { background: var(--primary-mid); }

        /* payment */
        .pay-box {
            background: #F8FFF8; border: 1px solid var(--border);
            border-radius: var(--radius-sm); padding: 14px; margin-top: 12px;
        }
        .pay-title { font-size: .79rem; font-weight: 700; margin-bottom: 10px; color: var(--text); }
        .pay-grid { display: grid; grid-template-columns: 1fr 1fr; gap: 8px; }
        .pay-btn {
            border: 2px solid var(--border); background: white;
            border-radius: 9px; padding: 11px 8px;
            font-family: 'Inter', sans-serif; font-size: .77rem; font-weight: 600;
            cursor: pointer; transition: all .2s;
            display: flex; flex-direction: column; align-items: center; gap: 5px;
            color: var(--text);
        }
        .pay-btn i { font-size: 1.2rem; }
        .pay-btn.cash:hover, .pay-btn.cash.sel { border-color: var(--primary); background: #F0FFF4; color: var(--primary); }
        .pay-btn.qr:hover,  .pay-btn.qr.sel   { border-color: #7C3AED; background: #F5F3FF; color: #7C3AED; }
        .btn-process {
            width: 100%; background: linear-gradient(135deg, var(--primary), var(--primary-mid));
            color: white; border: none; border-radius: 10px; padding: 13px;
            font-family: 'Inter', sans-serif; font-size: .88rem; font-weight: 700;
            cursor: pointer; margin-top: 10px; transition: opacity .2s, transform .15s;
            display: flex; align-items: center; justify-content: center; gap: 8px;
        }
        .btn-process:hover { opacity: .92; transform: scale(.99); }
        .btn-process.qr-process { background: linear-gradient(135deg, #5B21B6, #7C3AED); }

        /* receipt */
        .receipt-panel {
            background: white; border: 2px dashed var(--accent);
            border-radius: var(--radius); padding: 20px; display: none;
        }
        .receipt-hd { text-align: center; font-weight: 800; font-size: 1.05rem; color: var(--primary); margin-bottom: 12px; }
        .receipt-row { display: flex; justify-content: space-between; font-size: .83rem; margin: 4px 0; }
        .receipt-divider { border: none; border-top: 1px dashed var(--border); margin: 10px 0; }
        .btn-back {
            flex: 1; border: 2px solid var(--border); background: white;
            border-radius: 10px; padding: 11px; font-family: 'Inter', sans-serif;
            font-weight: 600; cursor: pointer; font-size: .85rem; color: var(--text);
            transition: border-color .2s;
        }
        .btn-back:hover { border-color: var(--accent); }

        /* print */
        @media print {
            body * { visibility: hidden; }
            #receiptBox, #receiptBox * { visibility: visible; }
            #receiptBox { position: absolute; left: 0; top: 0; width: 100%; border: none; }
            #receiptBox button { display: none !important; }
        }

        @media (max-width: 576px) {
            .product-grid { grid-template-columns: repeat(auto-fill, minmax(140px, 1fr)); }
        }
    </style>
</head>
<body>

<jsp:include page="navbar.jsp" />

<div class="container-fluid main-wrap">
    <% if ("unauthorized".equals(request.getParameter("error"))) { %>
    <div class="alert alert-danger" role="alert" style="background: rgba(239,68,68,.18); border: 1px solid rgba(239,68,68,.4); color: #B91C1C; font-weight: 600; border-radius: 10px; margin-bottom: 20px;">
        <i class="fa-solid fa-triangle-exclamation me-2"></i>
        Access Denied. You do not have permission to access that page.
    </div>
    <% } %>
    <div class="row g-3">

        <!-- PRODUCTS -->
        <div class="col-lg-8 order-lg-1">
            <div class="product-panel">
                <div class="breadcrumb-row">
                    <i class="fa-solid fa-house" style="font-size:.7rem;"></i>
                    <span>/</span>
                    <span class="cur">Sale</span>
                </div>
                <div class="panel-header">
                    <div class="panel-title"><i class="fa-solid fa-store"></i> Products</div>
                    <span class="page-chip" id="gridPageChip">Page 1</span>
                </div>
                <div class="search-row">
                    <input type="text" id="searchInput" class="search-input"
                           placeholder="&#xf002;  Search products..." oninput="filterAndRender()">
                    <select class="cat-select" id="categoryFilter" onchange="filterAndRender()">
                        <option value="all">All Categories</option>
                        <option value="plant">&#127807; Plant</option>
                        <option value="tool">&#128296; Tool</option>
                    </select>
                </div>
                <div class="product-grid" id="productGrid"></div>
                <div class="pagination-row" id="paginationRow" style="display:none;">
                    <span class="pag-info" id="paginationInfo">Showing 0&ndash;0 of 0 products</span>
                    <div class="pag-controls" id="paginationControls"></div>
                </div>
            </div>
        </div>

        <!-- CART -->
        <div class="col-lg-4 order-lg-2">
            <div class="cart-panel" id="cartSection">
                <div class="cart-top">
                    <div class="cart-title">
                        <i class="fa-solid fa-bag-shopping"></i> Cart
                        <span class="cart-count-badge" id="cartCountBadge">0</span>
                    </div>
                </div>
                <div class="cart-body" id="cartBody">
                    <div class="cart-empty-msg" id="cartEmptyMsg">
                        <i class="fa-regular fa-shopping-bag"></i>
                        <div>Cart is empty<br><small style="font-size:.76rem;">Add products to begin</small></div>
                    </div>
                </div>
                <div class="total-box">
                    <div class="total-lbl">Total Amount</div>
                    <div class="total-amt"><span class="total-cur">RM&nbsp;</span><span id="totalAmount">0.00</span></div>
                </div>
                <div class="phone-wrap">
                    <label><i class="fa-solid fa-phone"></i>&nbsp; Customer Phone</label>
                    <div class="phone-row">
                        <input type="text" id="customerPhone" class="phone-inp" placeholder="e.g. 01234567890">
                        <button class="btn-check" onclick="validateCustomer()">Check</button>
                    </div>
                    <small id="phoneStatus" style="font-size:.74rem; margin-top:5px; display:block;"></small>
                </div>
                <div class="pay-box">
                    <div class="pay-title"><i class="fa-solid fa-credit-card"></i>&nbsp; Payment Method</div>
                    <div class="pay-grid">
                        <button class="pay-btn cash" id="cashBtn" onclick="showCashPay()">
                            <i class="fa-solid fa-money-bill-wave"></i> Cash
                        </button>
                        <button class="pay-btn qr" id="qrBtn" onclick="showQRPay()">
                            <i class="fa-solid fa-qrcode"></i> E-Wallet QR
                        </button>
                    </div>
                    <div id="cashSection" style="display:none; margin-top:10px;">
                        <input type="number" id="cashInput" class="phone-inp" style="width:100%;" placeholder="Enter amount paid (RM)">
                        <button class="btn-process" onclick="processCashPay()">
                            <i class="fa-solid fa-circle-check"></i> Confirm Payment
                        </button>
                    </div>
                    <div id="qrSection" style="display:none; margin-top:10px; text-align:center;">
                        <img src="https://api.qrserver.com/v1/create-qr-code/?size=155x155&data=BloomCartPayment&bgcolor=ffffff&color=1B4332"
                             style="border-radius:10px; border:3px solid #C8E6C9; max-width:155px; width:100%;" alt="QR Code">
                        <p style="font-size:.74rem; color:var(--text-muted); margin:6px 0;">Scan to pay via e-wallet</p>
                        <button class="btn-process qr-process" onclick="processQRPay()">
                            <i class="fa-solid fa-circle-check"></i> Payment Received
                        </button>
                    </div>
                </div>
            </div>

            <!-- RECEIPT -->
            <div class="receipt-panel" id="receiptBox">
                <div class="receipt-hd"><i class="fa-solid fa-receipt"></i>&nbsp; RECEIPT</div>
                <hr class="receipt-divider">
                <div class="receipt-row"><span>Date</span><span id="receiptDate"></span></div>
                <div class="receipt-row"><span>Sale ID</span><span id="receiptSaleId"></span></div>
                <div class="receipt-row"><span>Staff ID</span><span id="receiptStaffId"></span></div>
                <hr class="receipt-divider">
                <div id="receiptItems"></div>
                <hr class="receipt-divider">
                <div class="receipt-row" style="font-weight:700; font-size:.95rem;">
                    <span>Total</span><span>RM <span id="receiptTotal"></span></span>
                </div>
                <div class="receipt-row"><span>Payment</span><span id="receiptMethod"></span></div>
                <div class="receipt-row"><span>Paid</span><span>RM <span id="receiptPaid"></span></span></div>
                <div class="receipt-row"><span>Balance</span><span>RM <span id="receiptBalance"></span></span></div>
                <div style="display:flex; gap:8px; margin-top:14px;">
                    <button class="btn-process" style="flex:1; margin-top:0; padding:11px;" onclick="window.print()">
                        <i class="fa-solid fa-print"></i> Print
                    </button>
                    <button class="btn-back" onclick="backToCart()">Back</button>
                </div>
            </div>
        </div>
    </div>
</div>

<script>
let products = [];
const ITEMS_PER_PAGE = 6;
let currentPage = 1;
let filtered = [];

// Fetch products from Servlet via AJAX
function loadProducts() {
    fetch('GetProductsServlet')
        .then(response => response.json())
        .then(data => {
            products = data;
            filtered = [...products];
            renderGrid();
        })
        .catch(error => console.error('Error fetching products:', error));
}

// Load products when page starts
document.addEventListener('DOMContentLoaded', loadProducts);

function renderGrid() {
    const grid = document.getElementById('productGrid');
    const total = filtered.length;
    const totalPages = Math.max(1, Math.ceil(total / ITEMS_PER_PAGE));
    if (currentPage > totalPages) currentPage = totalPages;
    const start = (currentPage - 1) * ITEMS_PER_PAGE;
    const end   = Math.min(start + ITEMS_PER_PAGE, total);
    const page  = filtered.slice(start, end);
    if (page.length === 0) {
        grid.innerHTML = `<div class="empty-grid"><i class="fa-solid fa-box-open"></i><p>No products found.</p></div>`;
        document.getElementById('paginationRow').style.display = 'none';
        document.getElementById('gridPageChip').textContent = 'Page 0';
        return;
    }
    grid.innerHTML = page.map(p => {
        const isPlant = p.category === 'plant';
        return `<div class="product-card">
            <div class="card-img-wrap ${isPlant ? 'plant-bg' : 'tool-bg'}" style="overflow:hidden;">
                ${p.imagePath ? `<img src="${p.imagePath}" style="width:100%; height:100%; object-fit:cover;">` : 
                               `<i class="fa-solid ${isPlant ? 'fa-seedling' : 'fa-screwdriver-wrench'} shimmer"></i>`}
            </div>
            <div class="card-body-inner">
                <div class="card-prod-name">${p.name}</div>
                <span class="cat-chip ${isPlant ? 'chip-plant' : 'chip-tool'}">${isPlant ? '🌱 Plant' : '🔧 Tool'}</span>
                <div class="card-price">RM ${p.price.toFixed(2)}</div>
                <button class="btn-add" onclick="addToCart('${p.name.replace(/'/g,"\\'")}', ${p.price}, '${p.category}')">
                    <i class="fa-solid fa-plus"></i> Add to Cart
                </button>
            </div>
        </div>`;
    }).join('');
    document.getElementById('paginationInfo').textContent = `Showing ${start+1}-${end} of ${total} products`;
    document.getElementById('gridPageChip').textContent = `Page ${currentPage} of ${totalPages}`;
    document.getElementById('paginationRow').style.display = 'flex';
    renderPageBtns(totalPages);
}
function renderPageBtns(totalPages) {
    const c = document.getElementById('paginationControls');
    let html = `<button class="pag-btn" onclick="goPage(${currentPage-1})" ${currentPage===1?'disabled':''}><i class="fa-solid fa-chevron-left" style="font-size:.68rem;"></i></button>`;
    for (let i = 1; i <= totalPages; i++) {
        if (totalPages <= 7 || i===1 || i===totalPages || (i>=currentPage-1 && i<=currentPage+1))
            html += `<button class="pag-btn ${i===currentPage?'active':''}" onclick="goPage(${i})">${i}</button>`;
        else if (i===currentPage-2 || i===currentPage+2)
            html += `<span style="padding:0 3px;color:var(--text-muted);">···</span>`;
    }
    html += `<button class="pag-btn" onclick="goPage(${currentPage+1})" ${currentPage===totalPages?'disabled':''}><i class="fa-solid fa-chevron-right" style="font-size:.68rem;"></i></button>`;
    c.innerHTML = html;
}
function goPage(p) {
    const tp = Math.ceil(filtered.length / ITEMS_PER_PAGE);
    if (p < 1 || p > tp) return;
    currentPage = p;
    renderGrid();
    document.getElementById('productGrid').scrollIntoView({ behavior:'smooth', block:'start' });
}
function filterAndRender() {
    const s = document.getElementById('searchInput').value.toLowerCase().trim();
    const cat = document.getElementById('categoryFilter').value;
    filtered = products.filter(p => {
        const ms = p.name.toLowerCase().includes(s) || p.id.toLowerCase().includes(s);
        const mc = cat === 'all' || p.category === cat;
        return ms && mc;
    });
    currentPage = 1;
    renderGrid();
}
renderGrid();

let cart = [];
function addToCart(name, price, category) {
    const ex = cart.find(i => i.name === name);
    if (ex) ex.quantity++; else cart.push({ name, price, category, quantity: 1 });
    updateCart();
}
function updateCart() {
    const body  = document.getElementById('cartBody');
    const empty = document.getElementById('cartEmptyMsg');
    const badge = document.getElementById('cartCountBadge');
    const total = document.getElementById('totalAmount');
    badge.textContent = cart.reduce((s,i) => s + i.quantity, 0);
    body.querySelectorAll('.cart-item-row').forEach(el => el.remove());
    if (!cart.length) { empty.style.display = 'block'; total.textContent = '0.00'; return; }
    empty.style.display = 'none';
    let sum = 0;
    cart.forEach((item, idx) => {
        sum += item.price * item.quantity;
        const isPlant = item.category === 'plant';
        const div = document.createElement('div');
        div.className = 'cart-item-row';
        div.innerHTML = `
            <div class="item-icon ${isPlant?'plant':'tool'}"><i class="fa-solid ${isPlant?'fa-seedling':'fa-screwdriver-wrench'}"></i></div>
            <div class="item-info">
                <div class="item-name">${item.name}</div>
                <div class="item-unit">RM ${item.price.toFixed(2)} each</div>
            </div>
            <div class="item-controls">
                <button class="qty-btn rmv" onclick="changeQty(${idx},-1)">−</button>
                <span class="qty-val">${item.quantity}</span>
                <button class="qty-btn" onclick="changeQty(${idx},1)">+</button>
            </div>`;
        body.appendChild(div);
    });
    total.textContent = sum.toFixed(2);
}
function changeQty(idx, delta) {
    cart[idx].quantity += delta;
    if (cart[idx].quantity <= 0) cart.splice(idx, 1);
    updateCart();
}
function showCashPay() {
    document.getElementById('cashSection').style.display = 'block';
    document.getElementById('qrSection').style.display   = 'none';
    document.getElementById('cashBtn').classList.add('sel');
    document.getElementById('qrBtn').classList.remove('sel');
}
function showQRPay() {
    document.getElementById('cashSection').style.display = 'none';
    document.getElementById('qrSection').style.display   = 'block';
    document.getElementById('qrBtn').classList.add('sel');
    document.getElementById('cashBtn').classList.remove('sel');
}
function validateCustomer() {
    const phone = document.getElementById('customerPhone').value.trim();
    const status = document.getElementById('phoneStatus');
    if (!phone) { status.textContent = 'Please enter a phone number.'; status.style.color = '#EF4444'; return false; }
    status.textContent = '✓ Customer validated'; status.style.color = '#059669'; return true;
}
function getTotal() { return cart.reduce((s,i) => s + i.price * i.quantity, 0); }
function processCashPay() {
    if (!validateCustomer()) return;
    if (!cart.length) return alert('Cart is empty!');
    const total = getTotal();
    const cash = parseFloat(document.getElementById('cashInput').value);
    if (!cash || cash < total) return alert('Insufficient payment amount!');
    generateReceipt('Cash', cash, cash - total);
}
function processQRPay() {
    if (!validateCustomer()) return;
    if (!cart.length) return alert('Cart is empty!');
    generateReceipt('E-Wallet QR', getTotal(), 0);
}
function generateReceipt(method, paid, balance) {
    const total = getTotal();
    document.getElementById('receiptItems').innerHTML = cart.map(i =>
        `<div class="receipt-row"><span>${i.name} ×${i.quantity}</span><span>RM ${(i.price*i.quantity).toFixed(2)}</span></div>`).join('');
    document.getElementById('receiptSaleId').textContent  = '—';
    document.getElementById('receiptStaffId').textContent = '—';
    document.getElementById('receiptTotal').textContent   = total.toFixed(2);
    document.getElementById('receiptMethod').textContent  = method;
    document.getElementById('receiptPaid').textContent    = paid.toFixed(2);
    document.getElementById('receiptBalance').textContent = balance.toFixed(2);
    document.getElementById('receiptDate').textContent    = new Date().toLocaleString();
    document.getElementById('cartSection').style.display  = 'none';
    document.getElementById('receiptBox').style.display   = 'block';
}
function backToCart() {
    document.getElementById('receiptBox').style.display  = 'none';
    document.getElementById('cartSection').style.display = 'flex';
    cart = []; updateCart();
}
</script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
