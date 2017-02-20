
var auto_slideshow;
var slideshow_time = 5000;
var higlight_height;

(function() {

  $(document).ready(function() {
  	highlight_button_functions();
  	show_first_highlight();
  	set_highlight_height();

  	auto_slideshow  = window.setTimeout(change_highlight, slideshow_time);

  	$(window).scroll(function() {
	 	change_highlight_height();
	});

 	$(window).resize(function(){
  		set_highlight_height();
 	});
  });

})();

function highlight_button_functions() {
	$(".highlight-item-button").each(function(){
		var index = $(this).attr("data-index");
		$(this).click(function(){
			change_highlight(index);
		});
	});

	$(".highlight-next-prev-button.prev").click(function(){
		change_highlight(null, -1);
	});
	$(".highlight-next-prev-button.next").click(function(){
		change_highlight(null, 1);
	});
}

function show_first_highlight() {
	$(".highlight-item").first().addClass("active");
	$(".highlight-item-button").first().addClass("active");
}

function change_highlight(index, direction) {
	var highlights_num = $(".highlight-item").size();
	var curr_highlight = $(".highlight-item.active");
	var curr_highlight_index = parseInt(curr_highlight.attr("data-index"));
	var next_highlight_index = 0;
	curr_highlight.removeClass("active");
	$(".highlight-item").stop(true, true); 
	$(".highlight-item-button").removeClass("active");

	var manual_change = false;
	clearTimeout(auto_slideshow);		


	if( typeof index === "undefined" ){
		direction = 1;
	} else {
		manual_change = !manual_change;
	}

	if(direction != null){
		if(curr_highlight_index + direction == highlights_num ) {
			next_highlight_index = 0;
		} else if(curr_highlight_index + direction == -1) {
			next_highlight_index = highlights_num - 1;
		} else {
			next_highlight_index = curr_highlight_index + direction;
		}
	} else {
		next_highlight_index = index;
	}

	var next_item = $(".highlights").find('.highlight-item:eq('+ (next_highlight_index) +')');
	next_item.addClass('active');

	$(".highlights").find('.highlight-item-button:eq('+ (next_highlight_index) +')').addClass('active');

	auto_slideshow = window.setTimeout(change_highlight, slideshow_time);
}

function set_highlight_height() {
	$(".highlights .highlight-image").css('height', '');
	highlights_height = $(".highlights .highlight-image").height();
}

function change_highlight_height() {
	 $(".highlights .highlight-image").css("height",  highlights_height);
}

