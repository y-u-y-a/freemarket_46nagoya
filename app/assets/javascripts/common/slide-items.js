$(document).on('turbolinks:load', function() {
  $('.owl-dot').hover(function(){
    $(this).removeClass('active');
    $('.active').css({'opacity':'','pointer':''});
    $(this).addClass('active');
    $(this).css({'opacity':'1','pointer':'default'});
  });
});
