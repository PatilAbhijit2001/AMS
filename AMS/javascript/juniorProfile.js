$('#juniorUserDetailsButton').on('click', function() {

	var userId = $(this).attr('data-id');

	window.location.href = 'User_details_for_junior.jsp?userId=' + userId;
})