<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="com.aadhar_management_system.dao.UserDAOImpl"%>
<%@ page import="com.aadhar_management_system.dto.UserDTO"%>
<%@ page import="com.aadhar_management_system.service.*" %>
<%@ page import="java.io.PrintWriter" %>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Registration Page</title>
<!-- Bootstrap CSS -->
<link
	href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css"
	rel="stylesheet">
<style>
body {
	background-size: cover;
	background-position: center;
	height: 100vh;
}
</style>
	<script type="text/javascript" src="javascript/jquery.js"></script>
	<script type="text/javascript" src="javascript/Update.js"></script>
</head>
<body>

	<%
		String userId = request.getParameter("userId");
		
		int id = Integer.parseInt(userId); 
		UserService userService = new UserServiceImpl();

		UserDTO userDTO = new UserDTO();
		userDTO = userService.getUserById(id);
	%>

	<div class="row justify-content-center">
		<div class="col-md-6">
			<div class="card mt-5">
				<div class="card-header">
					<h2 class="text-center">Updatation Form</h2>
				</div>
				<div class="card-body">
					<form enctype="multipart/form-data">
					<input type="hidden" value="update" name="method">
						<input type="hidden" id="id1" name="id" value="<%=id%>">
						<div class="form-group">
							<label for="firstname">First Name</label> <input type="text"
								class="form-control" id="firstname" name="fname"
								value="<%=userDTO.getFname()%>"> 
						</div>
						<div class="form-group">
							<label for="lastname">Last Name</label> <input type="text"
								class="form-control" id="lastname" name="lname"
								value="<%=userDTO.getLname()%>"> 
						</div>
						<div class="form-group">
							<label for="email">Email</label> <input type="email"
								class="form-control" id="email" name="email"
								value="<%=userDTO.getEmail()%>"> 
						</div>
						<div class="form-group">
							<label for="dob">Date Of Birth</label> <input type="date"
								class="form-control" id="dob" name="dateOfBirth"
								value="<%=userDTO.getDateOfBirth()%>">
						</div>
						<div class="form-group">
							<label for="password">Password</label> <input type="password"
								class="form-control" id="password" name="pass"
								value="<%=userDTO.getPass()%>"> <input type="checkbox"
								onclick="showPassword()">&nbsp;Show Password 
						</div>
						<div class="form-group">
							<label>Gender</label><br>
							<div class="form-check form-check-inline">
								<input class="form-check-input" type="radio" name="gender"
									id="male" value="male"
									<%if (userDTO.getGender().equals("male")) {%> checked <%}%>
									required> <label class="form-check-label" for="male">Male</label>
							</div>
							<div class="form-check form-check-inline">
								<input class="form-check-input" type="radio" name="gender"
									id="female" value="female"
									<%if (userDTO.getGender().equals("female")) {%> checked <%}%>
									required> <label class="form-check-label" for="female">Female</label>
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
							Select Image :<input type="file" name="image" id = "upload_file" onchange ="getImagePreview(event)">
							<div id= "preview"> <img style="width: 90px !important;"
								src="<%=request.getContextPath()%>/images/<%=userDTO.getImageFileName()%>"></div>
							
						</div> 
						
						<div class="text-center mt-3">
							<button type="submit" class="btn btn-outline-primary">Update</button>
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>


	<!-- Bootstrap JS -->
	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
	<script
		src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>