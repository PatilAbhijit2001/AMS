<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>User Details</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="https://cdn.datatables.net/2.0.2/css/dataTables.dataTables.css" />
<link rel="stylesheet" href="css/AllUserDetails.css">
</head>
<body>

	<%response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
	if (session.getAttribute("userName") == null) {
			response.sendRedirect("Home.jsp");
	} else {%>
	<!-- navbar starts here -->	
 <nav class="navbar navbar-expand-lg navbar-light">
        <div class="container-fluid">
            <a class="navbar-brand" href="">AMS</a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav"
                aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse justify-content" id="navbarNav">
                <ul class="navbar-nav">
              		<li class="nav-item">
              		&nbsp;&nbsp;<a class="btn btn-primary" aria-current="page" href="<%=request.getContextPath()%>/AllUserDetails.jsp">User Details</a>
                    </li>
                    <li class="nav-item">
                    &nbsp;&nbsp;<a class="btn btn-primary" aria-current="page" href="<%=request.getContextPath()%>/Profile.jsp">Profile</a>
                    </li>
                    <li class="nav-item">
                    &nbsp;&nbsp;<button class="btn btn-primary" id="addJunior" data-bs-toggle="modal" data-bs-target="#registerJunior">Add Junior</button>
                    </li>
                    <li class="nav-item">
                        <form id="logout" >
                            <input type="hidden" value="logout" name="method">
                            &nbsp;&nbsp;<button type="submit" class="btn btn-danger">Logout</button>
                        </form>
                    </li>
                </ul>
            </div>
        </div>
 </nav> 
    <br>
    <br>
	<div class="container-fluid">
		<form>
			<table class="table table-bordered table-hover" id="records"> </table>
			<div class="container">
				<div class="row">
					<div class="col-md-6">
						<div class="form-group">
							<label for="junior"><h4>Juniors</h4></label>
							<div class="input-group">
								<select id="juniorSelect" class="form-control">
								</select>&nbsp; &nbsp; &nbsp; 
								<div class="input-group-append">
									<button id="selectedUser" type="submit" class="btn btn-success">Assign Selected Users</button>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</form>
	</div>
	<!-- modal for update -->

	<div class="modal fade" id="register" tabindex="-1" aria-labelledby="loginModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h1 class="modal-title fs-5" id="exampleModalLabel">Update Form</h1>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
      <form id="update_form" enctype="multipart/form-data">
					<div class="text-center">
						<h1 class="h3 mb-3 font-weight-normal">Update User Details</h1>
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
						<div style="margin-top: 5%;">
							Select Image : 
							<input type="file" name="image" id="upload_file" onchange="getImagePreview(event)">
							<div id="preview" style="margin-top: 5%;">
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
<!-- modal for new junior -->
	<div class="modal fade" id="registerJunior" tabindex="-1" aria-labelledby="loginModalLabel" aria-hidden="true">
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
								class="form-control" id="jfirstname" name="fname">
						</div>
						<div class="form-group">
							<label for="lastname">Last Name</label> <input type="text"
								class="form-control" id="jlastname" name="lname">
						</div>
						<div class="form-group">
							<label for="email">Email</label> 
							<input type="email" class="form-control" id="juniorEmail" name="email">
						</div>
						<div class="form-group">
							<label for="dob">Date Of Birth</label> 
							<input type="date" class="form-control" id="jdob" name="dateOfBirth">
						</div>
						<div id= "jrpassword" class="form-group">
							<label for="password">Password</label> 
							<input type="password" class="form-control" id="juniorPassword" name="pass"> 
							<input type="checkbox" onclick="showPasswordJunior()"> 
							<label>&nbsp; Show Password</label>
						</div>
						<div id="rgender" class="form-group">
							<label>Gender</label><br>
							<div class="form-check form-check-inline">
								<input class="form-check-input" type="radio" name="gender" id="jmale" value="male" checked>
								<label class="form-check-label" for="male">Male</label>
							</div>
							<div class="form-check form-check-inline">
								<input class="form-check-input" type="radio" name="gender" id="jfemale" value="female">
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
							<label id="menu-item">Register As :</label> <br> 
							<select name="role" style="width: 130px">
								<option value="" disabled selected hidden="hidden">Select Role</option>
								<option value="3" selected="selected">User</option>
								<option value="2">Junior</option>
								<option value="1">Admin</option>
							</select>
						</div>
						<div id="selectImg">
							Select Image :<input type="file" name="image" id="jupload_file"
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
<div class="modal fade " id="ModalForDoc" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-xl">
    <div class="modal-content" style="height:700px;">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLabel">View Documents</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
              <iframe id="modalIframe" width="100%" height="100%" frameborder="0"></iframe>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
        <button type="button" class="btn btn-primary">Save changes</button>
      </div>
    </div>
  </div>
</div>
	<%
	}
	%>
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
<script src="javascript/AllUserDetails.js"></script>
<script src="javascript/SessionCheck.js"></script>
<script src="https://cdn.datatables.net/2.0.0/js/dataTables.js"></script> 
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>