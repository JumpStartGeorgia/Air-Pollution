
(function() {
 
  $(document).on('ready page:change', function() {
    $('body').removeClass('touch').removeClass('no-touch');
    if(is_touch) {
      $('body').addClass('touch');
    } else {
      $('body').addClass('no-touch');
    }
  });
})();

