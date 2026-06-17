<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Report | BLOOMCART POS SYSTEM</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdnjs.cloudflare.com/ajax/libs/jspdf/2.5.1/jspdf.umd.min.js"></script>

<style>
body{
    background:#CDEAC0;
    font-family:Arial;
}

.navbar {
    background: linear-gradient(to right, #2e7d32, #4caf50);
}

.box{
    background:white;
    padding:25px;
    margin-top:30px;
    border-radius:15px;
}

.stat{
    background:#f1f8e9;
    padding:10px;
    border-radius:10px;
}

.btn-green{
    background:#2e7d32;
    color:white;
}

.btn-green:hover{
    background:#1b5e20;
    color:white;
}
</style>
</head>

<body>

<nav class="navbar navbar-expand-lg navbar-dark shadow">
<div class="container-fluid">
<span class="navbar-brand fw-bold">🌿 BLOOMCART POS SYSTEM</span>
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

<div class="container box">

<h3 class="text-success">📊 Sales Report</h3>

<div class="row g-2">

<div class="col-md-3">
<select id="year" class="form-select">
<option value="2026">2026</option>
<option value="2025">2025</option>
</select>

<div class="mt-2">
<div class="row g-1">

<div class="col-6">
<small class="text-muted">Start</small>
<input type="date" id="startDate" class="form-control">
</div>

<div class="col-6">
<small class="text-muted">End</small>
<input type="date" id="endDate" class="form-control">
</div>

</div>
</div>
</div>

<div class="col-md-2">
<select id="month" class="form-select">
<option value="">All Month</option>
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
<select id="week" class="form-select" disabled>
<option value="">All Week</option>
<option value="1">Week 1</option>
<option value="2">Week 2</option>
<option value="3">Week 3</option>
<option value="4">Week 4</option>
</select>
</div>

<div class="col-md-2 d-flex align-items-center">
<input type="checkbox" id="today">
<label class="ms-2" for="today">Today</label>
</div>

<div class="col-md-3 d-flex gap-2">
<button class="btn btn-green w-100">Generate</button>
<button class="btn btn-secondary w-100">Reset</button>
</div>

</div>

<div class="row mt-3" id="stats" style="display:none;">
<div class="col-md-3"><div class="stat">Orders <div id="o"></div></div></div>
<div class="col-md-3"><div class="stat">Revenue <div id="r"></div></div></div>
<div class="col-md-3"><div class="stat">Top Product <div id="t"></div></div></div>
<div class="col-md-3"><div class="stat">Qty <div id="q"></div></div></div>
</div>

<div id="tableBox" class="mt-3" style="display:none;">
<table class="table table-bordered">
<thead class="table-success">
<tr>
<th>Date</th>
<th>Order</th>
<th>Product</th>
<th>Qty</th>
<th>Total</th>
<th>Payment</th>
</tr>
</thead>
<tbody id="table">
    <tr id="noReportMsg">
        <td colspan="6" class="text-center py-5 text-muted">
            No records found. Please select a filter and click Generate.
        </td>
    </tr>
</tbody>
</table>

<button class="btn btn-success mt-3">
⬇ Download PDF
</button>

</div>

</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>