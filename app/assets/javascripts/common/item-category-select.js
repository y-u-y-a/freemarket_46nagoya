$(document).on('turbolinks:load', function() {
  $('#category-select').change( function(){
    var child_category = $('#category-select select').val();
    if (child_category == '') {
      $('#child-category-select').html('');
    }
  })
});
