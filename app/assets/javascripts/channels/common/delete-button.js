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

  $('.delete-comment-btn').click(function(e){
    var val = (this.id);
    id = val.replace(/[^0-9]/g, "");
    var html = `comment_text_${id}`
    var comment = document.getElementById(html);
    $('body').append('<div class="is-overlay"></div>');
    $('.is-overlay').fadeIn(300);
    $(comment).fadeIn(400);
  });
  $('.modal-btn-cancel').click(function(e){
    var val = (this.id);
    id = val.replace(/[^0-9]/g, "");
    var html = `comment_text_${id}`
    var comment = document.getElementById(html);
    $(comment).fadeOut(400);
    $('.is-overlay').fadeOut(300);
    $('.is-overlay').remove();
    $('.delete-comment-btn').prop('disabled', false);
    $('.modal-btn-cancel').prop('disabled', false);
  });
});
