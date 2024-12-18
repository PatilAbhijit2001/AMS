<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Upload Documents</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" >
<link href="css/User_documents.css" rel="stylesheet">
</head>
<body>
	<nav class="navbar navbar-expand-lg navbar-light "
		style="background-color: #e3f2fd;">
		<div class="container-fluid">
			<a class="navbar-brand" href="">AMS</a>
			<button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false"	aria-label="Toggle navigation">
				<span class="navbar-toggler-icon"></span>
			</button>
			<div class="collapse navbar-collapse justify-content" id="navbarNav">
				<ul class="navbar-nav">
					<li class="nav-item">
							&nbsp;&nbsp;<button type="submit" name="userId" value="" id="docsButton" class="btn btn-primary">Upload Documents</button>
						</li>
					<li class="nav-item">
					&nbsp;&nbsp;<a class="btn btn-primary" id="profile" aria-current="page" href="<%=request.getContextPath()%>/Profile.jsp">Profile</a>
						</li>
						<li class="nav-item">
						<form action="#" method="POST" id="logout"> 
 							<input type="hidden" value="logout" name="method"> 
 							&nbsp;&nbsp;<button type="submit" id="logout" class="btn btn-danger">Logout</button> 
						</form> 
					</li>
				</ul>
			</div>
		</div>
	</nav>
		<%response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate"); 
                		if(session.getAttribute("userName")== null){
						response.sendRedirect("Home.jsp"); } else { %>
<div class="row justify-content-center">
	<div class="col-md-6">
    <div class="card mt-5">
      <div class="card">
        <div class="card-body">
          <h2 class="card-title text-center">Welcome To AMS</h2>
          <h5 class="card-text text-center">There are just a few steps to complete your profile.</h5>
          <div class="card" id="bcard">
            <div class="card-body">
              <form action="#" method="POST" id="birth" enctype="multipart/form-data">
                <div id="birthContainer">
                  <h3 class="btext">Birth Certificate</h3>
                  <div id="birthDocument">
                  <input type="file" name="document" id="birth_upload_file" class="form-control" required>
                  <button type="button" id="birthDoc" class="btn btn-primary mt-2">Upload</button>
				  </div>
				  <img style='width: 8% !important; display:none;' id="birthSubmit" src='<%=request.getContextPath() %>/images/submitTick.png'>                  
                </div>
                <h6>Take a photo or scan your birth certificate.</h6>
                  <a href="#" id="modalTrigger1" style='display:none;'>View Document</a>
              </form>
            </div>
          </div>
          <div class="card" id="bcard">
            <div class="card-body">
              <form action="#" method="POST" id="poa" enctype="multipart/form-data">
                <div id="birthContainer">
                  <h3>Proof Of Address</h3>
                  <div id="poaDocument">
                  <input type="file" name="document" id="proof_of_address" class="form-control" required>
                  <button type="button" id="poaDoc" class="btn btn-primary mt-2">Upload</button>
                  </div>
                  <img style='width: 8% !important; display:none;' id="poaSubmit" src='<%=request.getContextPath() %>/images/submitTick.png'>
                </div>
                <h6>Take a photo or scan your Proof Of Address.</h6>
                 <a href="#" id="modalTrigger2" style='display:none;'>View Document</a>
              </form>
            </div>
          </div>
          <div class="card" id="bcard">
            <div class="card-body">
              <form  action="#" method="POST" id="rc" enctype="multipart/form-data">
                <div id="birthContainer">
                  <h3 class="rcard">Ration Card</h3>
                  <div id="rcDocument">
                    <input type="file" name="document" id="ration_card" class="form-control" required>
                    <button type="button" id="rcDoc" class="btn btn-primary mt-2">Upload</button>
                  </div>
                 <img style='width: 8% !important; display:none;' id="rcSubmit" src='<%=request.getContextPath() %>/images/submitTick.png'>
                </div>
                <h6>Take a photo or scan your Ration Card.</h6>
                <a href="#" id="modalTrigger3" style='display:none;'>View Document</a>
              </form>
            </div>
          </div>
          <div class="card" id="bcard">
            <div class="card-body">
              <form action="#" method="POST" id="sign" enctype="multipart/form-data">
                <div id="birthContainer">
                  <h3 class="stext">Sign</h3>
                  <div id="signDocument"> 
                    <input type="file" name="document" id="sign" class="form-control" required>
                    <button type="button" id="sdoc" class="btn btn-primary mt-2">Upload</button>
                  </div>
                 <img style='width: 8% !important; display:none;' id="signSubmit" src='<%=request.getContextPath() %>/images/submitTick.png'>
                </div>
                <h6>Take a photo or scan your sign.</h6>
                <a href="#" id="modalTrigger4" style='display:none;'>View Document</a>
              </form>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</div> 
 <%}%> 
<div class="modal fade " id="ModalForDoc" tabindex="-1" aria-labelledby="" aria-hidden="true">
  <div class="modal-dialog modal-xl">
    <div class="modal-content" style="height:700px;">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLabel">View Documents</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
              <iframe id="modalIframe" width="100%" height="100%" ></iframe>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
        <button type="button" class="btn btn-primary">Save changes</button>
      </div>
    </div>
  </div>
</div> 

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
<script src="javascript/SessionCheck.js"></script>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" ></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js"></script>
<script src="javascript/User_documents.js"></script>
</body>
</html>