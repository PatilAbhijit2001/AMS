var activityTimer;
var sessionTimeout;
var timeoutReset = false; 

function keepSessionAlive() {
    $.ajax({
        url: 'AllServletController?method=checkSession', 
        method: 'POST',
          success: function(response) {
            if (response === "true") {
                console.log('Session is alive.');
            } else {
                console.log('Session expired or invalid.');
                sessionTimeoutAlert(); 
            }
        },
    });
}

function resetSessionTimeout() {
    clearTimeout(sessionTimeout);
    sessionTimeout = setTimeout(sessionTimeoutAlert, 10000); //ms
}

function checkSessionPeriodically() {
    setInterval(keepSessionAlive, 10000); //ms
}

function sessionTimeoutAlert() {
	clearInterval(activityTimer);

	if (!timeoutReset) {
		$('#sessionTimeout').modal('show');
		timeoutReset = true;
	}
	$('#ok-button').click(function() {
		$.ajax({
			type: 'POST',
			url: 'AllServletController?method=logout',
			success: function(response) {
				if (response === "true") {
					window.location.href = 'Home.jsp';
				}
			}
		});
	});
}

$(document).ready(function() {
    $(document).on('mousemove keydown', function() {
        clearInterval(activityTimer);
        resetSessionTimeout(); 
        activityTimer = setInterval(keepSessionAlive, 100000); //ms
    });

    checkSessionPeriodically();
    resetSessionTimeout();
});