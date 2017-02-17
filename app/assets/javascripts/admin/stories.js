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

    // if an image story type is selected, show the image field
    // else show the embed code field

    if (gon.image_stories && gon.embed_stories){
      var val = $('form.story #story_story_type_input select').val();

      if ($.inArray(val, gon.image_stories) > -1){
        // image
        // - show image / hide embed
        $embed.fadeOut(function(){
          if (options.resetFields){
            resetStoryFields();
          }
          $img.fadeIn();
        });

      } else if ($.inArray(val, gon.embed_stories) > -1){
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


  // when the modal is opened get the embed code and add it to the modal

  $('#modal-embed').on('show.bs.modal', function () {
    var embed = $('.tab-content .tab-pane.active .js-embed textarea').val();

    $(this).find('.modal-body').html(embed);

    $(this).find('.modal-body').focus();
  })
}


