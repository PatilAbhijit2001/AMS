$(document).ready(function() {

	var userId = new URLSearchParams(window.location.search).get('userId');
	AllUserDetailsReport(userId);
});

$('#user_records').on('click', '#deleteButton', function(e) {
	e.preventDefault();
	var userid = $(this).val();
	var confirmDelete = confirm("Are you sure you want to delete this record?");
	if (confirmDelete) {
		$.ajax({
			type: 'POST',
			url: 'DeleteServletController',
			data: {
				userId: userid
			},
			success: function(response) {
				if (response === "true") {
					alert("Deleted");
					location.reload();
				}
				else {
					alert("error");
				}
			},
		});
	}
});

$('#update_user').on('click', function(e) {
	e.preventDefault();
	if (validate()) {

		var formData = new FormData($("#update_form")[0]);

		$.ajax({
			type: 'POST',
			url: 'AllServletController?method=update',
			data: formData,
			processData: false,
			contentType: false,
			success: function(response) {
				if (response === "true") {
					alert("Updation successful!");
					location.reload();
				} else {
					alert("error occured");
				}
			},
		});
	}
});

$('#user_records').on('click', '#updateButton', function(e) {
	e.preventDefault();
	var userid = $(this).val();

	$.ajax({
		type: 'POST',
		url: 'AllServletController?method=toUpdate',
		data: {
			userId: userid
		},
		success: function(response) {

			$("#register").modal("toggle");
			var user = JSON.parse(response);
			$("#firstname").val(user.fname);
			$("#lastname").val(user.lname);
			$("#email").val(user.email);
			$("#dob").val(user.dob);
			$("#password").val(user.password);
			if (user.gender === "male") {
				document.getElementById("male").checked = true;
			} else if (user.gender === "female") {
				document.getElementById("female").checked = true;
			}
			var countrySelect = document.getElementById("countrySelect");
			for (var index = 0; index < countrySelect.options.length; index++) {
				if (countrySelect.options[index].text === user.country) {
					countrySelect.options[index].selected = true;
					break;
				}
			}
			var roleSelect = document.getElementById("roleSelect");

			if (user.role === 2) {
				roleSelect.options[0].selected = true;
			}
			else {
				roleSelect.options[1].selected = true;
			}
			var imageName = user.image;
			var imagePath = contextPath + "/images/" + imageName;
			var imageElement = document.getElementById("dImg");
			imageElement.src = imagePath;
			$("#id").val(user.id);
		},
	});
});

$('#logoutButton').on('click', function() {
	$.ajax({
		type: 'POST',
		url: 'AllServletController?method=logout',
		success: function(response) {
			if (response === "true") {
				alert("Logout successful!");
				window.location.href = 'Home.jsp';
			} else {
				alert("error occured");
				window.location.href = 'Profile.jsp';
			}
		},
	});
});

function AllUserDetailsReport(userId) {
    var col = [
        
		{ title: "User ID", bSortable: false },
		{ title: "First Name", bSortable: true },
		{ title: "Last Name", bSortable: true },
		{ title: "Email", bSortable: true },
		{ title: "DOB", bSortable: false },
		{ title: "Password", bSortable: false },
		{ title: "Gender", bSortable: false },
		{ title: "Country", bSortable: false },
		{ title: "Image", bSortable: false },
		{ title: "Update", bSortable: false },
		{ title: "Delete", bSortable: false }
    ];
    
    $('#user_records').DataTable({
        "ajax": {
            "url": contextPath + "/AllServletController?method=selectJuniorUsers&userId=" + userId,
            "type": "POST",
            "dataType": "json",
            "dataSrc": ""
        },
        "searching": true,
        "serverSide": false,
        "paginate": true,
        "processing": true,
        "columns": col,
        "lengthMenu": [5, 10, 20]
    });
}

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