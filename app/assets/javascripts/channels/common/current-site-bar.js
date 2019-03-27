$(document).on('turbolinks:load', function() {
  $('.mypage-nav__list li a').each(function(){
    var $href = $(this).attr('href');
    if(location.href.match($href)) {
      $(this).addClass('active');
      $(this).css({'background':'#eee','font-weight':'bold'});
      $(this).children().css('color','black');
    }
  });
});
