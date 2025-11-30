<%@page import="com.yash.vegmart.entity.User"%>
<%@page import="com.yash.vegmart.entity.Category"%>
<%@page import="java.util.List"%>
<%@page import="com.yash.vegmart.service.CategoryService" %>
<%@page import="com.yash.vegmart.serviceimpl.CategoryServiceImpl" %>

<% User loggedUser = (User) session.getAttribute("userObj");
if (loggedUser == null) {
    session.setAttribute("msg", "You are not Logged in, Please Login First");
    response.sendRedirect("login.jsp");
    return;
} else {
    if (loggedUser.getUserType().equals("normal")) {
        session.setAttribute("error", "You are not admin !! Do not access this page");
        response.sendRedirect("login.jsp");
        return;
    }
}
%>
<%@ include file="components/header.jsp" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <title>Admin Dashboard | VegMart</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" />
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet" />

    <style>
        body {
            background-color: #f8fbf7;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            margin: 0;
            min-height: 100vh;
            display: flex;
            flex-direction: column;
        }
        .container-main {
            max-width: 900px;
            margin: 60px auto 100px auto;
            background: white;
            border-radius: 16px;
            box-shadow: 0 8px 30px rgba(46, 139, 87, 0.15);
            padding: 40px 50px;
        }
        .welcome-header {
            color: #2e8b57;
            font-weight: 800;
            font-size: 28px;
            margin-bottom: 6px;
        }
        .welcome-sub {
            color: #596953;
            font-size: 16px;
            margin-bottom: 32px;
        }

        .nav-list {
            list-style: none;
            padding: 0;
            margin-bottom: 50px;
            display: flex;
            flex-direction: column;
            gap: 16px;
            user-select: none;
        }
        .nav-list li a {
            color: #2e8b57;
            font-weight: 700;
            font-size: 17px;
            padding: 14px 20px;
            border-radius: 12px;
            background: #e6f0e6;
            text-decoration: none;
            display: flex;
            align-items: center;
            transition: background-color 0.3s ease;
        }
        .nav-list li a:hover, .nav-list li a:focus {
            background: #2e8b57;
            color: #ffffff;
            outline: none;
        }
        .nav-list li a i {
            margin-right: 16px;
            font-size: 20px;
        }

        .add-category-section {
            max-width: 480px;
            margin: 0 auto;
            border-radius: 20px;
            padding: 30px 35px;
            background: #e9f5e9;
            box-shadow: 0 12px 32px rgba(46, 139, 87, 0.12);
        }
        .add-category-section h4 {
            color: #2e8b57;
            font-weight: 900;
            text-align: center;
            margin-bottom: 28px;
            user-select: none;
        }
        .add-category-section form {
            display: flex;
            gap: 16px;
        }
        .add-category-section input[type="text"] {
            flex: 1;
            padding: 14px 18px;
            border-radius: 14px;
            border: 2px solid #2e8b57;
            font-weight: 600;
            font-size: 16px;
            color: #2e8b57;
            transition: box-shadow 0.3s ease;
        }
        .add-category-section input[type="text"]:focus {
            outline: none;
            box-shadow: 0 0 8px #2e8b57;
        }
        .add-category-section button {
            background-color: #2e8b57;
            color: white;
            font-weight: 800;
            border: none;
            padding: 14px 28px;
            border-radius: 14px;
            cursor: pointer;
            transition: background-color 0.25s ease;
        }
        .add-category-section button:hover {
            background-color: #196530;
        }
        .custom-header {
          background-color:#43a047 ;
          color: white;
        }


        @media (max-width: 576px) {
            .container-main {
                padding: 25px 20px;
                margin: 40px auto 80px auto;
            }
            .nav-list li a {
                font-size: 15px;
                padding: 12px 12px;
            }
            .nav-list li a i {
                margin-right: 10px;
                font-size: 18px;
            }
            .add-category-section form {
                flex-direction: column;
            }
            .add-category-section input[type="text"],
            .add-category-section button {
                width: 100%;
            }
            .add-category-section button {
                margin-top: 12px;
            }
        }
    </style>
</head>
<body>

<body style="background:#f5f7fa; font-family: 'Segoe UI', sans-serif;">

<!-- TOP NAVBAR -->
<nav class="navbar navbar-expand-lg navbar-light shadow-sm" style="background:#2e7d32;">
    <div class="container-fluid px-4">
        <a class="navbar-brand fw-bold text-white">VegMart Admin</a>

        <ul class="navbar-nav ms-auto">
            <li class="nav-item">
                <span class="nav-link text-white fw-bold">
                    <i class="fa fa-user-circle me-1"></i> Admin
                </span>
            </li>
        </ul>
    </div>
</nav>

<!-- SIDEBAR + CONTENT WRAPPER -->
<div class="d-flex">

    <!-- SIDEBAR -->
    <div style="width:230px; background:#1b5e20; min-height:100vh; padding:20px 0;">

        <ul class="nav flex-column px-3">
            <li class="nav-item mb-3">
                <a href="admin.jsp" class="nav-link text-white fw-semibold">
                    <i class="fa fa-dashboard me-2"></i> Dashboard
                </a>
            </li>

            <li class="nav-item mb-3">
                <a href="addProduct.jsp" class="nav-link text-white" >
                    <i class="fa fa-plus-square me-2"></i> Add Product
                </a>
            </li>

            <li class="nav-item mb-3">
                <a href="manageCategories.jsp" class="nav-link text-white">
                    <i class="fa fa-list me-2"></i> Category
                </a>
            </li>

            <li class="nav-item mb-3">
                <a href="viewProducts.jsp" class="nav-link text-white">
                    <i class="fa fa-book me-2"></i> View Products
                </a>
            </li>

            <li class="nav-item mb-3">
                <a href="orders.jsp" class="nav-link text-white">
                    <i class="fa fa-shopping-bag me-2"></i> Orders
                </a>
            </li>

            <li class="nav-item mb-3">
                <a href="manageUsers.jsp" class="nav-link text-white">
                    <i class="fa fa-users me-2"></i> Users
                </a>
            </li>

            <li class="nav-item mb-3">
                <a href="addAdmin.jsp" class="nav-link text-white">
                    <i class="fa fa-user-plus me-2"></i> Add Admin
                </a>
            </li>
        </ul>
    </div>

    <!-- MAIN CONTENT AREA -->
    <div class="container py-4" style="flex-grow:1;">

        <h2 class="fw-bold mb-4">Admin Dashboard</h2>

        <!-- OPTION CARDS -->
        <div class="row g-4">

            <!-- ADD PRODUCT -->
            <div class="col-md-4">
                <a class="text-decoration-none">
                    <div class="card shadow-sm p-4 text-center dash-card" data-bs-toggle="modal" data-bs-target="#add-product-modal">
                        <i class="fa fa-plus-circle fa-3x mb-2" style="color:#43a047;"></i>
                        <h5 class="fw-bold text-dark">Add Product</h5>
                    </div>
                </a>
            </div>

            <!-- CATEGORY -->
            <div class="col-md-4">
                <a class="text-decoration-none">
                    <div class="card shadow-sm p-4 text-center dash-card" data-bs-toggle="modal" data-bs-target="#add-category-modal">
                        <i class="fa fa-tags fa-3x mb-2" style="color:#43a047;"></i>
                        <h5 class="fw-bold text-dark"> Add Category</h5>
                    </div>
                </a>
            </div>

            <!-- VIEW PRODUCTS -->
            <div class="col-md-4">
                <a href="viewProducts.jsp" class="text-decoration-none">
                    <div class="card shadow-sm p-4 text-center dash-card">
                        <i class="fa fa-box-open fa-3x mb-2" style="color:#43a047;"></i>
                        <h5 class="fw-bold text-dark">View Product</h5>
                    </div>
                </a>
            </div>

            <!-- ORDERS -->
            <div class="col-md-4">
                <a href="orders.jsp" class="text-decoration-none">
                    <div class="card shadow-sm p-4 text-center dash-card">
                        <i class="fa fa-shopping-cart fa-3x mb-2" style="color:#43a047;"></i>
                        <h5 class="fw-bold text-dark">Orders</h5>
                    </div>
                </a>
            </div>

            <!-- USERS -->
            <div class="col-md-4">
                <a href="manageUsers.jsp" class="text-decoration-none">
                    <div class="card shadow-sm p-4 text-center dash-card">
                        <i class="fa fa-users fa-3x mb-2" style="color:#43a047;"></i>
                        <h5 class="fw-bold text-dark">Users</h5>
                    </div>
                </a>
            </div>

        </div>

        <style>
        .dash-card {
            border-radius: 14px;
            transition: all 0.25s ease-in-out;
            background: #ffffff;
        }
        .dash-card:hover {
            transform: translateY(-6px);
            box-shadow: 0 8px 20px rgba(0,0,0,0.15);
        }
        </style>
</body>
<br>
<br>

<!-- add category Modal -->
<div class="modal fade" id="add-category-modal" tabindex="-1" aria-labelledby="myModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-lg">
    <div class="modal-content">

      <div class="modal-header custom-header" >
        <h5 class="modal-title" id="myModalLabel">Fill Category Details</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>

      <div class="modal-body" >
         <form action="AddCategoryServlet" method="POST">
           <div class="form-group">
            <input type="text" class="form-control" name="catTitle" placeholder="Enter category title" required/>
            </div>
            <br>
            <div class="form-group">
            <textarea style="height : 250px" class="form-control" name="catDescription" placeholder="Enter category description" required></textarea>
            </div>
            <br>
            <div class="container text-center">
              <button type="submit" class="btn btn-outline-success" name="submit">Add Category</button>
               <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
             </div>
         </form>
      </div>
    </div>
  </div>
</div>

<!-- add vegetable Modal -->
<div class="modal fade" id="add-product-modal" tabindex="-1" aria-labelledby="myModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-lg">
    <div class="modal-content">

      <div class="modal-header custom-header" >
        <h5 class="modal-title" id="myModalLabel">Fill Product Details</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>

      <div class="modal-body">
         <form action="AddProductServlet" method="POST" enctype="multipart/form-data">
           <div class="form-group">
            <input type="text" class="form-control" name="proTitle" placeholder="Enter title" required/>
            </div>
            <br>
            <div class="form-group">
            <textarea style="height : 150px" class="form-control" name="proDescription" placeholder="Enter description" required></textarea>
            </div>
            <br>
            <%
            CategoryService cs= new CategoryServiceImpl();
            List<Category> catList = cs.getCategory();
            %>

            <select class="form-select" class="form-control" name="categoryOption" required>
              <option value="" selected>Select Category</option>
              <%
              for(Category c : catList) {
              %>
              <option value="<%= c.getCategoryId() %>">
              <%= c.getCategoryName() %>
              </option>
              <% } %>
            </select>
            <br>
            <div class="form-group">
              <input type="number" class="form-control" name="proPrice" placeholder="Enter Price" required/>
            </div>
            <br>
            <div class="form-group">
              <input type="number" class="form-control" name="proStock" placeholder="Stock" required/>
            </div>
            <br>
            <div class="form-group">
             <input type="number" class="form-control" name="proDis" placeholder="Enter Discount" required/>
             </div>
             <br>
            <input class="form-control" type="file" name="pPic" accept="image/*" required>
             <br>
            <div class="container text-center">
             <button class="btn btn-outline-primary">Submit</button>
             </div>
         </form>
      </div>

    </div>
  </div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
