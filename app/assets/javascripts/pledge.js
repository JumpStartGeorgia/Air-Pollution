$(document).on("page:change", function() {

  // if the user just submitted a peldge, tell them thank you
  if ($('.pledge-wrapper').data('made-pledge') == true){
    $(".fb-inline").fancybox({parent: 'body'});
    $(".fb-inline").eq(0).trigger('click');
  }

});