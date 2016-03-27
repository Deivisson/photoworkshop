$(document).on('ready page:load', function (){
	$(".order-menu-item").click(function(){
		$("#orders-menu > li").removeClass("selected");
		$(this).addClass("selected");
	});

	//Manager Pagseguro Feedback
	var timerOrderFeedback = null;
	if($("#order-transaction-feedback").length > 0){
		timerOrderFeedback = setInterval(CheckPaymentOrder,10000);	// - 7 segundos
	}
	setTimeout(function(){ 
		clearInterval(timerOrderFeedback);
		if ($("#order-transaction-feedback").length > 0) {
			$("#order-transaction-feedback").remove();
			$("#delayed-msg-feedback").css("display","block");
		}
	}, 60000);

});

function CheckPaymentOrder() {
	var id=0;
	if ($("#order-in-process-id").length > 0) {
		id = $("#order-in-process-id").val();	
		$.get("/user/orders/" + id + "/check_payment", function( data ) {});
	}
}
