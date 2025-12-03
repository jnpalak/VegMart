<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*" %>
<%@ page import="com.yash.vegmart.entity.User" %>
<%@ page import="com.yash.vegmart.service.UserService" %>
<%@ page import="com.yash.vegmart.serviceimpl.UserServiceImpl" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <title>Manage Users | Admin</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">

    <style>
        body {
            background: #eaffea;
            font-family: Segoe UI, sans-serif;
        }

        .table-box {
            background: white;
            padding: 25px;
            border-radius: 12px;
            margin-top: 40px;
            box-shadow: 0 5px 20px rgba(0,0,0,0.15);
        }

        .table thead {
            background: #2e7d32;
            color: white;
            font-size: 15px;
        }

        .btn-delete {
            background: #d32f2f;
            border: none;
            padding: 5px 15px;
            color: white;
            font-weight: 600;
            border-radius: 6px;
        }

        .btn-delete:hover {
            background: #b71c1c;
        }
    </style>
</head>

<body>

<!-- HEADER -->
<%@ include file="components/common/header.jsp" %>
<div style="background:#eaffea; min-height:100vh; padding-top:10px;">
<div class="container">
    <div class="table-box">
        <h3 class="fw-bold mb-4 text-success text-center">User Details</h3>

        <%
            UserService us = new UserServiceImpl();
            List<User> users = us.getAllUsers();
        %>

        <table class="table table-bordered text-center align-middle">
            <thead>
                <tr>
                    <th>Full Name</th>
                    <th>Email</th>
                    <th>Mobile No</th>
                    <th>Address</th>
                    <th>Action</th>
                </tr>
            </thead>

            <tbody>
            <% for (User u : users) { %>
                <tr>
                    <td><%= u.getName() %></td>
                    <td><%= u.getEmail() %></td>
                    <td><%= u.getMobile() %></td>
                    <td><%= u.getAddress() %></td>

                    <td>
                        <form action="DeleteUserServlet" method="post">
                            <input type="hidden" name="uid" value="<%= u.getUserId() %>">
                            <button class="btn-delete">Delete</button>
                        </form>
                    </td>
                </tr>
            <% } %>
            </tbody>
        </table>

    </div>
</div>
</div>
</body>
</html>