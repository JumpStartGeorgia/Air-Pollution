
var auto_slideshow;

(function() {

  $(document).ready(function() {
  	highlight_button_functions();
  	show_first_highlight();

  	auto_slideshow  = window.setInterval(change_highlight, 3500);

  });


})();

function highlight_button_functions() {
	$(".highlight-item-button").each(function(){
		var index = $(this).attr("data-index");
		$(this).click(function(){
			change_highlight(index);
			$(this).addClass("active");
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
	$(".highlight-item").first().show();
	$(".highlight-item-button").first().addClass("active");
}

function change_highlight(index, direction) {
	var highlights_num = $(".highlight-item").size();
	var curr_highlight = $(".highlight-item.active");
	var curr_highlight_button = $(".highlight-item-button.active");
	var curr_highlight_index = parseInt(curr_highlight.attr("data-index"));
	var next_highlight_index = 0;
	curr_highlight.removeClass("active");
	curr_highlight_button.removeClass("active");
	curr_highlight.hide();

	var manual_change = false;


	if( typeof direction === "undefined" ){
		direction = 1;
	} else {
		clearInterval(auto_slideshow);		
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

	$(".highlights-item").removeClass("active");
	$(".highlights-item").stop(true, true); 

	next_item.addClass('active');
	next_item.fadeIn(800);

	$(".highlights").find('.highlight-item-button:eq('+ (next_highlight_index) +')').addClass('active');

	if(manual_change){		
		auto_slideshow = window.setInterval(change_highlight, 6000);
	}
}