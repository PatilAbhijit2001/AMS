$(document).ready(function() {debugger

	AllUserDetailsReport();
	allJuniors();


	$('#selectedUser').on('click', function(e) {
		e.preventDefault();

		var junior = $('#juniorSelect').val();
		var juniorName = $('#juniorSelect option:selected').text();

		var checkboxes = [];
		$('input[name="selected"]:checked').each(function() {
			var row = $(this).closest('tr');
			row.find("td:eq(12)").html(juniorName);
			checkboxes.push($(this).val());
			$(this).prop('checked', false).trigger('change');
		});
		$('#juniorSelect').val('');
		var dataString = checkboxes.join(',');

		$.ajax({
			type: 'POST',
			url: 'AllServletController?method=assign_users_to_juniors',
			data: {
				junior: junior,
				juniorName:juniorName,
				dataString: dataString,
				checkboxes: checkboxes
			},
			success: function(response) {
				if (response === "true") {
				} 
			},
		});
	});

	$('#register_form_submit').on('click', function(e) {debugger
		e.preventDefault();
		if (validateregister()) {
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
						$('#registerJunior').modal('hide');
					} else {
						alert("error occured try agian");
						$('#registerJunior').modal('show');
					}
				},
			});
		}
	});
	
	$('#logout').submit(function(e) {
		e.preventDefault();
		var formData = new FormData($('#logout')[0]);

		$.ajax({
			type: 'POST',
			url: 'AllServletController',
			data: formData,
			processData: false,
			contentType: false,
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
	$('#records').on('click', '#deleteButton', function(e) {
		e.preventDefault();
		var userid = $(this).val();
		var confirmDelete = confirm("Are you sure you want to delete this record?");
		if (confirmDelete) {
		$(this).closest('tr').remove();
			$.ajax({
				type: 'POST',
				url: 'DeleteServletController',
				data: {
					userId: userid
				},
				success: function(response) {
					if (response === "true") {
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
						$("#register").modal("toggle");
						$('#records').DataTable().ajax.reload();
					} else {
						alert("error occured");
					}
				},
			});
		}
	});

	$('#records').on('click', '#updateButton', function(e) {

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
	
	$('#records').on('click', '#documentButton', function (e) {
		e.preventDefault();
        var row = AllUserDetails.row($(this).parents('tr'));
        var data = row.data(); 
        var userId = data[1]; 
   
        $.ajax({
            url:  "AllServletController?method=selectDocuments",
            type: "POST",
            dataType: "json",
            data: { userId: userId },
            success: function(response) {
				var documents = JSON.parse(JSON.stringify(response));
                displayDocumentsTable(row, documents);
            },
        });
    });


	
function displayDocumentsTable(row, documents) {
    var tableHtml = '<table class="inner-table"><thead><tr><th>Document Type</th><th>Document Name</th></tr></thead><tbody>';

    for (var documentType in documents) {
		console.log(documentType);
        if (documents.hasOwnProperty(documentType)) {
            tableHtml += '<tr>';
            tableHtml += '<td>' + documentType + '</td>';

            tableHtml += '<td>' + '<a href="#" class="view-document" data-document="' + documents[documentType] + '">View Document</a>' + '</td>';
            tableHtml += '</tr>';
        }
    }

    tableHtml += '</tbody></table>';
        var childTable = $(tableHtml);

	if (row.child.isShown()) {
		row.child.hide();
	} else {
		row.child(childTable).show();
	}

    childTable.DataTable({
        "paging": false,
        "searching": false,
    });

    $('.view-document').click(function(e) {
    e.preventDefault();
    var documentSrc = $(this).data('document');
    var myModal = new bootstrap.Modal($('#ModalForDoc'));
    var iframeSrc = contextPath + "/documents/" + documentSrc;
    $('#modalIframe').attr('src', iframeSrc);
    myModal.show();
});

}

});

function allJuniors() {
	$.ajax({
		type: 'POST',
		url: 'AllServletController?method=selectAllJuniors',
		success: function(response) {
			var listJunior = JSON.parse(JSON.stringify(response));

			var selectElement = document.getElementById("juniorSelect");
			selectElement.innerHTML = "";
			var defaultOption = document.createElement("option");
			defaultOption.value = "";
			defaultOption.disabled = true;
			defaultOption.selected = true;
			defaultOption.hidden = true;
			defaultOption.textContent = "Select Junior";
			selectElement.appendChild(defaultOption);

			for (var i = 0; i < listJunior.length; i++) {
				var option = document.createElement("option");
				option.value = listJunior[i].id;
				option.text = listJunior[i].fname;
				selectElement.appendChild(option);
			}
		}
	})
}

AllUserDetailsReport = function() {

	var col = [
		{ title: "Check Boxes",bSortable: false},
		{ title: "User ID" ,bSortable: false},
		{ title: "First Name" ,bSortable: true},
		{ title: "Last Name" ,bSortable: false},
		{ title: "Email" ,bSortable: false},
		{ title: "DOB",bSortable: false },
		{ title: "Password",bSortable: false },
		{ title: "Gender",bSortable: false },
		{ title: "Country",bSortable: false },
		{ title: "Image" ,bSortable: false},
		{ title: "Delete" ,bSortable: false},
		{ title: "Update" ,bSortable: false},
		{ title: "Assigned to",bSortable: false},
		{ title: "Documents",bSortable : false}
	];

	 AllUserDetails = $('#records').DataTable({
		"ajax": {
			"url": contextPath + "/AllServletController?method=selectAllUsers",
			"type": "POST",
			"dataType": "json",
			"async":false,
			"dataSrc": function (json) {
            return json.data; 
        },
		},
		"searching": true,
		"serverSide": true,
		"responsive": true,
		"processing": true,
		"columns": col,
		"scrollY": 700,
		"paging": true,
		"lengthMenu": [10,20,30]
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
function showPasswordJunior() {
	var x = document.getElementById("juniorPassword");
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
function validateregister() {
	var email = document.getElementById("juniorEmail");
	var password = document.getElementById("juniorPassword");
	var fname = document.getElementById("jfirstname");
	var lname = document.getElementById("jlastname");
	var emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
	var passwordRegex = /^(?=.*\d)[a-zA-Z\d]{8,15}$/;
	var nameRegex = /^[a-zA-Z]/;
	if (!nameRegex.test(fname.value)) {
		alert("Enter Valid  First Name");
		jfirstname.style.border = "solid 3px #c40404";
		return false;
	}
	else if (!nameRegex.test(lname.value)) {
		alert("Enter Valid  Last Name");
		jlastname.style.border = "solid 3px #c40404";
		return false;
	}
	else if (!emailRegex.test(email.value)) {
		alert("Enter Valid Email");
		juniorEmail.style.border = "solid 3px #c40404";
		return false;
	}
	else if (!passwordRegex.test(password.value)) {
		alert("Password must contain at least one lowercase letter, one uppercase letter, one number, and be 8 characters long and upto 15 characters");
		juniorPassword.style.border = "solid 3px #c40404";
		return false;
	}
	else {
		return true;
	}
}