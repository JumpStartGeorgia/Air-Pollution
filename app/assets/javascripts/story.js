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

$(document).on("page:change", function() {
  $(".fb-image").fancybox({parent: 'body', fitToView: false});

  var options = {parent: 'body'};
  if (!is_touch_device()){
    $inline = $(".fb-inline:first");

    var w = $(window).width()-100;
    var h = $(window).height()-100;

    switch($inline.data('type')){
      case 'radio': 
        options.minWidth = w > 500 ? 500 : w; 
        break;

      default: //fullscreen
        options.minWidth = w;
        options.minHeight = h;
        replace_iframe_sizes(w,h);
        break;
    }
  }
  $inline.fancybox(options);
});