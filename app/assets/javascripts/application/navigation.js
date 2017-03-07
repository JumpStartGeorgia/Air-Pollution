var curr_height = 0;
var next_height = 0;

(function() {

  $(document).ready(function() {
  	set_navigation_height();
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

function set_navigation_height() {
	var navbar_left = 90;
	if($(window).width() < 650 || $(window).height() < 900 ) {
		navbar_left = 60;
	}
	$(".navbar-left").css("height", navbar_left + "px" );
}

function check_scrolled_height(resize_check, animate_check) {
	var scrollTop = 200;
	var navbar_left = 90;
	var anim_dur = 200;
	var lungs_width = $(".logo-with-lungs").width();
	if($(window).width() < 650 || $(window).height() < 900 ) {
		scrollTop = 70;
		navbar_left = 60;
	}

	if($(window).scrollTop() >= scrollTop){ 
		if(! $(".navbar-left").hasClass( "hide-lung") || resize_check ) {
			$(".navbar-left").addClass("hide-lung").stop(true,true).css("left", 0 );
			if(animate_check) {
				$(".navbar-left").animate({left: "-" + lungs_width + "px"}, anim_dur + 100, function(){
					$(".navbar-left").css("height", navbar_left + "px" );
					$(".navbar-left").animate({height: navbar_left - 30 + "px"}, anim_dur);
				});	
			} else {
				console.log(lungs_width);

				$(".navbar-left").css({"height": navbar_left - 30 + "px"});
				$(".navbar-left").css({"left": $(".logo-with-lungs").width() + "px"});
			}
		}

	} else {
		if( $(".navbar-left").hasClass("hide-lung") || resize_check) {
			$(".navbar-left").removeClass("hide-lung").stop(true,true).css("height", (navbar_left - 30) + "px");
			if(animate_check){
				$(".navbar-left").animate({ height: navbar_left + "px"},  anim_dur , function() {
					$(".navbar-left").css("left", "-" + lungs_width + "px");
					$(".navbar-left").animate({left: "0"},  anim_dur + 100);
				});
			} else {

				$(".navbar-left").css({"height": navbar_left + "px"}).css({"left": 0});
			}
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