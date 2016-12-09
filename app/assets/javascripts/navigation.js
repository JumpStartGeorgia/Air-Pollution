var curr_height = 0;
var next_height = 0;
(function() {

  $(document).ready(function() {
  	check_scrolled_height();

  	$(window).scroll(function() {
	  check_scrolled_height();
	});

  	dropdown_button_func();

  });


})();

function check_scrolled_height() {
	var scrollTop = 200;
	if($(window).width() < 650) {
		scrollTop = 70;
	}
	if($(window).scrollTop() >= scrollTop){ 
		if(! $(".navbar-left").hasClass( "navbar-change-height") ) {
			$(".navbar-wrapper .navbar-logo").stop(true, true); 
			$(".navbar-logo").fadeOut(200, function(){
				$(".navbar-logo").stop(true, true); 
				$(".navbar-left").addClass("navbar-change-height");
				$(".logo-with-lungs").addClass("no-display");
				$(".navbar-logo").fadeIn(200);
			});
		}
	} else {
		if( $(".navbar-left").hasClass( "navbar-change-height") ) {
			$("	.navbar-wrapper .navbar-logo").stop(true, true); 
			$(".navbar-logo").fadeOut(200, function(){
				$(".navbar-logo").stop(true, true); 
				$(".navbar-left").removeClass("navbar-change-height");
				$(".logo-with-lungs").removeClass("no-display");
				$(".navbar-logo").fadeIn(200);
			});
		}
	}
}


function dropdown_button_func() {
	$(".dropdown-button").click(function(){
		if ($(".navbar-right").hasClass("flex-display") ) {
			$( ".navbar-right" ).removeClass( "flex-display");
		}
		else {
			$( ".navbar-wrapper .navbar-right" ).addClass( "flex-display");
		}
	});
}

