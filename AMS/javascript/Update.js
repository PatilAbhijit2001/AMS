function validate() {
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
		return false;
	}
	else if (!emailRegex.test(email.value)) {
		alert("Invalid Email");
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

$(document).ready(function() {
	$('form').submit(function(e) { 
		e.preventDefault();
		if(validate()){
			
			var formData = new FormData($(this)[0]);

		$.ajax({
			type: 'POST',
			url: 'AllServletController',
			data: formData,
			processData: false,
			contentType: false,
			success: function(response) {
				if (response === "true") {
					alert("Updation successful!");
					window.location.href = 'Profile.jsp';
				} else {
					alert("error occured");
					window.location.href = 'Update.jsp';
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

function getImagePreview(event) {
	var image = URL.createObjectURL(event.target.files[0]);
	var imagediv = document.getElementById('preview');
	var newimg = document.createElement('img');
	imagediv.innerHTML = '';
	newimg.src = image;
	newimg.width = "100";
	imagediv.appendChild(newimg);
}
