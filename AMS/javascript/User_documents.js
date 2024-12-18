$(document).ready(function() {
	checkAllDocuments();
});

$('#birthDoc').on('click', function(e) {
	e.preventDefault();

	var formData = new FormData($('#birth')[0]);
	formData.append('docType', 'birth');
	$.ajax({
		type: 'POST',
		url: 'AllServletController?method=insertDocuments',
		data: formData,
		processData: false,
		contentType: false,
		success: function(response) {
			if (response === "true") {
				checkAllDocuments();
				alert("Documents Uploaded Successful");
			} else {
				alert(response);
			}
		}
	})
})

$('#poaDoc').on('click', function(e) {
	e.preventDefault();
	var formData = new FormData($('#poa')[0]);
	formData.append('docType', 'poa');
	$.ajax({
		type: 'POST',
		url: 'AllServletController?method=insertDocuments',
		data: formData,
		processData: false,
		contentType: false,
		success: function(response) {
			checkAllDocuments();
			if (response === "true") {
				alert("Documents Uploaded Successful");
			} else {
				alert(response);
			}
		}
	})
})

$('#rcDoc').on('click', function(e) {
	e.preventDefault();

	var formData = new FormData($('#rc')[0]);
	formData.append('docType', 'rc');
	$.ajax({
		type: 'POST',
		url: 'AllServletController?method=insertDocuments',
		data: formData,
		processData: false,
		contentType: false,
		success: function(response) {
			checkAllDocuments();
			if (response === "true") {
				alert("Documents Uploaded Successful");
			} else {
				alert(response);
			}
		}
	})
})
$('#sdoc').on('click', function(e) {
	e.preventDefault();

	var formData = new FormData($('#sign')[0]);
	formData.append('docType', 'sign');
	$.ajax({
		type: 'POST',
		url: 'AllServletController?method=insertDocuments',
		data: formData,
		processData: false,
		contentType: false,
		success: function(response) {
			checkAllDocuments();
			if (response === "true") {
				alert("Documents Uploaded Successful");
			} else {
				alert(response);
			}
		}
	})
})

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

checkAllDocuments = function() {
	$.ajax({
		type: 'POST',
		url: 'AllServletController?method=checkDocuments',
		success: function(response) {
			console.log(response);
			var documents = JSON.parse(JSON.stringify(response));
			console.log(documents);
			console.log(documents.birthDoc);
			if (documents.birthDoc == false) {
				console.log("hi");
				$('#birthSubmit').show();
				$('#birthDocument').hide();
				$('#modalTrigger1').show();
				$('#modalTrigger1').click(function(event) {
					event.preventDefault();
					var myModal = new bootstrap.Modal($('#ModalForDoc'));
					var iframeSrc = contextPath + "/documents/" + documents.birth;
					document.getElementById('modalIframe').src = iframeSrc;
					myModal.show();
				});
			}
			if (documents.poaDoc == false) {
				$('#poaSubmit').show();
				$('#poaDocument').hide();
				$('#modalTrigger2').show();
				$('#modalTrigger2').click(function(event) {
					event.preventDefault();
					var myModal = new bootstrap.Modal($('#ModalForDoc'));
					var iframeSrc = contextPath + "/documents/" + documents.poa;
					document.getElementById('modalIframe').src = iframeSrc;
					myModal.show();
				});
			}
			if (documents.rcDoc == false) {
				$('#rcSubmit').show();
				$('#rcDocument').hide();
				$('#modalTrigger3').show();
				$('#modalTrigger3').click(function(event) {
					event.preventDefault();
					var myModal = new bootstrap.Modal($('#ModalForDoc'));
					var iframeSrc = contextPath + "/documents/" + documents.rc;
					document.getElementById('modalIframe').src = iframeSrc;
					myModal.show();
				});
			}
			if (documents.signDoc == false) {
				$('#signSubmit').show();
				$('#signDocument').hide();
				$('#modalTrigger4').show();
				$('#modalTrigger4').click(function(event) {
					event.preventDefault();
					var myModal = new bootstrap.Modal($('#ModalForDoc'));
					var iframeSrc = contextPath + "/documents/" + documents.sign;
					document.getElementById('modalIframe').src = iframeSrc;
					myModal.show();
				});
			}

		}
	})
}