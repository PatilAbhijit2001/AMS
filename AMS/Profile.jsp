<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.aadhar_management_system.dao.UserDAOImpl"%>
<%@ page import="com.aadhar_management_system.dto.UserDTO"%>
<%@ page import="com.aadhar_management_system.service.*" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Profile</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="css/Profile.css">
</head>
<body>
	<%
		response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
		if(session.getAttribute("userName")== null){
			response.sendRedirect("Home.jsp");
		} else {
		String name = (String) session.getAttribute("userName");
		int role = (int) session.getAttribute("userRole");
		int id = (int) session.getAttribute("id");
		UserService userService = new UserServiceImpl();
     	UserDTO userDTO = new UserDTO();
		userDTO = userService.getUserById(id);
	%>
	 <%if (role == 1){ %>
<nav class="navbar navbar-expand-lg navbar-light "style="background-color: #e3f2fd;">
        <div class="container-fluid">
            <a class="navbar-brand" href="">AMS</a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav"  aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse justify-content" id="navbarNav">
				<ul class="navbar-nav">
					<li class="nav-item">
					&nbsp;&nbsp;<button id="userDetailsButton" type="submit" data-id="selectAllUsers" class="btn btn-primary">User Details</button>
					</li>
					<li class="nav-item">
					&nbsp;&nbsp;<a class="btn btn-primary" aria-current="page" href="<%=request.getContextPath()%>/Profile.jsp">Profile</a>
					</li>
					<li class="nav-item">
                    &nbsp;&nbsp;<button class="btn btn-primary" id="addJunior" data-bs-toggle="modal" data-bs-target="#registerJunior">Add Junior</button>
                    </li>
					<li class="nav-item">
					&nbsp;&nbsp;<button type="submit" id="logoutButton" class="btn btn-danger">Logout</button>
					</li>
				</ul>
			</div>
       </div>
</nav> 
	<div class="text-center">
		<h2 id="greet"> Welcome Administrator: <%=name%></h2>
	</div>
		<div class="row justify-content-center">
		<div class="col-md-6">
			<div class="card mt-5">
				<div class="card-header">
					<h3 class="text-center">Update Details</h3>
				</div>
				<div class="card-body">
					<form action="#" method="post" id="update" enctype="multipart/form-data">
						<input type="hidden" value="update" name="method">
						<input type="hidden" id="id1" name="id" value="<%=id%>">
						<div class="form-group">
							<label for="firstname">First Name</label> <input type="text" class="form-control" id="firstname" name="fname" value="<%=userDTO.getFname()%>">
						</div>
						<div class="form-group">
							<label for="lastname">Last Name</label> 
							<input type="text" class="form-control" id="lastname" name="lname" value="<%=userDTO.getLname()%>">
						</div>
						<div class="form-group">
							<label for="email">Email</label> 
							<input type="email" class="form-control" id="email" name="email" value="<%=userDTO.getEmail()%>">
						</div>
						<div class="form-group">
							<label for="dob">Date Of Birth</label>
							<input type="date" class="form-control" id="dob" name="dateOfBirth" value="<%=userDTO.getDateOfBirth()%>">
						</div>
						<div class="form-group">
							<label for="password">Password</label>
							<input type="password" class="form-control" id="password" name="pass" value="<%=userDTO.getPass()%>"> 
							<input type="checkbox" onclick="showPassword()">&nbsp; Show Password
						</div>
						<div class="form-group">
							<label>Gender</label>
						<br>
						<div class="form-check form-check-inline">
							<input class="form-check-input" type="radio" name="gender" id="male" value="male" <%if (userDTO.getGender().equals("male")) {%> checked <%}%> required> 
							<label class="form-check-label" for="male">Male</label>
						</div>
						<div class="form-check form-check-inline">
							<input class="form-check-input" type="radio" name="gender" id="female" value="female" <%if (userDTO.getGender().equals("female")) {%> checked <%}%> required> 
							<label class="form-check-label" for="female">Female</label>
						</div>
						</div>
						<div>
							<label>Country :</label> <br> <select name="country" style="width: 150px">
								<option <%if (userDTO.getCountry().equals("India")) {%> selected="selected" <%}%>>India</option>
								<option <%if (userDTO.getCountry().equals("USA")) {%> selected="selected" <%}%>>USA</option>
								<option <%if (userDTO.getCountry().equals("US")) {%> selected="selected" <%}%>>US</option>
								<option <%if (userDTO.getCountry().equals("Germany")) {%> selected="selected" <%}%>>Germany</option>
							</select>
						</div>
						<div>
							<input type="hidden" value="<%= userDTO.getRole() %>" name="role">
						</div>
						<br>
						<div>
							Select Image :
							<input type="file" name="image" id="upload_file" onchange="getImagePreview(event)">
							<div id="preview">
								<img style="width: 90px !important;" src="<%=request.getContextPath()%>/images/<%=userDTO.getImageFileName()%>">
							</div>
						</div>
						<div class="text-center mt-3">
							<button type="submit" class="btn btn-outline-primary">Update</button>
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>

	<%
	} else if (role == 2) {
	%>
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
					&nbsp;&nbsp;<button id="juniorUserDetailsButton" type="submit" data-id="<%=id%>" class="btn btn-primary">User Details</button> 
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
	<div class="text-center">
		<h2 id="greet"> Welcome Junior: <%=name%></h2>
	</div>
		<div class="row justify-content-center">
		<div class="col-md-6">
			<div class="card mt-5">
				<div class="card-header">
					<h3 class="text-center">Update Details</h3>
				</div>
				<div class="card-body">
					<form action="#" method="post" id="update" enctype="multipart/form-data">
						<input type="hidden" value="update" name="method">
						<input type="hidden" id="id1" name="id" value="<%=id%>">
						<div class="form-group">
							<label for="firstname">First Name</label> <input type="text" class="form-control" id="firstname" name="fname" value="<%=userDTO.getFname()%>">
						</div>
						<div class="form-group">
							<label for="lastname">Last Name</label> 
							<input type="text" class="form-control" id="lastname" name="lname" value="<%=userDTO.getLname()%>">
						</div>
						<div class="form-group">
							<label for="email">Email</label> 
							<input type="email" class="form-control" id="email" name="email" value="<%=userDTO.getEmail()%>">
						</div>
						<div class="form-group">
							<label for="dob">Date Of Birth</label>
							<input type="date" class="form-control" id="dob" name="dateOfBirth" value="<%=userDTO.getDateOfBirth()%>">
						</div>
						<div class="form-group">
							<label for="password">Password</label>
							<input type="password" class="form-control" id="password" name="pass" value="<%=userDTO.getPass()%>"> 
							<input type="checkbox" onclick="showPassword()">&nbsp; Show Password
						</div>
						<div class="form-group">
							<label>Gender</label><br>
							<div class="form-check form-check-inline">
								<input class="form-check-input" type="radio" name="gender" id="male" value="male"
									<%if (userDTO.getGender().equals("male")) {%> checked <%}%> required> 
								<label class="form-check-label" for="male">Male</label>
							</div>
							<div class="form-check form-check-inline">
								<input class="form-check-input" type="radio" name="gender" id="female" value="female"
									<%if (userDTO.getGender().equals("female")) {%> checked <%}%> required> 
								<label class="form-check-label" for="female">Female</label>
							</div>
						</div>
						<div>
							<label>Country :</label> <br> <select name="country"
								style="width: 150px">

								<option <%if (userDTO.getCountry().equals("India")) {%>
									selected="selected" <%}%>>India</option>
								<option <%if (userDTO.getCountry().equals("USA")) {%>
									selected="selected" <%}%>>USA</option>
								<option <%if (userDTO.getCountry().equals("US")) {%>
									selected="selected" <%}%>>US</option>
								<option <%if (userDTO.getCountry().equals("Germany")) {%>
									selected="selected" <%}%>>Germany</option>
							</select>
						</div>
						<div>
							<input type="hidden" value="<%= userDTO.getRole() %>" name="role">
						</div>
						<br>
						<div>
							Select Image :
							<input type="file" name="image" id="upload_file" onchange="getImagePreview(event)">
							<div id="preview">
								<img style="width: 90px !important;" src="<%=request.getContextPath()%>/images/<%=userDTO.getImageFileName()%>">
							</div>
						</div>
						<div class="text-center mt-3">
							<button type="submit" class="btn btn-outline-primary">Update</button>
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>
	<%} else { %>
	<nav class="navbar navbar-expand-lg navbar-light "
		style="background-color: #e3f2fd;">
		<div class="container-fluid">
			<a class="navbar-brand" href="">AMS</a>
			<button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
				<span class="navbar-toggler-icon"></span>
			</button>
			<div class="collapse navbar-collapse justify-content" id="navbarNav">
				<ul class="navbar-nav">
					<li class="nav-item">
					&nbsp;&nbsp;<a class="btn btn-primary"  aria-current="page" href="<%=request.getContextPath()%>/User_documents.jsp">Upload Documents</a>
					</li>
					<li class="nav-item">
					&nbsp;&nbsp;<a class="btn btn-primary" id="profile" aria-current="page" href="<%=request.getContextPath()%>/Profile.jsp">Profile</a>
					</li>
					<li class="nav-item">
					&nbsp;&nbsp;<button type="submit" id="logoutButton" class="btn btn-danger">Logout</button>
					</li>
				</ul>
			</div>
		</div>
	</nav>
	<div class="text-center">
		<h2 id="greet"> Welcome User: <%=name%></h2>
	</div>
	<div>
	<div class="row justify-content-center">
		<div class="col-md-4">
			<div class="card mt-5">
				<div class="card-header">
					<h3 class="text-center">Update Details</h3>
				</div>
				<div class="card-body">
					<form action="#" method="POST" id="update" enctype="multipart/form-data">
						<input type="hidden" value="update" name="method">
						<input type="hidden" id="id1" name="id" value="<%=id%>">
						<label for="firstname">First Name</label> 
						<input type="text" class="form-control" id="firstname" name="fname" value="<%=userDTO.getFname()%>">
						<label for="lastname">Last Name</label> 
						<input type="text" class="form-control" id="lastname" name="lname" value="<%=userDTO.getLname()%>">
						<label for="email">Email</label> 
						<input type="email" class="form-control" id="email" name="email" value="<%=userDTO.getEmail()%>">
						<label for="dob">Date Of Birth</label>
						<input type="date" class="form-control" id="dob" name="dateOfBirth" value="<%=userDTO.getDateOfBirth()%>">
						<label for="password">Password</label>
						<input type="password" class="form-control" id="password" name="pass" value="<%=userDTO.getPass()%>"> 
						<input type="checkbox" onclick="showPassword()">&nbsp; Show Password
						<br>
						<label>Gender</label><br>
						<div class="form-check form-check-inline">
							<input class="form-check-input" type="radio" name="gender" id="male" value="male"
							<%if (userDTO.getGender().equals("male")) {%> checked <%}%> required> 
							<label class="form-check-label" for="male">Male</label>
						</div>
						<div class="form-check form-check-inline">
							<input class="form-check-input" type="radio" name="gender" id="female" value="female"
							<%if (userDTO.getGender().equals("female")) {%> checked <%}%> required> 
							<label class="form-check-label" for="female">Female</label>
						</div>
						<div>
							<label>Country :</label> <br> 
							<select name="country" style="width: 150px">
								<option <%if (userDTO.getCountry().equals("India")) {%>
									selected="selected" <%}%>>India</option>
								<option <%if (userDTO.getCountry().equals("USA")) {%>
									selected="selected" <%}%>>USA</option>
								<option <%if (userDTO.getCountry().equals("US")) {%>
									selected="selected" <%}%>>US</option>
								<option <%if (userDTO.getCountry().equals("Germany")) {%>
									selected="selected" <%}%>>Germany</option>
							</select>
						</div>
							<input type="hidden" value="<%= userDTO.getRole() %>" name="role">
						<br>
						<div>
							Select Image :
							<input type="file" name="image" id="upload_file" onchange="getImagePreview(event)">
							<div id="preview">
								<img style="width: 90px !important;" src="<%=request.getContextPath()%>/images/<%=userDTO.getImageFileName()%>">
							</div>
						</div>
						<div class="text-center mt-3">
							<button type="submit" class="btn btn-outline-primary">Update</button>
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>
	</div>
	<%}%>
	<%}%>
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

	<script src="javascript/jquery.js"></script>
	<script src="javascript/SessionCheck.js"></script>
	<script src="javascript/Profile.js"></script>
	<script src="javascript/juniorProfile.js"></script>
	<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js"></script>
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>