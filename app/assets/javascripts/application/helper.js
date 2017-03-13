var is_touch;

function is_touch_device() {
  return 'ontouchstart' in window        // works on most browsers 
      || navigator.maxTouchPoints;       // works on IE10/11 and Surface
}

(function() {
 	is_touch = is_touch_device();
})();