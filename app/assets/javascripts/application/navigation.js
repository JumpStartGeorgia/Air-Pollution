var curr_height = 0;
var next_height = 0;
var logo_ratio = 1.25;

(function() {

  $(document).ready(function() {
  	set_navbar_height();
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


function set_navbar_height(){
	var navbar_left = $(".navbar-left");
	var navbar_left_height = 90;
	if($(window).width() < 650 || $(window).height() < 900 ) {
		navbar_left_height = 60;
	}
	navbar_left.css({"height": navbar_left_height + "px"});
}

function check_scrolled_height(resize_check, animate_check) {
	var scroll_top = 200;
	var navbar_left = $(".navbar-left");
	var navbar_left_height = 90;
	var anim_dur = 200;
	var lungs_width = $(".logo-with-lungs").height() * logo_ratio;
	if($(window).width() < 650 || $(window).height() < 900 ) {
		scroll_top = 70;
		navbar_left_height = 60;
	}

	if($(window).scrollTop() >= scroll_top){ //page is scrolled enough to hide logo
		if( !navbar_left.hasClass( "hide-lung") || resize_check ) { //logo is not hidden yet
			navbar_left.addClass("hide-lung").stop(true,true).css("left", 0 );
			if(animate_check) {
				navbar_left.animate({left: -1 * lungs_width + "px"}, anim_dur + 100, function(){
					navbar_left.css("height", navbar_left_height + "px" );
					navbar_left.animate({height: navbar_left_height - 30 + "px"}, anim_dur);
				});	
			} else {
				navbar_left.css({"height": navbar_left_height - 30 + "px"}).css({"left": -1 * lungs_width + "px"});
			}
		}
	} else { //when page is not scrolled
		if( navbar_left.hasClass("hide-lung") || resize_check) {
			navbar_left.removeClass("hide-lung").stop(true,true).css("height", (navbar_left_height - 30) + "px");
			if(animate_check){
				navbar_left.animate({ height: navbar_left_height + "px"},  anim_dur , function() {
					navbar_left.css("left", "-" + lungs_width + "px");
					navbar_left.animate({left: "0"},  anim_dur + 100);
				});
			} else {
				navbar_left.css({"height": navbar_left_height + "px"}).css({"left": 0});
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