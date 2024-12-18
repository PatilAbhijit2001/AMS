/*for login model*/
function validatelogin() {
	var email = document.getElementById("lemail");
	var password = document.getElementById("lpassword");
	var emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
	var passwordRegex = /^(?=.*\d)[a-zA-Z\d]{8,15}$/;
	if (!emailRegex.test(email.value)) {
		alert("Invalid Email");
		lemail.style.border = "solid 3px #c40404";
		return false;
	}
	else if (!passwordRegex.test(password.value)) {
		alert("Invalid Password");
		lpassword.style.border = "solid 3px #c40404";
		return false;
	}
	else {
		return true;
	}
}

function showPasswordl() {
	var x = document.getElementById("lpassword");
	if (x.type === "password") {
		x.type = "text";
	} else {
		x.type = "password";
	}
}

$(document).ready(function() {
	$('#submit').on('click', function(e) {
		e.preventDefault();
		if (validatelogin()) {
			var email = $('#lemail').val();
			var pass = $('#lpassword').val();
			var method = $('#method').val();
			var role = $('#roleSelect').val();
			$.ajax({
				type: 'POST',
				url: 'AllServletController',
				data: { "email": email, "pass": pass ,"method":method, "role":role},
				success: function(response) {
				var user = JSON.parse(JSON.stringify(response));
					if (user.true === "true") {
						location.href = contextPath + '/Profile.jsp';
					} else {
						alert("Failed login");
					}
				},
			});
		}
	});
	
		
	/*for register model*/
	$('#register_form_submit').on('click',function(e) { 
		e.preventDefault();
		if(validateregister()){
			var formData = new FormData($('#register_form')[0]);

		$.ajax({
			type: 'POST',
			url: 'AllServletController', 
			data: formData,
			enctype: 'multipart/form-data',
			processData: false,
			contentType: false,
			success: function(response) {
				if (response === "true") {
					alert("Registration successful!");
					 $('#register').modal('hide');
     				 $('#login').modal('show');
				} else {
					alert("error occured try agian");
					$('#register').modal('show');
				}
			},
		});
		}
	});
});

function showPassword() {
	var x = document.getElementById("password");
	if (x.type === "password") {
		x.type = "text";
	} else {
		x.type = "password";
	}
}  

function validateregister() {
	var email = document.getElementById("email");
	var password = document.getElementById("password");
	var fname = document.getElementById("firstname");
	var lname = document.getElementById("lastname");
	var emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
	var passwordRegex = /^(?=.*\d)[a-zA-Z\d]{8,15}$/;
	var nameRegex = /^[a-zA-Z]/;
	if (!nameRegex.test(fname.value)) {
		alert("Enter Valid  First Name");
		firstname.style.border = "solid 3px #c40404";
		return false;
	}
	else if (!nameRegex.test(lname.value)) {
		alert("Enter Valid  Last Name");
		lastname.style.border = "solid 3px #c40404";
		return false;
	}
	else if (!emailRegex.test(email.value)) {
		alert("Enter Valid Email");
		email.style.border = "solid 3px #c40404";
		return false;
	}
	else if (!passwordRegex.test(password.value)) {
		alert("Password must contain at least one lowercase letter, one uppercase letter, one number, and be 8 characters long and upto 15 characters");
		password.style.border = "solid 3px #c40404";
		return false;
	}
	else {
		return true;
	}
}

function getImagePreview(event) {
	var image = URL.createObjectURL(event.target.files[0]);
	var imagediv = document.getElementById('preview');
	var newimg = document.createElement('img');
	imagediv.innerHTML = '';
	newimg.src = image;
	newimg.width = "100";
	imagediv.appendChild(newimg);
}