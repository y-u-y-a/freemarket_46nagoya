$(document).on('turbolinks:load', function() {
  $('#delete-item').click(function(e){
    $('body').append('<div class="is-overlay"></div>');
    $('.is-overlay').fadeIn(300);
    $('.is-animate').fadeIn(400);
  });
  $('.modal-btn-cancel').click(function(){
    $('.is-animate').fadeOut(400);
    $('.is-overlay').fadeOut(300);
    $('.is-overlay').remove();
    $('#delete-item').prop('disabled', false);
    $('.modal-btn-cancel').prop('disabled', false);
  });
});
