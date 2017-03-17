
(function() {
 
  $(document).on('ready page:change', function() {

    // if a query string is present scroll down to the grid
    if ( $('body').hasClass('root') && $('body').hasClass('index') ){
      // get querystrings
      var qs = (function(a) {
        if (a == "") return {};
        var b = {};
        for (var i = 0; i < a.length; ++i)
        {
            var p=a[i].split('=', 2);
            if (p.length == 1)
                b[p[0]] = "";
            else
                b[p[0]] = decodeURIComponent(p[1].replace(/\+/g, " "));
        }
        return b;
      })(window.location.search.substr(1).split('&'));

      if (qs && (qs['type'] || qs['sort'] || qs['q'])){
        // scroll down
        var $container = $(".container .filter");
        if ($container){
          // wait a bit to make sure the highlight images have time to load and therefore set the correct top position
          setTimeout(function(){
            console.log($container.offset().top);

            var scroll_size = $container.offset().top;
            if (scroll_size > 0){
              scroll_size -= 115;
            }
            console.log(scroll_size);
            $('html, body').animate({scrollTop: scroll_size}, 1000);
          }, 1500);
        }
      }
    }

  });
})();

