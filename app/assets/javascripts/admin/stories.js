function setupStoryTypeSelector() {

  var $img = $('.js-image');
  var $embed = $('.js-embed');

  function resetStoryFields(){
    $embed.find('textarea').val('');
    $img.find('input').val('');
  }

  function toggleStoryTypeFields(options){
    var default_options = {
      resetFields: false
    }
    options = $.extend({}, default_options, options);

    console.log('toggling story types')
    // if an image story type is selected, show the image field
    // else show the embed code field

    if (gon.image_stories && gon.embed_stories){
      var val = $('form.story #story_story_type_input select').val();

      console.log('val = ' + val)
      if ($.inArray(val, gon.image_stories) > -1 && !$img.is(':visible')){
        console.log('- image')
        // image
        // - show image / hide embed
        $embed.fadeOut(function(){
          if (options.resetFields){
            resetStoryFields();
          }
          $img.fadeIn();
        });

      } else if ($.inArray(val, gon.embed_stories) > -1 && !$embed.is(':visible')){
        console.log('- embed')
        // embed
        // - show embed / hide image
        $img.fadeOut(function(){
          if (options.resetFields){
            resetStoryFields();
          }
          $embed.fadeIn();
        });

      }
    }
  }

  $('form.story #story_story_type_input').on('change', 'select', function(){
    toggleStoryTypeFields({resetFields: true});
  });

  // set it when the page loads
  toggleStoryTypeFields();
}


