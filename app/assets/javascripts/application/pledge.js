$(document).on("page:change", function() {

  // if the user just submitted a peldge, tell them thank you
  if ($('.pledge-wrapper').data('made-pledge') == true){
    $(".fb-inline").fancybox({parent: 'body'});
    $(".fb-inline").eq(0).trigger('click');
  }

});


$(document).ready(function(){

	$('.all-pledges').slick({
	  dots: true,
	  infinite: false,
	  slidesToShow: 2,
	  slidesToScroll: 2,
	  responsive: [
	    {
	      breakpoint: 5000,
	      settings: {
	        slidesToShow: 3,
	        slidesToScroll: 3,
	        infinite: true,
	        dots: true
	      }
	    },
	    {
	      breakpoint: 1300,
	      settings: {
	        slidesToShow: 2,
	        slidesToScroll: 2
	      }
	    },
	    {
	      breakpoint: 880,
	      settings: {
	        slidesToShow: 1,
	        slidesToScroll: 1
	      }
	    }

	  ]
	});			
});
		
