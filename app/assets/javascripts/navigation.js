
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
	var scrollTop = 10;
	if($(window).scrollTop() >= scrollTop){ 
		if(! $( ".navbar-wrapper" ).hasClass( "hide_lungs") ) {
			$( ".navbar-wrapper" ).addClass( "hide_lungs");
		}
	} else {
		if( $( ".navbar-wrapper" ).hasClass( "hide_lungs") ) {
			$( ".navbar-wrapper").removeClass( "hide_lungs");
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

$(function(){
	skrollr.init(); 
});