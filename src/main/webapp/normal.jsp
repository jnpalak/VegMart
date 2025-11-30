<%@page import="com.yash.vegmart.entity.User" %>

<%
User user = (User) session.getAttribute("userObj");
if (user == null) {
    session.setAttribute("msg", "You are not Logged in, Please Login First");
    response.sendRedirect("login.jsp");
    return;
} else {
    if (user.getUserType().equals("admin")) {
        session.setAttribute("error", "You are not Normal User !! Do not access this page");
        response.sendRedirect("login.jsp");
        return;
    }
}
%>
<%@ include file="components/header.jsp" %>


<!DOCTYPE html>
<html>
<head>
    <title>User Dashboard | VegMart</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">

    <style>
        body {
            background: #f0fff4;
        }
        .user-box {
            max-width: 800px;
            margin: 60px auto;
            padding: 40px;
            border-radius: 15px;
            background: white;
            box-shadow: 0 5px 20px rgba(0,0,0,0.1);
            text-align: center;
        }
        .welcome-title {
            font-size: 32px;
            font-weight: bold;
            color: #2e8b57;
        }
        .welcome-sub {
            font-size: 18px;
            color: #555;
        }
        .btn-shop {
            background: #2e8b57;
            color: white;
            padding: 12px 25px;
            border-radius: 8px;
            text-decoration: none;
            font-size: 18px;
            margin-top: 20px;
        }
        .btn-shop:hover {
            background: #246c46;
            color: white;
        }
    </style>
</head>

<body>

<div class="user-box">
    <h2 class="welcome-title">Welcome, <%= user.getName() %> </h2>
    <p class="welcome-sub">We're glad to have you back! Start exploring fresh groceries now.</p>

    <a href="products.jsp" class="btn-shop">Shop Now</a>
</div>

</body>
</html>