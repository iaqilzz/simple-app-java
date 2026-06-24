<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="true" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Report | BLOOMCART POS</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css">
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jspdf/2.5.1/jspdf.umd.min.js"></script>
    <link rel="stylesheet" href="style.css">
    <style>
        /* ── REPORT PAGE SPECIFIC ────────────────── */

        /* Filter panel */
        .filter-panel {
            background: #F5FCF5; border: 1px solid var(--border);
            border-radius: var(--radius-sm); padding: 18px; margin-bottom: 20px;
        }
        .filter-label {
            font-size: .76rem; font-weight: 600; color: var(--primary);
            margin-bottom: 6px; display: block;
            text-transform: uppercase; letter-spacing: .04em;
        }

        /* Stat cards */
        .stat-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(160px, 1fr));
            gap: 14px; margin-bottom: 20px;
        }
        .stat-card {
            background: var(--surface); border: 1.5px solid var(--border);
            border-radius: var(--radius-sm); padding: 16px;
            display: flex; flex-direction: column; gap: 8px;
            transition: box-shadow .2s, transform .2s;
        }
        .stat-card:hover { box-shadow: var(--shadow); transform: translateY(-2px); }
        .stat-icon {
            width: 40px; height: 40px; border-radius: 10px;
            display: flex; align-items: center; justify-content: center;
            font-size: 1rem; color: white;
        }
        .si-orders  { background: linear-gradient(135deg, #1B4332, #2D6A4F); }
        .si-revenue { background: linear-gradient(135deg, #065F46, #059669); }
        .si-top     { background: linear-gradient(135deg, #78350F, #B45309); }
        .si-qty     { background: linear-gradient(135deg, #1E40AF, #3B82F6); }
        .stat-label { font-size: .74rem; color: var(--text-muted); font-weight: 500; }
        .stat-value { font-size: 1.35rem; font-weight: 800; color: var(--text); line-height: 1.1; }
        .stat-value.sm { font-size: 1rem; }

        /* Report table panel */
        .table-panel { background: var(--surface); border: 1px solid var(--border); border-radius: var(--radius-sm); overflow: hidden; }
        .table-panel-hd { background: #E8F5E9; padding: 12px 16px; display: flex; align-items: center; justify-content: space-between; border-bottom: 1px solid var(--border); }
        .table-panel-title { font-size: .85rem; font-weight: 700; color: var(--primary); display: flex; align-items: center; gap: 6px; }

        /* No data state */
        .no-data-row td { padding: 50px 20px; text-align: center; color: var(--text-muted); }
        .no-data-row i  { font-size: 2.5rem; display: block; margin-bottom: 12px; opacity: .35; }

        /* Payment method badges */
        .pay-badge-cash { background: #D1FAE5; color: #065F46; font-size: .68rem; font-weight: 700; padding: 2px 9px; border-radius: 6px; }
        .pay-badge-qr   { background: #EDE9FE; color: #5B21B6; font-size: .68rem; font-weight: 700; padding: 2px 9px; border-radius: 6px; }
    </style>
</head>
<body>

<jsp:include page="navbar.jsp" />

<div class="container-fluid main-wrap">
    <div class="page-section">
        <div class="breadcrumb-row">
            <i class="fa-solid fa-house" style="font-size:.7rem;"></i>
            <span>/</span>
            <span class="cur">Report</span>
        </div>
        <h2 class="page-title"><i class="fa-solid fa-chart-bar"></i> Sales Report</h2>
        <p class="page-sub">Generate and review sales performance by date range, month, or week</p>

        <!-- Filter Panel -->
        <div class="filter-panel">
            <div class="row g-3 align-items-end">
                <div class="col-md-2">
                    <label class="filter-label" for="year"><i class="fa-solid fa-calendar me-1"></i> Year</label>
                    <select id="year" class="form-select">
                        <option value="2026">2026</option>
                        <option value="2025">2025</option>
                    </select>
                </div>

                <div class="col-md-2">
                    <label class="filter-label" for="month"><i class="fa-solid fa-calendar-days me-1"></i> Month</label>
                    <select id="month" class="form-select">
                        <option value="">All Months</option>
                        <option value="0">January</option>
                        <option value="1">February</option>
                        <option value="2">March</option>
                        <option value="3">April</option>
                        <option value="4">May</option>
                        <option value="5">June</option>
                        <option value="6">July</option>
                        <option value="7">August</option>
                        <option value="8">September</option>
                        <option value="9">October</option>
                        <option value="10">November</option>
                        <option value="11">December</option>
                    </select>
                </div>

                <div class="col-md-2">
                    <label class="filter-label" for="week"><i class="fa-solid fa-calendar-week me-1"></i> Week</label>
                    <select id="week" class="form-select" disabled>
                        <option value="">All Weeks</option>
                        <option value="1">Week 1</option>
                        <option value="2">Week 2</option>
                        <option value="3">Week 3</option>
                        <option value="4">Week 4</option>
                    </select>
                </div>

                <div class="col-md-3">
                    <label class="filter-label"><i class="fa-solid fa-calendar-range me-1"></i> Date Range</label>
                    <div class="d-flex gap-2">
                        <input type="date" id="startDate" class="form-control" style="font-size:.8rem;">
                        <input type="date" id="endDate"   class="form-control" style="font-size:.8rem;">
                    </div>
                </div>

                <div class="col-md-1 d-flex align-items-center" style="margin-top:8px;">
                    <div class="form-check mb-0">
                        <input class="form-check-input" type="checkbox" id="today" style="width:16px;height:16px;">
                        <label class="form-check-label" for="today" style="font-size:.82rem; font-weight:600;">Today</label>
                    </div>
                </div>

                <div class="col-md-2 d-flex gap-2" style="margin-top:8px;">
                    <button class="btn-green" style="flex:1;" onclick="generateReport()">
                        <i class="fa-solid fa-play"></i> Generate
                    </button>
                    <button class="btn-secondary-custom" style="flex:1;" onclick="resetReport()">
                        <i class="fa-solid fa-rotate-left"></i>
                    </button>
                </div>
            </div>
        </div>

        <!-- Stat Cards (hidden until generated) -->
        <div class="stat-grid" id="stats" style="display:none;">
            <div class="stat-card">
                <div class="stat-icon si-orders"><i class="fa-solid fa-bag-shopping"></i></div>
                <div class="stat-label">Total Orders</div>
                <div class="stat-value" id="o">—</div>
            </div>
            <div class="stat-card">
                <div class="stat-icon si-revenue"><i class="fa-solid fa-coins"></i></div>
                <div class="stat-label">Total Revenue</div>
                <div class="stat-value" id="r">—</div>
            </div>
            <div class="stat-card">
                <div class="stat-icon si-top"><i class="fa-solid fa-star"></i></div>
                <div class="stat-label">Top Product</div>
                <div class="stat-value sm" id="t">—</div>
            </div>
            <div class="stat-card">
                <div class="stat-icon si-qty"><i class="fa-solid fa-boxes-stacked"></i></div>
                <div class="stat-label">Units Sold</div>
                <div class="stat-value" id="q">—</div>
            </div>
        </div>

        <!-- Results Table (hidden until generated) -->
        <div id="tableBox" style="display:none;">
            <div class="table-panel">
                <div class="table-panel-hd">
                    <div class="table-panel-title">
                        <i class="fa-solid fa-table-list"></i> Sales Transactions
                    </div>
                    <button class="btn-green" style="padding:7px 14px; font-size:.8rem;" onclick="downloadPDF()">
                        <i class="fa-solid fa-file-arrow-down"></i> Download PDF
                    </button>
                </div>
                <div class="table-responsive">
                    <table class="table table-hover">
                        <thead>
                            <tr>
                                <th>Date</th>
                                <th>Order #</th>
                                <th>Product</th>
                                <th>Qty</th>
                                <th>Total (RM)</th>
                                <th>Payment</th>
                            </tr>
                        </thead>
                        <tbody id="table">
                            <tr class="no-data-row" id="noReportMsg">
                                <td colspan="6">
                                    <i class="fa-solid fa-chart-bar"></i>
                                    No records found. Select filters above and click Generate.
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
function generateReport() {
    document.getElementById('stats').style.display    = 'grid';
    document.getElementById('tableBox').style.display = 'block';
    // TODO: Replace with actual AJAX/servlet call to fetch real data
    document.getElementById('o').textContent = '—';
    document.getElementById('r').textContent = 'RM —';
    document.getElementById('t').textContent = '—';
    document.getElementById('q').textContent = '—';
}
function resetReport() {
    document.getElementById('year').value = '2026';
    document.getElementById('month').value = '';
    document.getElementById('week').value = '';
    document.getElementById('startDate').value = '';
    document.getElementById('endDate').value = '';
    document.getElementById('today').checked = false;
    document.getElementById('stats').style.display    = 'none';
    document.getElementById('tableBox').style.display = 'none';
}
function downloadPDF() {
    alert('PDF download — connect to jsPDF implementation.');
}

// Enable week select only when a month is selected
document.getElementById('month').addEventListener('change', function() {
    document.getElementById('week').disabled = !this.value;
    if (!this.value) document.getElementById('week').value = '';
});
</script>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
