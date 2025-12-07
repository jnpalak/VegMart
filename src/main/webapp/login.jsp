<!DOCTYPE html>
<html>
<head>
    <title>VegMart | Login</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background: #eaffea;
        }
        .login-card {
            max-width: 450px;
            margin: 70px auto;
            padding: 35px;
            border-radius: 14px;
            background: #ffffff;
            box-shadow: 0 6px 20px rgba(0,0,0,0.12);
        }
        .title {
            text-align: center;
            font-size: 26px;
            font-weight: 700;
            color: #2e8b57;
            margin-bottom: 10px;
        }
        .subtitle {
            text-align: center;
            color: #6c757d;
            margin-bottom: 20px;
        }
        .btn-success {
            width: 100%;
            background-color: #2e8b57;
            padding: 10px;
            font-size: 18px;
            border-radius: 8px;
        }
        .form-control {
            height: 45px;
            border-radius: 8px;
        }
        #cardModal
        {
         position :fixed !important;
         top :0 !important;
         left:0 !important;
         width : 100% !important;
         z-index:9999 !important;
         }
         #cartButtonNav
         {
         display:flex;
         align-items:center;
         justify-content: center;
         gap:5px;
         }
    </style>
</head>

<body style="background:#eaffea;">
<%@ include file="components/common/header.jsp" %>
<div>
<div class="login-card">

    <h2 class="title">Welcome Back</h2>
    <p class="subtitle">Login to continue shopping</p>

    <%
    String error= (String)session.getAttribute("error");
    if (error!= null) { %>
        <div class="alert alert-danger text-center">
            <%= error %>
        </div>
    <%
      session.removeAttribute("error");
    } %>
    <%
        String msg= (String)session.getAttribute("msg");
        if (msg!= null) { %>
            <div class="alert alert-danger text-center">
                <%= msg %>
            </div>
        <%
          session.removeAttribute("msg");
        } %>


    <form action="LoginServlet" method="post">

        <div class="mb-3">
            <label class="form-label">Email ID</label>
            <input type="email" name="email" class="form-control"
                   placeholder="Enter your email" required>
        </div>

        <div class="mb-3">
            <label class="form-label">Password</label>
            <input type="password" name="password" class="form-control"
                   placeholder="Enter your password" required>
        </div>

        <button class="btn btn-success">Login</button>

        <div class="text-center mt-3">
            New to VegMart? <a href="register.jsp" class="text-success fw-bold">Create Account</a>
        </div>

    </form>
</div>
</div>
<%@ include file="components/common/footer.jsp" %>
</body>
</html>
