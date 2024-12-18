
$(document).ready(function() {
	$('.delete-btn').on('click', function(e) {
		e.preventDefault();
		var userid = $(this).prev('input[name="DuserId"]').val();
		$.ajax({
			type: 'POST',
			url: 'DeleteServletController',
			data: {
				userId: userid
			},
			success: function(response) {
				if (response === "true") {
					alert("Deleted");
					window.location.href = 'AllUserDetails.jsp';
				}
				else{
					alert("error");
				}
			},
		});
	});
});

	