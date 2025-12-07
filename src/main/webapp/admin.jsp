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
<%
     CategoryService cs= new CategoryServiceImpl();
     List<Category> catList = cs.getCategory();
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <title>Admin Dashboard | VegMart</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" />
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet" />

    <style>
        body {
            background-color: #eaffea;
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
<%@ include file="components/common/header.jsp" %>
<div style="background:#eaffea; min-height:100vh; padding-top:10px;">


<!-- SIDEBAR + CONTENT WRAPPER -->
<div class="d-flex">

    <!-- SIDEBAR -->
    <div style="width:230px; background:#1b5e20; min-height:120vh; padding:20px 0;">

        <ul class="nav flex-column px-3">
            <li class="nav-item mb-3">
                <a href="admin.jsp" class="nav-link text-white fw-semibold">
                    <i class="fa fa-dashboard me-2"></i> Dashboard
                </a>
            </li>

            <li class="nav-item mb-3">
                <a href="#" class="nav-link text-white" data-bs-toggle="modal" data-bs-target="#add-product-modal">
                    <i class="fa fa-plus-square me-2"></i> Add Product
                </a>
            </li>

            <li class="nav-item mb-3">
                <a href="#" class="nav-link text-white" data-bs-toggle="modal" data-bs-target="#add-category-modal">
                    <i class="fa fa-list me-2"></i> Add Category
                </a>
            </li>

            <li class="nav-item mb-3">
                <a href="viewProducts.jsp" class="nav-link text-white">
                    <i class="fa fa-book me-2"></i> View Products
                </a>
            </li>

            <li class="nav-item mb-3">
                <a href="admin_orders.jsp" class="nav-link text-white">
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
            <li class="nav-item mb-3">
               <a href="profile.jsp" class="nav-link text-white">
                 <i class="fa fa-user-circle me-2"></i> Profile
                </a>
            </li>

            <li class="nav-item mb-3">
                <a href="LogoutServlet" class="nav-link text-white">
                  <i class="fa fa-sign-out me-2"></i> Logout
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
                <a href="admin_orders.jsp" class="text-decoration-none">
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

             <!-- Add Admin -->
                        <div class="col-md-4">
                            <a href="addAdmin.jsp" class="text-decoration-none">
                                <div class="card shadow-sm p-4 text-center dash-card">
                                    <i class="fa fa-user-plus fa-3x mb-2" style="color:#43a047;"></i>
                                    <h5 class="fw-bold text-dark">Add Admin</h5>
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
         <form action="AddCategoryServlet" method="POST" enctype="multipart/form-data">
           <div class="form-group">
            <input type="text" class="form-control" name="catTitle" placeholder="Enter category title" required/>
            </div>
            <br>
            <div class="form-group">
            <textarea style="height : 250px" class="form-control" name="catDescription" placeholder="Enter category description" required></textarea>
            </div>
            <br>
             <input class="form-control" type="file" name="cImage" accept="image/*" required>
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
             <button class="btn btn-outline-success">Submit</button>&nbsp;&nbsp;
             <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
             </div>
         </form>
      </div>

    </div>
  </div>
</div>
</body>
</div>
