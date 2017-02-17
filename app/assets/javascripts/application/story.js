function is_touch_device() {
  return 'ontouchstart' in window        // works on most browsers 
      || navigator.maxTouchPoints;       // works on IE10/11 and Surface
};

function replace_iframe_sizes(w,h){
  var $iframe = $('#fb-inline-content iframe:first');
  if ($iframe.length == 1){
    $iframe.attr('width', w);
    $iframe.attr('height', h);
  }
}

$(document).on("ready page:change", function() {
  if ($(".fb-image").length > 0 || $(".fb-inline").length > 0){
    $(".fb-image").fancybox({parent: 'body', fitToView: false, padding: 0});

    var options = {parent: 'body', padding: 0};
    if (!is_touch_device()){
      $inline = $(".fb-inline");
      if ($inline.length > 0){
        var w = $(window).width()-100;
        var h = $(window).height()-100;
        $inline.each(function(){
          var $t = $(this);
          switch($t.data('type')){
            case 'radio': 
              options.minWidth = w > 500 ? 500 : w; 
              break;

            default: //fullscreen
              options.minWidth = w;
              options.minHeight = h;
              replace_iframe_sizes(w,h);
              break;
          }
          $t.fancybox(options);
        });

      }
    }
  }
});