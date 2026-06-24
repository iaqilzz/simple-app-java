<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    // Already logged in? Go straight to sale page
    if (session.getAttribute("userId") != null) {
        response.sendRedirect("sale.jsp");
        return;
    }
    String error = request.getParameter("error");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Bemban Nursery &mdash; Login</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700;800&display=swap" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css">
    <style>
        :root {
            --primary:   #1B4332;
            --mid:       #2D6A4F;
            --accent:    #52B788;
            --light:     #95D5B2;
        }
        * { box-sizing: border-box; margin: 0; padding: 0; }
        body {
            font-family: 'Inter', sans-serif;
            min-height: 100vh;
            background: linear-gradient(145deg, #0D2818 0%, #1B4332 40%, #2D6A4F 75%, #40916C 100%);
            display: flex; align-items: center; justify-content: center;
            overflow: hidden; position: relative;
        }

        /* animated blobs */
        .blob {
            position: absolute; border-radius: 50%;
            background: rgba(82,183,136,.13);
            animation: blobFloat 8s ease-in-out infinite;
            pointer-events: none;
        }
        .blob-1 { width:380px; height:380px; top:-80px; left:-100px; animation-delay:0s; }
        .blob-2 { width:280px; height:280px; bottom:-60px; right:-60px; animation-delay:-3s; }
        .blob-3 { width:200px; height:200px; top:40%; right:8%; animation-delay:-5s; }
        @keyframes blobFloat {
            0%,100% { transform: scale(1) translate(0,0); }
            33%      { transform: scale(1.05) translate(10px,-15px); }
            66%      { transform: scale(.95) translate(-8px,10px); }
        }

        /* floating leaves */
        .leaf {
            position: absolute; font-size: 1.4rem;
            color: rgba(149,213,178,.3);
            animation: leafDrift linear infinite;
            pointer-events: none; user-select: none;
        }
        @keyframes leafDrift {
            0%   { transform: translateY(110vh) rotate(0deg);   opacity: 0; }
            10%  { opacity: 1; }
            90%  { opacity: .6; }
            100% { transform: translateY(-10vh) rotate(360deg); opacity: 0; }
        }

        /* login card */
        .login-card {
            position: relative; z-index: 10;
            width: 440px; max-width: 95vw;
            background: rgba(255,255,255,.1);
            backdrop-filter: blur(24px) saturate(1.4);
            -webkit-backdrop-filter: blur(24px) saturate(1.4);
            border: 1px solid rgba(255,255,255,.2);
            border-radius: 24px;
            box-shadow: 0 20px 60px rgba(0,0,0,.4), 0 0 0 1px rgba(255,255,255,.05) inset;
            overflow: hidden;
            animation: cardIn .5s cubic-bezier(.34,1.56,.64,1) both;
        }
        @keyframes cardIn {
            from { opacity:0; transform:translateY(28px) scale(.96); }
            to   { opacity:1; transform:translateY(0) scale(1); }
        }

        .card-header-section {
            background: linear-gradient(135deg, rgba(27,67,50,.8), rgba(45,106,79,.6));
            padding: 34px 32px 26px;
            text-align: center;
            border-bottom: 1px solid rgba(255,255,255,.12);
        }
        .logo-ring {
            width: 70px; height: 70px;
            background: rgba(255,255,255,.15);
            border: 2px solid rgba(255,255,255,.3);
            border-radius: 50%;
            display: flex; align-items: center; justify-content: center;
            margin: 0 auto 14px;
            font-size: 1.8rem; color: #95D5B2;
            animation: pulse 2.5s ease-in-out infinite;
        }
        @keyframes pulse {
            0%,100% { box-shadow: 0 0 0 0 rgba(149,213,178,.4); }
            50%      { box-shadow: 0 0 0 12px rgba(149,213,178,0); }
        }
        .card-title { color: white; font-size: 1.4rem; font-weight: 800; letter-spacing:-.5px; }
        .card-sub   { color: rgba(255,255,255,.6); font-size: .84rem; margin-top: 4px; }

        .card-body-section { padding: 28px 32px 32px; }

        /* role tabs */
        .role-tabs {
            display: flex; gap: 0;
            background: rgba(255,255,255,.1);
            border-radius: 12px; padding: 4px;
            margin-bottom: 24px;
            border: 1px solid rgba(255,255,255,.15);
        }
        .role-tab {
            flex: 1; padding: 9px 14px;
            background: transparent; border: none;
            border-radius: 9px;
            font-family: 'Inter', sans-serif;
            font-size: .84rem; font-weight: 600;
            color: rgba(255,255,255,.6); cursor: pointer;
            transition: all .25s ease;
            display: flex; align-items: center; justify-content: center; gap: 6px;
        }
        .role-tab.active {
            background: rgba(255,255,255,.95);
            color: var(--primary);
            box-shadow: 0 2px 8px rgba(0,0,0,.15);
        }
        .role-tab:not(.active):hover { color: white; background: rgba(255,255,255,.12); }

        /* form fields */
        .field-wrap { margin-bottom: 18px; }
        .field-wrap label {
            display: block; font-size: .77rem; font-weight: 600;
            color: rgba(255,255,255,.7); margin-bottom: 7px;
            text-transform: uppercase; letter-spacing: .05em;
        }
        .field-inner {
            position: relative;
        }
        .field-icon {
            position: absolute; left: 14px; top: 50%;
            transform: translateY(-50%);
            color: rgba(255,255,255,.4); font-size: .9rem;
            pointer-events: none;
        }
        .login-input {
            width: 100%;
            background: rgba(255,255,255,.1);
            border: 1.5px solid rgba(255,255,255,.2);
            border-radius: 11px;
            padding: 12px 14px 12px 40px;
            color: white; font-family: 'Inter', sans-serif; font-size: .9rem;
            outline: none; transition: all .22s;
        }
        .login-input::placeholder { color: rgba(255,255,255,.35); }
        .login-input:focus {
            border-color: var(--light);
            background: rgba(255,255,255,.15);
            box-shadow: 0 0 0 3px rgba(149,213,178,.2);
        }

        /* login btn */
        .btn-login {
            width: 100%; padding: 13px;
            background: linear-gradient(135deg, var(--accent), #40916C);
            color: white; border: none; border-radius: 11px;
            font-family: 'Inter', sans-serif; font-size: .95rem; font-weight: 700;
            cursor: pointer; margin-top: 8px;
            transition: opacity .2s, transform .15s, box-shadow .2s;
            box-shadow: 0 4px 15px rgba(82,183,136,.4);
            display: flex; align-items: center; justify-content: center; gap: 8px;
        }
        .btn-login:hover  { opacity: .93; transform: translateY(-1px); box-shadow: 0 6px 20px rgba(82,183,136,.5); }
        .btn-login:active { transform: translateY(0); }

        /* footer note */
        .login-footer {
            text-align: center; margin-top: 20px;
            font-size: .76rem; color: rgba(255,255,255,.4);
        }

        /* Error alert shown when login fails */
        .login-error {
            background: rgba(239,68,68,.18);
            border: 1px solid rgba(239,68,68,.4);
            border-radius: 10px;
            padding: 10px 14px;
            margin-bottom: 16px;
            font-size: .83rem;
            font-weight: 600;
            color: #FCA5A5;
            display: flex;
            align-items: center;
            gap: 8px;
        }
    </style>
</head>
<body>

<!-- bg blobs -->
<div class="blob blob-1"></div>
<div class="blob blob-2"></div>
<div class="blob blob-3"></div>

<!-- floating leaves -->
<script>
    const leaves = ['🌿','🍃','🌱','🍀','🌾'];
    for (let i = 0; i < 10; i++) {
        const l = document.createElement('span');
        l.className = 'leaf';
        l.textContent = leaves[Math.floor(Math.random() * leaves.length)];
        l.style.cssText = `
            left: ${Math.random()*100}%;
            animation-duration: ${10 + Math.random()*10}s;
            animation-delay: ${-Math.random()*12}s;
            font-size: ${.8 + Math.random()*1.2}rem;
        `;
        document.body.appendChild(l);
    }
</script>

<!-- LOGIN CARD -->
<div class="login-card">

    <div class="card-header-section">
        <div class="logo-ring"><i class="fa-solid fa-leaf"></i></div>
        <div class="card-title">Bemban Nursery</div>
        <div class="card-sub">POS System &mdash; Sign in to continue</div>
    </div>

    <div class="card-body-section">

        <!-- Error message from LoginServlet -->
        <% if ("invalid".equals(error)) { %>
        <div class="login-error">
            <i class="fa-solid fa-triangle-exclamation"></i>
            Wrong User ID or password. Please try again.
        </div>
        <% } else if ("empty".equals(error)) { %>
        <div class="login-error">
            <i class="fa-solid fa-triangle-exclamation"></i>
            Please fill in both fields.
        </div>
        <% } else if ("db".equals(error)) { %>
        <div class="login-error">
            <i class="fa-solid fa-database"></i>
            Database connection error. Contact admin.
        </div>
        <% } %>

        <form action="LoginServlet" method="post">
            <div class="field-wrap">
                <label for="username">Username</label>
                <div class="field-inner">
                    <i class="fa-solid fa-user field-icon"></i>
                    <input type="text" class="login-input" id="username" name="username"
                           placeholder="Enter your username" required autocomplete="username">
                </div>
            </div>

            <div class="field-wrap">
                <label for="password">Password</label>
                <div class="field-inner">
                    <i class="fa-solid fa-lock field-icon"></i>
                    <input type="password" class="login-input" id="password" name="password"
                           placeholder="Enter your password" required autocomplete="current-password">
                </div>
            </div>

            <button type="submit" class="btn-login">
                <i class="fa-solid fa-right-to-bracket"></i>
                <span id="loginBtnText">Sign In</span>
            </button>
        </form>

        <div class="login-footer">
            &copy; 2025 Bemban Nursery &mdash; All rights reserved
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>