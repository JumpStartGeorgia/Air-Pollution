var curr_height = 0;
var next_height = 0;

(function() {

  $(document).ready(function() {
  	check_scrolled_height(false, false);

  	$(window).scroll(function() {
	  check_scrolled_height(false, true);
	});

 	$(window).resize(function(){
 		check_scrolled_height(true, false);
 	});

  	dropdown_button_func();

  	search_func();

  });



})();

function check_scrolled_height(resize_check, animate_check) {
	var scrollTop = 200;
	var navbar_left = 90;
	if($(window).width() < 650 || $(window).height() < 900 ) {
		scrollTop = 70;
		navbar_left = 60;
	}

	if($(window).scrollTop() >= scrollTop){ 
		if(! $(".navbar-left").hasClass( "hide-lung") || resize_check ) {
			$(".navbar-left").addClass("hide-lung");
			$(".navbar-left").stop(true,true);
			$(".navbar-left").css("left", 0 );
			$(".navbar-left").animate({left: "-" + $(".logo-with-lungs").width() + "px"}, animate_check ? 200 : 1, function(){
				$(".navbar-left").css("height", navbar_left + "px" );
				$(".navbar-left").animate({height: ($(".navbar-left").height() - 30) + "px"},  animate_check ? 200 : 1);
			});
		}
	} else {
		if( $(".navbar-left").hasClass("hide-lung") || resize_check) {
			$(".navbar-left").removeClass("hide-lung");
			$(".navbar-left").stop(true,true);
			$(".navbar-left").css("height", (navbar_left - 30) + "px");
			$(".navbar-left").animate({ height: ($(".navbar-left").height() + 30) + "px"},  animate_check ? 200 : 1, function() {
				$(".navbar-left").animate({left: "0"},  animate_check ? 200 : 1);
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


function search_func() {

	$(".navbar-right .search-form").click(function(){
  		$(".navbar-right .search-form").addClass('search-active');
  		$(".navbar-right .search-form input").focus();
  	});

	$(function() {
	    $("body").click(function(e) {
	        if (!(e.target.id == "navbar-search-form" || $(e.target).parents("#navbar-search-form").size())) { 
	        	$(".navbar-right .search-form").removeClass('search-active');
  				$(".navbar-right .search-form input").val('');
	        } 
	    });
	})
}