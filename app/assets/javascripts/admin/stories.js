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




function setupStoryCocoon(){

  // add datasource
  $('.js-cocoon .tab-pane').on('cocoon:after-insert', 'table.table-datasources', function(e, insertedItem) {
    var locale = $(this).data('locale');
    var page_locales = [];
    var row = $(insertedItem).clone();

    // get all locales except the active one
    $('.js-cocoon .tab-pane').each(function(){if ($(this).data('locale') != locale){page_locales.push($(this).data('locale'))}});

    // replace the locale and then add the row to the correct table
    for(var i=0;i<page_locales.length;i++){
      // update the inserted row with the appropriate locale
      $(row).html($(row).html().replace(new RegExp("_" + locale,"g"), '_' + page_locales[i]));
      // add the row
      $('.js-cocoon .tab-pane[data-locale="' + page_locales[i] + '"] table.table-datasources tbody').append($(row));
    }
  });

  // delete datasource
  $('.js-cocoon .tab-pane').on('cocoon:before-remove', 'table.table-datasources', function(e, deletedItem) {
    // get the datasource of the row being deleted so the same row for other languages can also be deleted
    var index = $(this).find('table.table-datasources tbody tr').index(deletedItem);

    // mark this row in every table as deleted
    $('.js-cocoon .tab-pane table.table-datasources tbody').each(function(){
      var row = $(this).find('tr')[index];
      // mark as deleted
      $(row).find('td:last input').val('true');
      // hide row
      $(row).fadeOut();
    });
  });

}
