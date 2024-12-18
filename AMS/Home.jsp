<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!doctype html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>AMS</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" >
  	<link href="css/Home.css" rel="stylesheet">
  </head>
  <body>
  <!-- Navbar -->
	<nav class="navbar navbar-expand-lg fixed-top">
		<div class="container-fluid">
			<a class="navbar-brand me-auto" href="">AMS</a>
			<div class="offcanvas offcanvas-end" tabindex="-1"
				id="offcanvasNavbar" aria-labelledby="offcanvasNavbarLabel">
				<div class="offcanvas-header">
					<h5 class="offcanvas-title" id="offcanvasNavbarLabel">AMS</h5>
					<button type="button" class="btn-close" data-bs-dismiss="offcanvas"
						aria-label="Close"></button>
				</div>
				<div class="offcanvas-body">
					<ul class="navbar-nav justify-content-center flex-grow-1 pe-3">
						<li class="nav-item"><a class="nav-link mx-lg-2 active"
							aria-current="page" href="#">Home</a></li>
						<li class="nav-item"><a class="nav-link mx-lg-2" href="#">About</a>
						</li>
						<li class="nav-item"><a class="nav-link mx-lg-2" href="#">Services</a>
						</li>
						<li class="nav-item"><a class="nav-link mx-lg-2" href="#">Contact</a>
						</li>
					</ul>
				</div>
			</div>
			<a class="register-button" data-bs-toggle="modal" data-bs-target="#register">Register</a><br>
			<a class="login-button" data-bs-toggle="modal" data-bs-target="#login">Login</a>
			<button class="navbar-toggler pe-0" type="button" data-bs-toggle="offcanvas" data-bs-target="#offcanvasNavbar" aria-controls="offcanvasNavbar" aria-label="Toggle navigation">
				<span class="navbar-toggler-icon"></span>
			</button>
		</div>
	</nav>
	<section class="hero-section">
		<div class="container d-flex align-items-center justify-content-center fs-1 text-white flex-column">
			<h2>Welcome to Aadhar Management System </h2>
			<h3 >Key Features</h3>
        <ul id="ul" style="max-width: 500px;"> 
            <li >User Registration</li>
            <li >User Authentication</li>
            <li >Data Entry and Update</li>
            <li >Data Retrieval</li>
            <li >Administrative Tools</li>
        </ul>
		</div>
	</section>

<!-- Modal for login-->
<div class="modal fade" id="login" tabindex="-1" aria-labelledby="loginModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h1 class="modal-title fs-5" id="exampleModalLabel">Login</h1>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
      <form class="form-signin">
     <div class="text-center">
     	 <img class="mb-4" src="images/login.jpg" alt="" width="80" height="80">
     	 <h1 class="h3 mb-3 font-weight-normal">Please Login</h1>
     </div>
      
      <input type="hidden" value="login"  id="method" name="method">
	
	  <label for="inputEmail" class="sr-only">Email address</label>
      <input type="email" id="lemail" class="form-control" placeholder="Email address" name="email"required >
      <label for="inputPassword" class="sr-only">Password</label>
      <input type="password" id="lpassword" class="form-control" placeholder="Password" name="pass" required>
      <div class="checkbox mb-3">
        <label>
          <input type="checkbox" value="remember-me" onclick="showPasswordl()"> Show Password
        </label>
      </div>
        <!-- <div>
		<label>Login As :</label> <br> 
		<select name="role" id="roleSelect" style="width: 130px">
			<option value="1">Admin</option>
			<option value="2">Junior</option>
			<option value="3">User</option>
		</select>
	  </div> -->
     
      <p class="mt-5 mb-3 text-muted">&copy; Kaldin Solutions</p>
    </form>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-lg btn-secondary" data-bs-dismiss="modal">Close</button>
        <button class="btn btn-lg btn-primary btn-block" id="submit" type="submit">Login</button>
      </div>
    </div>
  </div>
</div>
<!-- login model end -->

<!-- Modal for register-->
<div class="modal fade" id="register" tabindex="-1" aria-labelledby="loginModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h1 class="modal-title fs-5" id="exampleModalLabel">Register</h1>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
      <form id="register_form" enctype="multipart/form-data">
					<div class="text-center">
						<h1 class="h3 mb-3 font-weight-normal">Please Register</h1>
					</div>
						<div class="form-group">
						<input type="hidden" value="insert" name="method">
							<label for="firstname">First Name</label> <input type="text"
								class="form-control" id="firstname" name="fname">
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
								<input class="form-check-input" type="radio" name="gender" id="male" value="male" checked>
								<label class="form-check-label" for="male">Male</label>
							</div>
							<div class="form-check form-check-inline">
								<input class="form-check-input" type="radio" name="gender" id="female" value="female">
							    <label class="form-check-label" for="female">Female</label>
							</div>
						</div>
						<div id="menu-container" class="form-group">
							<label>Country :</label> <br> 
							<select name="country" style="width: 130px">
								<option value="" disabled selected hidden="hidden">Select Country</option>
								<option selected="selected">India</option>
								<option>USA</option>
								<option>US</option>
								<option>Germany</option>
							</select>&nbsp; 
							<label>Register As :</label> <br> 
							<select name="role" style="width: 130px">
								<option value="" disabled selected hidden="hidden">Select Role</option>
								<option value="3" selected="selected">User</option>
							</select>
						</div>
						<div>
							Select Image :<input type="file" name="image" id="upload_file"
								onchange="getImagePreview(event)">
						</div>
						<div id="preview"></div>
						   <p class="mt-5 mb-3 text-muted">&copy; Kaldin Solutions</p>
					</form>
	 	 </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-lg btn-secondary" data-bs-dismiss="modal">Close</button>
        <button class="btn btn-lg btn-success btn-block" id="register_form_submit"  type="submit">Register</button>
      </div>
    </div>
  </div>
</div>
	<script type="text/javascript">var contextPath = '<%=request.getContextPath()%>'; </script>
	<script type="text/javascript" src="javascript/jquery.js"> </script>
  	<script type="text/javascript" src="javascript/Home.js"></script>
	<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js"></script>
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
  </body>
</html>