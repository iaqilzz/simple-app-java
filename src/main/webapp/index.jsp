<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Bemban Nursery POS Login</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">

    <style>
        body {
            background: #CDEAC0;
            min-height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
            font-family: Arial, sans-serif;
        }

        .login-card {
            width: 450px;
            border-radius: 18px;
            overflow: hidden;
            box-shadow: 0 10px 25px rgba(0,0,0,0.15);
        }

        .login-header {
            background: #4F7942;
            color: white;
            text-align: center;
            padding: 25px;
        }

        .login-body {
            background: white;
            padding: 35px;
        }

        .form-control {
            height: 50px;
            border-radius: 10px;
        }

        .btn-login {
            height: 50px;
            border-radius: 10px;
            font-weight: bold;
            background: #4F7942;
            border: none;
        }

        .btn-login:hover {
            background: #3e6233;
        }


        .owner-option {
            text-align: center;
            margin-top: 20px;
        }

        .owner-option a {
            color: #4F7942;
            text-decoration: none;
            font-weight: bold;
        }

        .owner-option a:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>

<div class="card login-card">

    <div class="login-header">
        <h2>🌱 Bemban Nursery</h2>
        <p class="mb-0">POS System Login</p>
    </div>

    <div class="login-body">

        <form action="LoginServlet" method="post">

            <div class="mb-3">
                <label for="userId">User ID</label>
                <input type="text" class="form-control" id="userId" name="userId" placeholder="Enter User ID" required>
            </div>

            <div class="mb-3">
                <label for="password">Password</label>
                <input type="password" class="form-control" id="password" name="password" placeholder="Enter Password" required>
            </div>

            <div class="d-grid">
                <button type="submit" class="btn btn-login">
                    Login
                </button>
            </div>

        </form>


    </div>
</div>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>