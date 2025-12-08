<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Register - VegMart</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">

    <style>
        body {
            background: #eaffea;
        }
        .register-card {
            max-width: 480px;
            margin: auto;
            margin-top: 60px;
            padding: 35px;
            border-radius: 15px;
            background: #ffffff;
            box-shadow: 0 6px 20px rgba(0,0,0,0.12);
        }
        .title {
            font-weight: 700;
            font-size: 26px;
            color: #2e8b57;
        }
        .form-control {
            height: 45px;
            border-radius: 8px;
        }
        .btn-success {
            width: 100%;
            padding: 10px;
            font-size: 18px;
            border-radius: 8px;
            background: #2e8b57;
        }
        textarea {
            border-radius: 8px !important;
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

<body>
<%@ include file="components/common/header.jsp" %>
<div style="background:#eaffea; min-height:100vh; padding-top:10px;">
<div class="container">
    <div class="register-card">

        <h2 class="text-center mb-3 title">Create Your VegMart Account</h2>

        <% if(request.getAttribute("msg")!=null) { %>
           <div class="alert alert-success text-center">
               <strong><%= request.getAttribute("msg") %></strong>
           </div>
        <% } %>

        <% if(request.getAttribute("error")!=null) { %>
            <div class="alert alert-danger text-center">
                <%= request.getAttribute("error") %>
            </div>
        <% } %>

        <% if(request.getAttribute("emailerror")!=null) { %>
            <div class="alert alert-danger text-center">
                <strong><%= request.getAttribute("emailerror") %></strong>
            </div>
        <% } %>

        <form action="RegistrationServlet" method="post">

            <div class="mb-3">
                <label class="form-label">Full Name</label>
                <input type="text" name="name" class="form-control" required>
            </div>

            <div class="mb-3">
                <label class="form-label">Email ID</label>
                <input type="email" name="email" class="form-control" required>
            </div>

            <div class="mb-3">
                <label class="form-label">Mobile Number</label>
                <input type="text" name="mobile" class="form-control" pattern="[0-9]{10}" required>
            </div>

            <div class="mb-3">
                <label class="form-label">Full Address</label>
                <textarea name="address" class="form-control" rows="2" required></textarea>
            </div>

            <div class="mb-3">
                <label class="form-label">Password</label>
                <input type="password" name="password" class="form-control" required minlength="6">
            </div>

            <button type="submit" class="btn btn-success">Register</button>

            <div class="text-center mt-3">
                Already have an account?
                <a href="login.jsp" class="text-success fw-bold">Login</a>
            </div>

        </form>
    </div>
</div>
</div>
<%@ include file="components/common/footer.jsp" %>
</body>
</html>



