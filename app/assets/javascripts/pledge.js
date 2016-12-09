$(document).on("page:change", function() {

  // if the user just submitted a peldge, tell them thank you
  if ($('.pledge-wrapper').data('made-pledge') == true){
    $(".fb-inline").fancybox({parent: 'body'});
    $(".fb-inline").eq(0).trigger('click');
  }

});


$(document).ready(function(){

	$('.all-pledges').slick({
	  infinite: true,
	  slidesToShow: 3,
	  slidesToScroll: 3
	});
			
});
		
