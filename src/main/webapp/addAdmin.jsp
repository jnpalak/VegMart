<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.*" %>
<%@ page import="com.yash.vegmart.entity.User" %>
<%@ page import="com.yash.vegmart.service.UserService" %>
<%@ page import="com.yash.vegmart.serviceimpl.UserServiceImpl" %>

<%

    User admin = (User) session.getAttribute("userObj");
    if (admin == null || !"admin".equals(admin.getUserType())) {
        session.setAttribute("msg", "Access Denied!");
        response.sendRedirect("login.jsp");
        return;
    }

%>
<%

    String error = (String) session.getAttribute("error");
    String success = (String) session.getAttribute("success");
    if (error != null) {
%>
<div class="alert alert-danger text-center"><%= error %></div>
<%
        session.removeAttribute("error");
    }
    if (success != null) {
%>
<div class="alert alert-success text-center"><%= success %></div>
<%
        session.removeAttribute("success");
    }
%>

<!DOCTYPE html>
<html>
<head>
<title>Add Admin | VegMart</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">

    <style>

        body {

            background: #eaffea !important;

            font-family: Segoe UI, sans-serif;

        }

        .card-box {

            background: #ffffff;

            padding: 25px 30px;

            border-radius: 12px;

            box-shadow: 0 5px 18px rgba(0,0,0,0.12);

        }

        .section-title {

            font-size: 20px;

            font-weight: 700;

            color: #2e7d32;

            margin-bottom: 15px;

            text-align: center;

        }

        .btn-blue {

            background: #007bff;

            color: white;

            border-radius: 6px;

            padding: 7px 22px;

        }

        .btn-blue:hover {

            background: #0069d9;

        }

        .btn-delete {

            background: #d9534f;

            color: white;

            padding: 5px 15px;

            border: none;

            border-radius: 6px;

        }

        .btn-delete:hover {

            background: #c9302c;

        }
</style>
</head>

<body>

<%@ include file="components/common/header.jsp" %>

<div class="container my-4">

    <div class="row g-4">

        <!-- LEFT: ADD ADMIN FORM -->
<div class="col-md-4">
<div class="card-box">

                <h5 class="section-title">Add Admin</h5>

                <form action="AddAdminServlet" method="post">

                    <div class="row">
<div class="col-12 mb-3">
<label class="form-label">Full Name</label>
<input type="text" name="name" class="form-control" required>
</div>

                        <div class="col-12 mb-3">
<label class="form-label">Mobile Number</label>
<input type="text" name="mobile" class="form-control" required>
</div>

                        <div class="col-12 mb-3">
<label class="form-label">Email</label>
<input type="email" name="email" class="form-control" required>
</div>

                        <div class="col-12 mb-3">
<label class="form-label">Password</label>
<input type="password" name="password" class="form-control" required>
</div>
</div>
<button class="btn btn-success w-100">Register</button>

                </form>

            </div>
</div>

        <!-- RIGHT: ADMIN LIST TABLE -->
<div class="col-md-8">
<div class="card-box">

                <h5 class="section-title">Admin Details</h5>

                <%

                    UserService us = new UserServiceImpl();

                    List<User> adminList = us.getAllUsers();

                %>

                <table class="table table-bordered text-center align-middle">
<thead style="background:#f8f9fa; font-weight:600;">
<tr>
<td>Full Name</td>
<td>Contact No.</td>
<td>Email</td>
<td>Action</td>
</tr>
</thead>
<tbody>
<% for (User u2 : adminList)
{
if("admin".equals(u2.getUserType()))
{
 %>
<tr>
<td><%= u2.getName() %></td>
<td><%= u2.getMobile() %></td>
<td><%= u2.getEmail() %></td>
<td>
<form action="DeleteAdminServlet" method="post" style="display:inline-block;">
<input type="hidden" name="adminId" value="<%= u2.getUserId() %>">
<button class="btn btn-danger btn-sm" onclick="return confirm('Delete this admin?');" >Delete</button>
</form>
</td>
</tr>
<% }} %>
</tbody>
</table>
<div class="text-center mt-4">
<a href="javascript:history.back()" class="btn btn-outline-success px-4"> Back </a>
</div>
            </div>
</div>

    </div>

</div>

<%@ include file="components/common/footer.jsp" %>

</body>
</html>

