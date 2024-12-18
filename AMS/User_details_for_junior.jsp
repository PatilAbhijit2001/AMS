<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.aadhar_management_system.dto.UserDTO"%>
<%@ page import="java.util.List"%>
<%@ page import="java.util.*"%>
<%@ page import="com.aadhar_management_system.dao.UserDAOImpl"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>User Details For Juniors</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous"><link rel="stylesheet" href="css/AllUserDetails.css">
<link rel="stylesheet" href="https://cdn.datatables.net/2.0.0/css/dataTables.dataTables.css" />
</head>
<body>
<!-- nav bar starts here -->

	<nav class="navbar navbar-expand-lg navbar-light "style="background-color: #e3f2fd;">
        <div class="container-fluid">
            <a class="navbar-brand" href="">AMS</a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav"
                aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse justify-content" id="navbarNav">
                <ul class="navbar-nav">
                    <li class="nav-item">
					&nbsp;&nbsp;<button id="juniorUserDetailsButton" type="submit" data-id="" class="btn btn-primary">User Details</button> 
					</li>
					<li class="nav-item">
					&nbsp; &nbsp;<a class="btn btn-primary" href="<%=request.getContextPath()%>/Profile.jsp">Profile </a>
					</li>
					<li class="nav-item">
                    &nbsp;&nbsp;<button type="submit" id="logoutButton" class="btn btn-danger">Logout</button>
                    </li>
                </ul>
            </div>
        </div>
 </nav> 
	<%response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate"); 
                		if(session.getAttribute("userName")== null){
						response.sendRedirect("Home.jsp"); } else { %>

	<div class="container">
		<table class="table table-bordered table-hover" id="user_records"> </table>
	</div>
	<!-- modal for update -->
	<div class="modal fade" id="register" tabindex="-1" aria-labelledby="loginModalLabel" aria-hidden="true">
  	<div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h1 class="modal-title fs-5" id="exampleModalLabel">Register</h1>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
      <form id="update_form" enctype="multipart/form-data">
					<div class="text-center">
						<h1 class="h3 mb-3 font-weight-normal">Please Register</h1>
					</div>
						<div class="form-group">
						<input type="hidden" value="" name="id" id= "id">
							<label for="firstname">First Name</label>
							<input type="text" class="form-control" id="firstname" name="fname">
						</div>
						<div class="form-group">
							<label for="lastname">Last Name</label> <input type="text"
								class="form-control" id="lastname" name="lname">
						</div>
						<div class="form-group">
							<label for="email">Email</label> <input type="email"
								class="form-control" id="email" name="email">
						</div>
						<div class="form-group">
							<label for="dob">Date Of Birth</label> <input type="date"
								class="form-control" id="dob" name="dateOfBirth">
						</div>
						<div id= "rpassword" class="form-group">
							<label for="password">Password</label> 
							<input type="password" class="form-control" id="password" name="pass"> 
							<input type="checkbox" onclick="showPassword()"> 
							<label>&nbsp; Show Password</label>
						</div>
						<div id="rgender" class="form-group">
							<label>Gender</label><br>
							<div class="form-check form-check-inline">
								<input class="form-check-input" type="radio" name="gender" id="male" value="male" >
								<label class="form-check-label" for="male">Male</label>
							</div>
							<div class="form-check form-check-inline">
								<input class="form-check-input" type="radio" name="gender" id="female" value="female">
							    <label class="form-check-label" for="female">Female</label>
							</div>
						</div>
						<div id="menu-container" class="form-group">
							<label>Country :</label> <br> 
							<select name="country" id="countrySelect" style="width: 130px">
								<option>India</option>
								<option>USA</option>
								<option>US</option>
								<option>Germany</option>
							</select>
							&nbsp; &nbsp;
							<br> 
							<label>Register As :</label> <br> 
							<select name="role" id="roleSelect" style="width: 130px">
								<option value="2" >Junior</option>
								<option value="3">User</option>
							</select>
						</div>
						<div>
							Select Image :
							<input type="file" name="image" id="upload_file" onchange="getImagePreview(event)">
							<div id="preview">
								<img style="width: 90px !important;" id="dImg" src="">
							</div>
						</div>
						<p class="mt-5 mb-3 text-muted">&copy; Kaldin Solutions</p>
					</form>
	  </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-lg btn-secondary" data-bs-dismiss="modal">Close</button>
        <button type="button" id="update_user" class="btn btn-lg btn-success btn-block" >Update</button>
      </div>
    </div>
  </div>
</div>
<%} %>

<!-- modal for session timeout -->
	<div class="modal fade" id="sessionTimeout" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
		<div class="modal-dialog modal-dialog-centered">
			<div class="modal-content" >
				<div class="modal-header text-center" >
					<h1  class="modal-title fs-5" id="staticBackdropLabel">Session Timeout</h1>
				</div>
				<div class="modal-body" style="text-align :center">
					<p>Your session has timed out due to inactivity, Login Again .</p>
					<button class="btn btn-primary" id="ok-button">OK</button>
				</div>
			</div>
		</div>
	</div>
<script type="text/javascript">var contextPath = '<%=request.getContextPath()%>' </script>
<script src="javascript/jquery.js"></script>
<script src="javascript/Delete.js"></script>
<script src="javascript/SessionCheck.js"></script>

<script src="javascript/user_details_for_junior.js"></script>
<script src="https://cdn.datatables.net/2.0.0/js/dataTables.js"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>